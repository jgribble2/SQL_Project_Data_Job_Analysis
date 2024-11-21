-- Create a unified query that categorizes job postings into two groups: those with salary information (salary_year_avg or salary_hour_avg is not null) and those without it
-- Each job posting should be listed with its job_id, job_title, and an indicator of whether salary information is provided

SELECT
    job_id,
    job_title,
   'With salary info' AS salary_info
FROM
    job_postings_fact
WHERE
    salary_hour_avg IS NOT NULL
    AND salary_year_avg IS NOT NULL
UNION ALL
SELECT
    job_id,
    job_title,
    'Without salary info' AS salary_info
FROM
    job_postings_fact
WHERE
    salary_hour_avg IS NULL
    AND salary_year_avg IS NULL
ORDER BY
    job_id;