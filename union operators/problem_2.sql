-- Retrieve the job id, job title short, job location, job via, skill and skill type for each job posting from the first quarter (January to March)
-- Using a subquery to combine job postings from the first quarter 
-- Only include postings with an average yearly salary greater than $70,000

SELECT
    quarter_1_jobs.job_id,
    job_title_short,
    job_location,
    job_via,
    salary_year_avg,
    skills,
    type
FROM (
    SELECT
        *
    FROM
        january_jobs
    UNION ALL
    SELECT
        *
    FROM
        february_jobs
    UNION ALL
    SELECT
        *
    FROM
        march_jobs
) AS quarter_1_jobs
LEFT JOIN
    skills_job_dim
ON quarter_1_jobs.job_id = skills_job_dim.job_id
LEFT JOIN
    skills_dim
ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg > 70000
ORDER BY
    quarter_1_jobs.job_id;