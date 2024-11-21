-- Explore job postings by listing job id, job titles, company names, and their average salary rates, while categorizing these salaries relative to the average in their respective countries
-- Include the month of the job posted date
-- Use CTEs, conditional logic, and date functions, to compare individual salaries with national averages

WITH average_country_salaries AS (
    SELECT
        job_country,
        AVG(salary_year_avg) AS average_salary
    FROM
        job_postings_fact
    GROUP BY
        job_country
)
SELECT
    job_id,
    job_title,
    name,
    salary_year_avg,
    CASE
        WHEN salary_year_avg > average_salary THEN 'above average'
        ELSE 'below average'
        END AS average_salary_rates,
    EXTRACT(MONTH FROM job_posted_date) AS month_posted
FROM
    job_postings_fact
INNER JOIN
    average_country_salaries
ON job_postings_fact.job_country = average_country_salaries.job_country
INNER JOIN
    company_dim
ON job_postings_fact.company_id = company_dim.company_id
ORDER BY
    month_posted DESC;