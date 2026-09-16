# Sample Input — okr-kpi-builder

**Team/Function:** Data Platform Team
**Organization:** GrowthBase — B2B SaaS analytics company, 180 employees
**Planning period:** Q4 2026 (October–December)
**Team size:** 8 people (4 data engineers, 2 analysts, 1 PM, 1 DevOps)

**Strategic context:**
Company OKR for Q4: "Become the most trusted data platform for our customers." The CEO has said data reliability is the #1 customer complaint (from NPS survey). There's also a push to enable self-service reporting so the analytics team isn't the bottleneck.

**Team's goals (rough, from PM):**
1. Fix the data reliability problems — customers report stale dashboards ~3x/week
2. Reduce the time it takes for a new analyst to get insights from raw data
3. Enable 80% of standard reports to be self-served by business users (not via analyst request)

**Current baseline data:**
- Pipeline failure rate: 8% of daily jobs fail (industry benchmark: <1%)
- Data freshness: 73% of dashboards refresh within SLA (target: 95%)
- Analyst ticket queue: avg 4.5 days to fulfill data request
- Self-service report adoption: 12% of reports accessed without analyst help

**Constraints:**
- No new headcount
- Technical debt: legacy pipeline still on Spark 2.x (EOL); migration needed but not yet planned
- Data governance initiative is being launched by the company in parallel — team will need to contribute
