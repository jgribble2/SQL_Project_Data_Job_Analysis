-- Identify companies with the most diverse (unique) job titles
-- Use a CTE to count the number of unique job titles per company, then select companies with the highest diversity in job titles

WITH unique_companies AS (
    SELECT
        company_id,
        COUNT(DISTINCT job_title) AS number_of_unique_job_titles
    FROM
        job_postings_fact
    GROUP BY
        company_id
)
SELECT
    name,
    number_of_unique_job_titles
FROM
    company_dim
INNER JOIN
    unique_companies
ON company_dim.company_id = unique_companies.company_id
ORDER BY
    number_of_unique_job_titles DESC
LIMIT 10;