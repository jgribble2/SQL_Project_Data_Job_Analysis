-- Determine the size category ('Small', 'Medium', or 'Large') for each company by first identifying the number of job postings they have
-- Use a subquery to calculate the total job postings per company
-- A company is considered 'Small' if it has less than 10 job postings, 'Medium' if the number of job postings is between 10 and 50, and 'Large' if it has more than 50 job postings
-- Implement a subquery to aggregate job counts per company before classifying them based on size

SELECT
    company_job_count.company_id,
    name,
    CASE
        WHEN company_job_count.count_of_jobs > 50 THEN 'Large'
        WHEN company_job_count.count_of_jobs BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Small'
    END AS company_size
FROM (
    SELECT
        company_dim.company_id,
        company_dim.name,
        COUNT(job_postings_fact.job_id) AS count_of_jobs
    FROM
        company_dim
    INNER JOIN
        job_postings_fact
    ON company_dim.company_id = job_postings_fact.company_id
    GROUP BY
        company_dim.company_id
    ORDER BY
        company_dim.company_id ASC
) AS company_job_count;