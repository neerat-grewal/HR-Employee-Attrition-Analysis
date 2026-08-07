# HR-Employee-Attrition-Analysis

**Overview**

A SQL-based analysis of the IBM HR Analytics Employee Attrition & Performance dataset (1,470 employees, 35 features), exploring which factors most strongly predict employee attrition.

**Tools**: SQLite, SQL (joins, aggregation, CASE/conditional logic)
**Dataset**: Public IBM HR Analytics Employee Attrition dataset

**Business Question:**

Which department has the highest attrition rate, and is it better explained by low job satisfaction and work-life balance, or by overtime workload?

**Method:**

7 SQL queries, each building on the last:

1. Attrition rate and satisfaction scores by department — baseline comparison across Sales, HR, and R&D
2. Attrition rate by overtime status — tests whether overtime alone predicts attrition
3. Attrition rate by department AND overtime — isolates whether overtime or department is the real driver
4. Attrition rate by job satisfaction
5. Job satisfaction gap between leavers and stayers, by department — tests a competing explanation (dissatisfaction vs. workload)
6. Attrition and satisfaction by commute distance band — an added dimension testing whether commute burden compounds the effect
7. Attrition and relationship satisfaction - to see if those in poor relationships has an impact on work

**Key Findings:**

Sales has the highest attrition rate (20.6%), followed by HR (19.0%) and R&D (13.8%)
Overtime is the strongest, most consistent driver: attrition nearly triples for employees working overtime (30.5%) vs. those who don't (10.4%) — and this holds across every department
Sales employees working overtime attrite at 37.5% — the highest-risk group in the dataset, more than double Sales' overall rate
Job satisfaction is modestly lower among leavers than stayers in every department, but the gap (roughly 0.3–0.5 points on a 4-point scale) is much smaller than the overtime effect — making overtime the clearer, more actionable signal
Commute distance compounds the effect: employees living farther from work show higher attrition across all departments (note: HR's subgroup counts are small once split by distance band, so this finding is directional rather than statistically robust)

**Conclusion:**

Overtime workload — not general job dissatisfaction — is the strongest and most consistent predictor of attrition, particularly in Sales. A targeted intervention (workload redistribution or overtime caps in Sales) is a more evidence-backed recommendation than a broad engagement initiative.
