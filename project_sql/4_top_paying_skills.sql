/*
QUESTION: What are the top skills based on salary?
- look at the average salary associated with each skill for data or business analysts positions
- focus on roles with specified salaries
- compare these average skill salaries to the skill average salaries in Philly
- Why? Shows how different skills can impact salary level and the most financially rewarding skills
*/
SELECT
    skills,
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
    skills
ORDER BY
average_salary DESC
LIMIT 25;

-- Based on these top 25 highest paying skills, it appears that skills types could be ranked as follows listed by importance: database and query proficiency (SQL, oracle, SSIS, SSRS), BI and visualization (power BI, SSRS, tableau), statistical and programming tools (R, python, SAS, SPSS), and producivity tools (excel, powerpoint, sharepoint)