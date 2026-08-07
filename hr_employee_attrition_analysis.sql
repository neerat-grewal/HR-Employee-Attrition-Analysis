 -- Business question: Which department has the highest attrition rate, and which variables are impacting it?

-- 1. Attrition rate and average satisfaction scores by department
SELECT
    Department,
    COUNT(*) AS Headcount,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS [Attrition Rate Percentage],
    ROUND(AVG(JobSatisfaction), 2) AS [Average Job Satisfaction],
    ROUND(AVG(EnvironmentSatisfaction), 2) AS [Average Environment Satisfaction],
    ROUND(AVG(WorkLifeBalance), 2) AS [Average Work Life Balance]
FROM employees
GROUP BY Department
ORDER BY [Attrition Rate Percentage] DESC;
-- Results show that sales has the highest attrition (employee turnover) at 20.6%, followed by HR at 19% and R&D at 13.8%

-- 2. Attrition rate by overtime status, overall
SELECT
    OverTime,
    COUNT(*) AS Headcount,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS [Attrition Rate Percentage]
FROM employees
GROUP BY OverTime;
-- Results show that employees who work OverTime have higher attrition than those who don't (30.5% vs 10.4%)

-- 3. Attrition rate by department AND overtime, to isolate the driver
SELECT
    Department,
    OverTime,
    COUNT(*) AS Headcount,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS [Attrition Rate Percentage]
FROM employees
GROUP BY Department, OverTime
ORDER BY Department, OverTime;
-- Results show that sales people who work overtime had the highest attrition at 37.5% whereas R&D folks who didn't work overtime had the lowest attrition at 8.6%.
-- Results also showed that employees that worked overtime, regardless of department had high attrition rates (over 27%)

-- 4. Job satisfaction vs Attrition
SELECT
    JobSatisfaction,
    COUNT(*) AS Headcount,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS [Attrition Rate Percentage]
FROM employees
GROUP BY JobSatisfaction
ORDER BY [Attrition Rate Percentage] DESC;

--Results show that employees who reported the lowest job satisfaction had the highest attrition at 22.8%, whereas employees that had the highest job satisfaction had the
-- lowest average attrition rate at 11.3%.

-- 5. Job satisfaction gap between stayers and leavers, by department
SELECT
    Department,
    ROUND(AVG(CASE WHEN Attrition = 'Yes' THEN JobSatisfaction END), 2) AS [Average Job Satisfication of Leavers],
    ROUND(AVG(CASE WHEN Attrition = 'No' THEN JobSatisfaction END), 2) AS [Average Job Satisfication of Stayers]
FROM employees
GROUP BY Department;
-- Results show that stayers have a higher job satisfication than leavers across all departments.

-- 6. Job satisfication and Attrition Based on Distance to Work
SELECT
    Department,
    CASE
        WHEN DistanceFromHome <= 5 THEN 'Near (1-5 km)'
        WHEN DistanceFromHome <= 15 THEN 'Moderate (6-15 km)'
        ELSE 'Far (16-29 km)'
    END AS distance_band,
    ROUND(AVG(JobSatisfaction), 2) AS "Average Job Satification",
    COUNT(*) AS Headcount,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS [Attrition Rate Percentage]
FROM employees
GROUP BY Department, distance_band
ORDER BY Department, distance_band DESC;

-- Results show that those that live far from work (16-29 km away) have higher attrition rates across HR and Sales compared to those that live near work (1-5 km).
-- Distance to work did not affect attrition as much for the R&D department.
-- Note, however, that the HR department has a significantly lower headcount so this may skew the results.

-- 7. Comparing RelationshipSatisfaction with Attrition:
SELECT
    RelationshipSatisfaction,
    COUNT(*) AS Headcount,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS [Attrition Rate Percentage]
FROM employees
GROUP BY RelationshipSatisfaction
ORDER BY RelationshipSatisfaction;

-- Results show that employees with the lowest RelationshipSatisfaction at 1 had the highest attrition rate at 20.7%, whereas anything above that are clustered around
-- 14.8-15.5%, so there isn't as much if a difference in attrition for those with a moderate relationship satisfaction and a very positive relationship satisfaction.
