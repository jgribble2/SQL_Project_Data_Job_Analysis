/*
QUESTION: What are the highest paying data analyst and buisness analyst jobs?
- find the top 25 highest paying remote data analyst jobs
- remove nulls
- find company names for each job posting
- WHY? (highlight top paying data analyst jobs)
*/
SELECT
    job_id,
    job_title,
    name AS company,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN
    company_dim
ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short IN ('Data Analyst', 'Business Analyst')
    AND job_work_from_home = TRUE
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 25;