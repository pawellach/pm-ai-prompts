# Sample Input — change-impact-assessment

**Change:** Migrate customer support operations from email-only (shared inbox) to Salesforce Service Cloud
**Organization:** Meditech S.A. — medical equipment distributor, 450 employees
**Change sponsor:** VP Operations — Monika Zielińska

**Current state:**
- 15 support agents share 2 email inboxes (technical support + billing)
- 3 team leaders manage manually by reading emails and assigning to agents
- No ticketing system — email threads are the only record
- Cases tracked in Excel spreadsheet (manually updated)
- Average response time: 6 hours
- Customer CSAT: unknown (no measurement system)

**Target state:**
- Salesforce Service Cloud with case management, routing rules, SLA tracking
- Email-to-case integration (emails still received, auto-converted to cases)
- Knowledge base for agents (articles + FAQ)
- Customer CSAT survey after case close
- Go-live planned: Q1 2027 (4 months away)

**Affected groups:**
- 15 support agents — main users; will need training on SF
- 3 team leaders — will use dashboards, routing rules, reports instead of manual email reading
- 3 managers (VP Ops, IT Manager, Finance) — will use reports/dashboards only
- IT team (2 people) — will own the implementation and ongoing admin
- Customers — will receive auto-confirmations and CSAT surveys (new experience)
- Billing team (5 people) — currently shares one of the email inboxes; will be moved to SF too

**Known concerns:**
- Agents are worried about being "monitored more closely" via SLA metrics
- One team leader (Artur) is resistant — he built the Excel tracker and sees SF as a threat
- IT team has never administered Salesforce before — will need external support
