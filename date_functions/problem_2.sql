-- Count the number of job postings for each month in 2023, adjusting the job_posted_date to be in 'America/New_York' time zone before extracting the month
-- Assume the job_posted_date is stored in UTC. Group by and order by the month

SELECT
    COUNT(job_id) AS number_of_posts,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month
FROM
    job_postings_fact
GROUP BY
    month
ORDER BY
    month ASC;