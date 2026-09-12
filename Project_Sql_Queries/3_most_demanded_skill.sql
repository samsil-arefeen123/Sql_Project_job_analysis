SELECT skills,COUNT(job_id) AS job_posted,type
FROM job_postings_fact
INNER JOIN skills_job_dim
USING(job_id)
INNER JOIN skills_dim 
USING(skill_id)
WHERE LOWER(job_title_short) LIKE '%analyst%' AND LOWER(job_schedule_type) LIKE '%intern%'
GROUP BY skill_id,skills,type
ORDER BY job_posted DESC
LIMIT 10;