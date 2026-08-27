# salesforce-create-internal-user — Claude Code skill

> **No plugins required.** Works with Salesforce CLI (`sf`) and anonymous Apex execution.
> **Requires:** `sf` CLI authenticated to your org (`sf org login web --alias myorg`).
>
> To use as a skill in your own project, copy this file to `.claude/skills/salesforce-create-internal-user/SKILL.md`.
> The skill activates via `/salesforce-create-internal-user` command in Claude Code.

---
---
name: salesforce-create-internal-user
description: "Create Salesforce internal (standard) user accounts, handle FederationIdentifier conflicts caused by sandbox refresh Community users, and assign licenses in the correct order (PSL → PSG → PS). Use when: (1) creating internal user accounts on sandbox or production, (2) seeing 'FederationIdentifier is already in use' errors, (3) needing to clone permissions from a benchmark user, (4) assigning Salesforce CPQ or Advanced Approvals licenses."
---

# Salesforce — Create Internal Users

## Keywords

create user, internal user, new employee account, FederationIdentifier conflict, federation identifier already in use, sandbox refresh, Community user conflict, PSL, permission set license, PSG, permission set group, CPQ license, Advanced Approvals license, DocuSign active, Too many retries, clone permissions, benchmark user

## Overview

Creating Salesforce internal users sounds simple but has several hidden traps — especially on sandboxes refreshed from production. This skill walks through conflict detection, user creation, and the mandatory license assignment order that prevents cascade failures.

**Use this skill when:**
- A new employee needs a Salesforce account
- Sandbox refresh left ghost Community users blocking new accounts
- PSG assignment fails with "requires a license" or "Too many retries"
- You need to clone permissions from an existing user of the same role

---

## Step 0 — Gather inputs

Before writing any Apex, collect:

| Data | How to find it |
|---|---|
| Profile ID (`00e...`) | `sf data query --target-org <alias> --query "SELECT Id, Name FROM Profile WHERE Name = 'Your Profile Name'"` |
| UserRole ID (`00E...`) | `sf data query --target-org <alias> --query "SELECT Id, Name FROM UserRole WHERE Name = 'Your Role Name'"` |
| Manager ID (`005...`) | `sf data query --target-org <alias> --query "SELECT Id, Name FROM User WHERE Email = 'manager@company.com'"` |
| Benchmark user ID | `sf data query --target-org <alias> --query "SELECT Id, Name FROM User WHERE Email = 'benchmark@company.com'"` |
| Target org alias | `partial` (sandbox) or `prod` (production) |

---

## Step 1 — Detect FederationIdentifier conflicts

Before creating a new internal user, check if the FedId is already taken:

```bash
sf data query --target-org <alias> --query "SELECT Id, Name, Username, IsActive, UserType, FederationIdentifier FROM User WHERE FederationIdentifier IN ('jan.kowalski@company.com') ORDER BY IsActive DESC"
```

**If result contains a `PowerCustomerSuccess` (Community) user** — this is a sandbox refresh artifact. The new internal user cannot be created until the Community user releases the FedId.

### Fix: deactivate Community users and clear FedId

```apex
// Step 1a — Deactivate Community users and clear FederationIdentifier
// Run BEFORE creating the new internal user
List<User> communityToFix = new List<User>{
    new User(Id='005...',  IsActive=false, FederationIdentifier=null),
    new User(Id='005...2', IsActive=false, FederationIdentifier=null)
};
Database.SaveResult[] r = Database.update(communityToFix, false);
for (Database.SaveResult sr : r) {
    if (!sr.isSuccess()) System.debug('ERR: ' + sr.getErrors()[0].getMessage());
}
System.debug('Community users deactivated: ' + r.size());

// Note: you CANNOT change the Profile on Community users via DML.
// Deactivate them and create brand new internal users instead.
```

---

## Step 2 — Create the internal user

```apex
User u = new User(
    FirstName='Jan', LastName='Kowalski',
    Email='jan.kowalski@company.com',
    // Sandbox: Username = email + '.sandbox-suffix'
    // Production: Username = email
    Username='jan.kowalski@company.com.sandbox',
    FederationIdentifier='jan.kowalski@company.com',
    Alias='jkowalski',
    // CommunityNickname must be unique across ALL users (including deactivated).
    // If the deactivated Community user had 'jan.kowalski', use 'jan.kowalski2'.
    CommunityNickname='jan.kowalski',
    EmailEncodingKey='UTF-8',
    LanguageLocaleKey='en_US',
    LocaleSidKey='en_US',
    TimeZoneSidKey='America/New_York',
    ProfileId='00e...',
    UserRoleId='00E...',
    ManagerId='005...',
    IsActive=true
);
insert u;
System.debug('User created: ' + u.Id);
```

**Username convention:**
- Sandbox: `email@company.com.sandboxname` (must be unique across all Salesforce orgs globally)
- Production: `email@company.com`

**CommunityNickname tip:** even deactivated users hold their nickname. If you get a duplicate error, append a suffix like `jan.kowalski2`.

---

## Step 3 — Assign licenses in the MANDATORY order

> **Critical:** PSGs containing CPQ or Advanced Approvals objects have a hard requirement on Permission Set Licenses (PSL). Assigning a PSG before its required PSL causes `"requires a license"` errors, which trigger a cascade `"Too many retries of batch save"` failure for the entire batch. **Always follow: PSL → PSG → PS.**

### Step 3a — Clone PSLs from benchmark user

First, see what PSLs the benchmark user has:

```bash
sf data query --target-org <alias> --query "SELECT PermissionSetLicenseId, PermissionSetLicense.DeveloperName, PermissionSetLicense.MasterLabel FROM PermissionSetLicenseAssign WHERE AssigneeId = '<benchmark_id>'"
```

Then assign to new users (with dedup check):

```apex
List<Id> allIds = new List<Id>{ '005...edyta', '005...ewelina' }; // new users

// Get PSL IDs from the query above, e.g.:
List<Id> pslIds = new List<Id>{
    '0PL...',  // Sales User
    '0PL...',  // Salesforce CPQ License
    '0PL...'   // Salesforce CPQ AA License
};

// Dedup check — safe to re-run
Set<String> existing = new Set<String>();
for (PermissionSetLicenseAssign psla : [
    SELECT AssigneeId, PermissionSetLicenseId FROM PermissionSetLicenseAssign
    WHERE AssigneeId IN :allIds
]) {
    existing.add('' + psla.AssigneeId + '_' + psla.PermissionSetLicenseId);
}

List<PermissionSetLicenseAssign> toInsert = new List<PermissionSetLicenseAssign>();
for (Id uid : allIds) {
    for (Id pslId : pslIds) {
        if (!existing.contains('' + uid + '_' + pslId)) {
            toInsert.add(new PermissionSetLicenseAssign(AssigneeId=uid, PermissionSetLicenseId=pslId));
        }
    }
}
Database.SaveResult[] r = Database.insert(toInsert, false);
Integer ok=0, fail=0;
for (Database.SaveResult sr : r) {
    if (sr.isSuccess()) ok++; else { fail++; System.debug('PSL ERR: ' + sr.getErrors()[0].getMessage()); }
}
System.debug('PSL: ' + ok + ' ok / ' + fail + ' failed');
```

> **Why `UserPackageLicense` is NOT enough:** `UserPackageLicense` (key prefix `050`) handles general managed package access, but CPQ Permission Set Groups validate against `PermissionSetLicenseAssign` (key prefix `0PL`). Both exist independently — you need the PSL assignment.

### Step 3b — Assign Permission Set Groups (PSG)

```apex
// Query PSG IDs by name (safer than hardcoding)
Map<String, Id> psgIds = new Map<String, Id>();
for (PermissionSetGroup pg : [
    SELECT Id, MasterLabel FROM PermissionSetGroup
    WHERE MasterLabel IN ('YourPSGName1', 'YourPSGName2')
]) {
    psgIds.put(pg.MasterLabel, pg.Id);
}

// Dedup + assign
Set<String> existingPSG = new Set<String>();
for (PermissionSetAssignment psa : [
    SELECT AssigneeId, PermissionSetGroupId FROM PermissionSetAssignment
    WHERE AssigneeId IN :allIds AND PermissionSetGroupId != null
]) {
    existingPSG.add('' + psa.AssigneeId + '_' + psa.PermissionSetGroupId);
}

List<PermissionSetAssignment> psgToInsert = new List<PermissionSetAssignment>();
for (Id uid : allIds) {
    for (Id psgId : psgIds.values()) {
        if (!existingPSG.contains('' + uid + '_' + psgId)) {
            psgToInsert.add(new PermissionSetAssignment(AssigneeId=uid, PermissionSetGroupId=psgId));
        }
    }
}
Database.SaveResult[] r = Database.insert(psgToInsert, false);
// ... log results
```

### Step 3c — Assign standalone Permission Sets (PS)

Get the PS IDs from the benchmark user first:

```bash
sf data query --target-org <alias> --query "SELECT PermissionSetId, PermissionSet.Name FROM PermissionSetAssignment WHERE AssigneeId = '<benchmark_id>' AND PermissionSetGroupId = null AND PermissionSet.IsOwnedByProfile = false"
```

Then assign with dedup:

```apex
List<Id> standalonePsIds = new List<Id>{ '0PS...', '0PS...' }; // from query above

Set<String> existingPS = new Set<String>();
for (PermissionSetAssignment psa : [
    SELECT AssigneeId, PermissionSetId FROM PermissionSetAssignment
    WHERE AssigneeId IN :allIds AND PermissionSetGroupId = null
]) {
    existingPS.add('' + psa.AssigneeId + '_' + psa.PermissionSetId);
}

List<PermissionSetAssignment> psToInsert = new List<PermissionSetAssignment>();
for (Id uid : allIds) {
    for (Id psId : standalonePsIds) {
        if (!existingPS.contains('' + uid + '_' + psId)) {
            psToInsert.add(new PermissionSetAssignment(AssigneeId=uid, PermissionSetId=psId));
        }
    }
}
Database.insert(psToInsert, false);
```

---

## Step 4 — Activate DocuSign (if applicable)

If your org uses Docusign Apps Launcher (`dfsle` namespace):

```apex
List<User> dsUpd = new List<User>();
for (Id uid : allIds) {
    dsUpd.add(new User(Id=uid, dfsle__Status__c='Active'));
}
Database.update(dsUpd, false);
// dfsle__Status__c values: 'Active' | 'Pending' | 'Inactive'
```

---

## Sandbox vs Production differences

| Aspect | Sandbox | Production |
|---|---|---|
| `--target-org` | your sandbox alias | `prod` or production alias |
| Username format | `email@company.com.sandboxname` | `email@company.com` |
| FedId conflicts | Common after refresh (Community users) | Unlikely, but check first |
| PSL / PSG / PS IDs | Same as production (sandbox is a copy) | Source of truth |
| DML access | Full | Check with team before running scripts |

---

## Troubleshooting

| Error | Cause | Fix |
|---|---|---|
| `FederationIdentifier is already in use` | Community user (sandbox refresh) holds FedId | Step 1: deactivate + set `FederationIdentifier=null` |
| `This permission set group contains custom object(s) that require a license` | PSG assigned before PSL | Assign PSL (Step 3a) before PSG (Step 3b) |
| `Too many retries of batch save in the presence of Apex triggers` | Cascade failure — one insert fails, triggers retry loop | Check PSL assignment; split large batches |
| `DUPLICATE_VALUE on CommunityNickname` | Deactivated user still holds the nickname | Append suffix: `jan.kowalski2` |
| `dfsle__Status__c: field not available` | DocuSign not installed | Check Setup → Installed Packages for `dfsle` namespace |
| `CANNOT_INSERT_UPDATE_ACTIVATE_ENTITY on Profile change` | Tried to change Profile on Community user via DML | Cannot be done — deactivate + create new internal user |
