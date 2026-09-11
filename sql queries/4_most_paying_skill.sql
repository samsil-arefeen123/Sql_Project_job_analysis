--yearly rate sorting
SELECT DISTINCT skills,AVG(salary_year_avg) AS yearly_salary_per_skill,AVG(salary_hour_avg) AS hourly_salary_per_skill
    
FROM job_postings_fact
INNER JOIN skills_job_dim
USING(job_id)
INNER JOIN skills_dim 
USING(skill_id)
WHERE LOWER(job_title_short) LIKE '%analyst%' AND LOWER(job_schedule_type) LIKE '%intern%' 
GROUP BY skill_id,skills
HAVING COUNT(job_id)>30 
ORDER BY yearly_salary_per_skill DESC NULLS LAST
LIMIT 10;
--hourly rate sorting
SELECT DISTINCT skills,AVG(salary_year_avg) AS yearly_salary_per_skill,AVG(salary_hour_avg) AS hourly_salary_per_skill
FROM job_postings_fact
INNER JOIN skills_job_dim
USING(job_id)
INNER JOIN skills_dim 
USING(skill_id)
WHERE LOWER(job_title_short) LIKE '%analyst%' AND LOWER(job_schedule_type) LIKE '%intern%' 
GROUP BY skill_id,skills
HAVING COUNT(job_id)>10 AND (COUNT(salary_year_avg) >= 2 OR COUNT(salary_hour_avg) >= 2)
ORDER BY hourly_salary_per_skill DESC NULLS LAST
LIMIT 10;