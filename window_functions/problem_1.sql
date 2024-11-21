-- list the average salary for each job_title_short alongside the job_id, job_title, job_title_short, and salary_year_avg
-- show every row (do not group by job_title_short)

SELECT
    job_id,
    job_title,
    job_title_short AS job_category,
    salary_year_avg,
    AVG(salary_year_avg) OVER(PARTITION BY job_title_short) AS average_job_category_salary
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
ORDER BY
    job_id DESC;