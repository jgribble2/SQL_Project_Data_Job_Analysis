/*
QUESTION: What are the most in-demand skills for data and business analysts?
- join job postings to inner join table (similar to query 2)
- identfy the top 10 in-demand skills for data and business analysts
- focus on all job postings regardless of salary or location
- WHY? Highlights skills for jobs not just limited to high pay or Philly
*/
SELECT
    skills,
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
    job_title_short IN ('Data Analyst', 'Business Analyst')
GROUP BY
    skills
ORDER BY
    count_of_skills DESC
LIMIT 10;
-- Based on the above query, SQL and Excel are the most commonly sought after skills for all data and business analyst jobs (followe by python, tableau, and power bi)