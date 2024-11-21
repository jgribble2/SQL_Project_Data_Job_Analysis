-- Analyze the monthly demand for skills by counting the number of job postings for each skill in the first quarter (January to March), utilizing data from separate tables for each month
-- Ensure to include skills from all job postings across these months

WITH quarter_1_jobs AS (
    SELECT
        job_id,
        job_posted_date
    FROM
        january_jobs
    UNION ALL
    SELECT
        job_id,
        job_posted_date
    FROM
        february_jobs
    UNION ALL
    SELECT
        job_id,
        job_posted_date
    FROM
        march_jobs
), skill_demand AS (
    SELECT
        skills,
        EXTRACT(YEAR FROM quarter_1_jobs.job_posted_date) AS year,
        EXTRACT(MONTH FROM quarter_1_jobs.job_posted_date) AS month,
        COUNT(quarter_1_jobs.job_id) AS number_of_job_postings
    FROM
        quarter_1_jobs
    INNER JOIN
        skills_job_dim
    ON quarter_1_jobs.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
    GROUP BY
        skills,
        year,
        month
)
SELECT
    skills,
    year,
    month,
    number_of_job_postings
FROM
    skill_demand
ORDER BY
    skills,
    year,
    month;