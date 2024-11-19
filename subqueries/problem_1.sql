-- Identify the top 5 skills that are most frequently mentioned in job postings
-- Use a subquery to find the skill IDs with the highest counts in the skills_job_dim table
-- Join this result with the skills_dim table to get the skill names

SELECT
    skills_dim.skills
FROM
    skills_dim
INNER JOIN (
    SELECT
        skill_id,
        COUNT(job_id) AS count_of_jobs
    FROM
        skills_job_dim
    GROUP BY
        skill_id
    ORDER BY
        count_of_jobs DESC
    LIMIT 5
) AS top_skills
ON skills_dim.skill_id = top_skills.skill_id
ORDER BY
    count_of_jobs DESC;