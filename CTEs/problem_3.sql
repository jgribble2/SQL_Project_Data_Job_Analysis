-- Calculate the number of unique skills required by each company
-- Aim to quantify the unique skills required per company and identify which of these companies offer the highest average salary for positions necessitating at least one skill
-- For entities without skill-related job postings, list it as a zero skill requirement and a null salary
-- Use CTEs to separately assess the unique skill count and the maximum average salary offered by these companies

WITH unique_skills AS (
    SELECT
        job_postings_fact.company_id,
        COUNT(DISTINCT skill_id) AS number_of_skills
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim
    ON job_postings_fact.company_id = company_dim.company_id
    LEFT JOIN
        skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
    GROUP BY
        job_postings_fact.company_id
), max_salary AS (
    SELECT
        job_postings_fact.company_id,
        MAX(salary_year_avg) AS max_company_salary
    FROM
        job_postings_fact
    WHERE
        job_postings_fact.job_id IN (
            SELECT
                job_id
            FROM
                skills_job_dim
        )
    GROUP BY
        job_postings_fact.company_id
)
SELECT
    name,
    number_of_skills,
    max_company_salary
FROM
    company_dim
LEFT JOIN
    unique_skills
ON company_dim.company_id = unique_skills.company_id
LEFT JOIN
    max_salary
ON company_dim.company_id = max_salary.company_id
ORDER BY
    name ASC;