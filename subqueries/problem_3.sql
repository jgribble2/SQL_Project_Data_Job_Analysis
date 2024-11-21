-- Find companies that offer an average salary above the overall average yearly salary of all job postings
-- Use subqueries to select companies with an average salary higher than the overall average salary (which is another subquery)

SELECT
    company_dim.name
FROM
    company_dim
INNER JOIN (
    SELECT
        company_id,
        AVG(salary_year_avg) AS average_salary
    FROM
        job_postings_fact
    GROUP BY
        company_id
) AS company_salaries
ON company_dim.company_id = company_salaries.company_id
WHERE
    company_salaries.average_salary > (
        SELECT
            AVG(salary_year_avg) AS total_average_salary
        FROM
            job_postings_fact
    );