/*
QUESTION: What are the most optimal skills to learn (high demand and high paying)?
- identify skills in high demand with high average salaries for data and business analysts
- find these optimal skills for Philly-based jobs
- Why? Helps identify skills with good job security (high demand) and good benefits (high salaries)
*/
WITH skill_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills) AS count_of_skills
    FROM
        job_postings_fact
    INNER JOIN
        skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        salary_year_avg IS NOT NULL
        AND job_title_short IN ('Data Analyst', 'Business Analyst')
        AND job_location = 'Philadelphia, PA'
    GROUP BY
        skills_dim.skill_id
),
skill_average_salary AS (
    SELECT
        skills_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS average_salary
    FROM
        job_postings_fact
    INNER JOIN
        skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        salary_year_avg IS NOT NULL
        AND job_title_short IN ('Data Analyst', 'Business Analyst')
        AND job_location = 'Philadelphia, PA'
    GROUP BY
        skills_dim.skill_id
)
SELECT
    skill_demand.skill_id,
    skill_demand.skills,
    count_of_skills,
    average_salary
FROM
    skill_demand
INNER JOIN
    skill_average_salary
ON skill_demand.skill_id = skill_average_salary.skill_id
ORDER BY
    count_of_skills DESC,
    average_salary DESC
LIMIT 25;

-- Rewrite query more concisely

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS count_of_skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS average_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim
ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short IN ('Data Analyst', 'Business Analyst')
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Philadelphia, PA'
ORDER BY
    average_salary DESC,
    count_of_skills DESC
LIMIT 25;