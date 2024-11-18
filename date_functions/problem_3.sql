-- Find companies (include company name) that have posted jobs offering health insurance, where these postings were made in the second quarter of 2023
-- Use date extraction to filter by quarter
-- Order by the job postings count from highest to lowest

SELECT
    company_dim.name AS company,
    COUNT(job_postings_fact.job_id) AS count_of_jobs
FROM
    job_postings_fact
INNER JOIN
    company_dim
ON job_postings_fact.company_id = company_dim.company_id
WHERE
    EXTRACT(QUARTER FROM job_posted_date) = 2
    AND job_health_insurance = TRUE
GROUP BY
    company
HAVING
    COUNT(job_postings_fact.job_id) > 0
ORDER BY
    count_of_jobs DESC;