/*
QUESTION: What skills are reuired of the top paying data/business analyst jobs in Philly?
- use the top 10 highest paying jobs from the first query
- add the specific skills required of these roles
- WHY? It lets you know which skills are required of these top jobs so you can build skills that relate to higher salaries.
*/
WITH top_jobs AS (
    SELECT
        job_id,
        job_title,
        name AS company,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim
    ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short IN ('Data Analyst', 'Business Analyst')
        AND job_location = 'Philadelphia, PA'
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
),
top_skills AS (
    SELECT
        top_jobs.*,
        skills
    FROM
        top_jobs
    INNER JOIN
        skills_job_dim
    ON top_jobs.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
    ORDER BY
        salary_year_avg DESC
)
SELECT
    top_skills.skills,
    COUNT(top_skills.skills) AS number_of_times_listed
FROM
    top_skills
GROUP BY
    top_skills.skills
ORDER BY
    number_of_times_listed DESC;

-- Based on the above query, SQL, Power BI, SSRS, and Excel are the skills that are listed most frequently amongst data and business analyst roles in Philly. Securing any of these top paying jobs would more than likely require familiarity in most of if not each of these skills.