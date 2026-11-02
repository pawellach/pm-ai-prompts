---
name: sf-create-user
description: Create Salesforce internal users from supplied employee data or a benchmark user, resolve FederationIdentifier conflicts, and reproduce the benchmark's licensed permissions safely. Use for Salesforce user provisioning in sandboxes or production; do not use for Experience Cloud-only users or unrelated permission audits.
---

# Salesforce — Create Internal User

Create one or more Salesforce internal users from explicit input data or from a benchmark user's configuration. The workflow is designed to be reusable across orgs: never assume organisation-specific IDs, names, domains, permission sets, licenses, profiles, roles, or namespaces.

## Operating rules

- Treat every value surrounded by `<...>` as an input placeholder. Resolve it from the target org or ask the operator; never invent a Salesforce ID.
- Before any DML, show a dry-run summary containing the target org, users to create, FederationIds, profile/role sources, benchmark source, permission scope, and records that would be deactivated or modified. Continue only after explicit confirmation.
- Prefer SOQL lookup by stable names or developer names over hardcoded IDs. Confirm that each lookup returns exactly one intended record.
- Do not copy secrets, passwords, tokens, or production data into prompts, scripts, logs, or generated documentation.
- Use partial-success DML and report every success and failure. Do not retry a failed batch blindly.

## Required inputs

Collect:

| Input | Example placeholder | Notes |
|---|---|---|
| Target org | `<TARGET_ORG_ALIAS>` | Salesforce CLI alias; confirm sandbox or production |
| New user data | `<USERS_JSON_OR_TABLE>` | First name, last name, email, username, FederationId, alias, locale, timezone |
| Profile | `<PROFILE_NAME_OR_ID>` | Resolve by name when possible |
| Role | `<ROLE_NAME_OR_ID>` | Optional; resolve by name when supplied |
| Manager | `<MANAGER_EMAIL_OR_ID>` | Optional; resolve by email when supplied |
| Benchmark user | `<BENCHMARK_EMAIL_OR_ID>` | Optional; use when permission configuration should be cloned |
| Explicit permission scope | `<PSL_PSG_PS_SCOPE>` | Optional; benchmark permissions take precedence only when requested |
| DocuSign activation | `<DOCUSIGN_REQUIRED>` | Optional and only when the namespace/field exists in the org |

For a benchmark-driven request, first inspect the benchmark's profile, role, locale, timezone, permission set licenses, permission set groups, standalone permission sets, and package licenses. Flag differences instead of silently copying them.

## 1. Resolve org metadata and benchmark configuration

Use the Salesforce CLI with the supplied alias:

```bash
sf org display --target-org <TARGET_ORG_ALIAS>
sf data query --target-org <TARGET_ORG_ALIAS> --query "SELECT Id, Name FROM Profile WHERE Name = '<PROFILE_NAME>'"
sf data query --target-org <TARGET_ORG_ALIAS> --query "SELECT Id, Name FROM UserRole WHERE Name = '<ROLE_NAME>'"
sf data query --target-org <TARGET_ORG_ALIAS> --query "SELECT Id, Name, Username, IsActive FROM User WHERE Id = '<BENCHMARK_USER_ID>'"
```

When cloning a benchmark, collect the configuration with these queries (adapt field names only when the target org requires it):

```sql
SELECT PermissionSetLicenseId, PermissionSetLicense.DeveloperName,
       PermissionSetLicense.MasterLabel
FROM PermissionSetLicenseAssign
WHERE AssigneeId = '<BENCHMARK_USER_ID>'

SELECT PermissionSetGroupId, PermissionSetGroup.DeveloperName,
       PermissionSetGroup.MasterLabel
FROM PermissionSetAssignment
WHERE AssigneeId = '<BENCHMARK_USER_ID>'
  AND PermissionSetGroupId != null

SELECT PermissionSetId, PermissionSet.DeveloperName, PermissionSet.Name
FROM PermissionSetAssignment
WHERE AssigneeId = '<BENCHMARK_USER_ID>'
  AND PermissionSetGroupId = null
  AND PermissionSet.IsOwnedByProfile = false
```

Do not assume that a permission set, permission set group, or license exists in the target org. Resolve each by developer name or label and stop for review when it is missing or ambiguous.

## 2. Check FederationIdentifier and nickname conflicts

Before inserting users, query each requested FederationId:

```bash
sf data query --target-org <TARGET_ORG_ALIAS> --query "SELECT Id, Name, Username, IsActive, UserType, Profile.Name, FederationIdentifier, CommunityNickname FROM User WHERE FederationIdentifier IN ('<FEDERATION_ID_1>', '<FEDERATION_ID_2>') ORDER BY IsActive DESC"
```

If a sandbox refresh left an inactive Experience Cloud/Community user holding a FederationId, report the exact conflicting user and request approval to deactivate it and clear only its FederationIdentifier. Do not change a community user's Profile through DML. Check CommunityNickname separately because deactivated users may still reserve it.

Do not clear a FederationId merely to make the insert succeed. Production conflicts, active-user conflicts, or conflicts whose ownership is unclear require an operator decision.

## 3. Create internal users

Build the insert from resolved metadata and supplied user data. The following is a template only; replace every placeholder with validated values:

```apex
List<User> usersToInsert = new List<User>{
    new User(
        FirstName = '<FIRST_NAME>',
        LastName = '<LAST_NAME>',
        Email = '<EMAIL>',
        Username = '<GLOBALLY_UNIQUE_USERNAME>',
        FederationIdentifier = '<FEDERATION_ID>',
        Alias = '<UNIQUE_ALIAS>',
        CommunityNickname = '<UNIQUE_COMMUNITY_NICKNAME>',
        EmailEncodingKey = 'UTF-8',
        LanguageLocaleKey = '<LANGUAGE_LOCALE_KEY>',
        LocaleSidKey = '<LOCALE_SID_KEY>',
        TimeZoneSidKey = '<TIME_ZONE_SID_KEY>',
        ProfileId = '<PROFILE_ID>',
        UserRoleId = '<ROLE_ID>',
        ManagerId = '<MANAGER_ID>',
        IsActive = true
    )
};

Database.SaveResult[] results = Database.insert(usersToInsert, false);
for (Integer i = 0; i < results.size(); i++) {
    if (results[i].isSuccess()) {
        System.debug('CREATED_USER_ID=' + results[i].getId());
    } else {
        for (Database.Error err : results[i].getErrors()) {
            System.debug('CREATE_ERROR[' + i + ']=' + err.getMessage());
        }
    }
}
```

Username must be globally unique. Use the organisation's documented sandbox suffix convention; never infer it from a personal example. Alias and CommunityNickname must also be unique in the target org.

## 4. Assign permissions in dependency order

When permission configuration is requested, assign in this order:

1. Permission Set Licenses (PSL)
2. Permission Set Groups (PSG)
3. Standalone Permission Sets (PS)
4. Optional package-specific user license or activation fields, only when explicitly requested and verified

Use deduplication queries before each insert. For each target user, record the source benchmark item, resolved target ID, result, and error message. A PSG that requires a license must never be assigned before its PSL. Split large batches when triggers or managed packages make the batch unreliable.

The assignment template should use resolved IDs, not organisation-specific literals:

```apex
// <NEW_USER_IDS>, <RESOLVED_PSL_IDS>, <RESOLVED_PSG_IDS>, and <RESOLVED_PS_IDS>
// are generated only after the lookup and dry-run review.
// Insert missing PSL assignments first, then PSG assignments, then standalone PS assignments.
```

If the benchmark contains profile-owned permissions, explain that they are not standalone Permission Set assignments and cannot be cloned by inserting PSAs.

## 5. Optional package activation

Only if `<DOCUSIGN_REQUIRED>` is true and the target org exposes the verified package field, query the field metadata and update the new users with partial-success DML. If the namespace or field is absent, report that the package is not installed/configured; do not guess a replacement field.

## 6. Verify and report

After each mutation, verify:

```sql
SELECT Id, Name, Username, IsActive, Profile.Name, UserRole.Name,
       ManagerId, FederationIdentifier, CommunityNickname
FROM User
WHERE Id IN (<NEW_USER_IDS>)

SELECT AssigneeId, PermissionSetLicense.DeveloperName
FROM PermissionSetLicenseAssign
WHERE AssigneeId IN (<NEW_USER_IDS>)

SELECT AssigneeId, PermissionSetGroup.DeveloperName, PermissionSet.DeveloperName
FROM PermissionSetAssignment
WHERE AssigneeId IN (<NEW_USER_IDS>)
```

Return a concise result table per user: created user ID, FederationId, profile, role, manager, PSL/PSG/PS counts, standalone PS count, optional package status, and failures requiring manual action. Never include credentials or unrelated user data.

## Common failure handling

| Error | Likely cause | Safe response |
|---|---|---|
| `FederationIdentifier is already in use` | Another user owns the FedId, often after a sandbox refresh | Inspect the owner; clear/deactivate only after explicit approval |
| Duplicate community nickname | A current or deactivated user reserves it | Choose a reviewed unique nickname |
| PSG requires a license | PSL missing or assigned too late | Assign the required PSL, then retry only the failed PSG assignment |
| Too many retries of batch save | Managed-package trigger/batch cascade | Inspect first failure and split the batch |
| Profile/role not found | Metadata differs between orgs | Stop and ask for the intended target metadata |
| Package field unavailable | Package is absent or version differs | Skip optional activation and report it |
