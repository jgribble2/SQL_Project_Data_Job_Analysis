-- From the job_postings_fact table, categorize the salaries from job postings that are data analyst jobs and who have a yearly salary information 
-- Put salary into 3 different categories:
-- 1. If the salary_year_avg is greater than $100,000 then return ‘high salary’
-- 2. If the salary_year_avg is between $60,000 and $99,999 return ‘Standard salary’
-- 3. If the salary_year_avg is below $60,000 return ‘Low salary’
-- Order from the highest to lowest salaries

SELECT
    job_id,
    job_title,
    salary_year_avg,
    CASE
        WHEN salary_year_avg > '100000' THEN 'high_salary'
        WHEN salary_year_avg BETWEEN '60000' AND '99999' THEN 'standard_salary'
        ELSE 'low_salary'
    END AS salary_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC;