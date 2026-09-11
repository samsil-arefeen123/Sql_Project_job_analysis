WITH job_skill_required AS 
(SELECT job_id, COUNT(skill_id) AS number_of_skill_required_jobs
FROM skills_job_dim
GROUP BY job_id
)
SELECT  
    CASE WHEN LOWER(job_title_short) LIKE '%analyst%' THEN 'Analyst'
        WHEN LOWER(job_title_short) LIKE '%scientist%' THEN 'Scientist'
        WHEN LOWER(job_title_short) LIKE '%engineer%' THEN 'Engineer'
        ELSE 'Other' END AS sub_job_category,ROUND(AVG(number_of_skill_required_jobs),2) AS skill_job_COUNT,ROUND(AVG(salary_year_avg),2) AS avg_salary
FROM job_postings_fact
LEFT JOIN job_skill_required
USING(job_id)
GROUP BY sub_job_category
ORDER BY sub_job_COUNT ASC;