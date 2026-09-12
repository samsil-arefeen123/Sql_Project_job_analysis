--Skill To learn based on normalized baseline using weighted salary_avg with number of job posted
WITH salary_via_demand AS (
SELECT skill_id,skills,AVG(salary_year_avg) AS yearly_avg,AVG(salary_hour_avg)AS hourly_avg,COUNT(job_id) AS num_job_posted
FROM job_postings_fact
INNER JOIN skills_job_dim
USING(job_id)
INNER JOIN skills_dim 
USING(skill_id)
WHERE LOWER(job_title_short) LIKE '%analyst%' AND LOWER(job_schedule_type) LIKE '%intern%' 
GROUP BY skill_id,skills
HAVING COUNT(job_id)>30)
,max_min_salary_via_demand AS
(SELECT skill_id,skills,num_job_posted,MAX(num_job_posted) OVER() AS max_job_posted,MIN(num_job_posted) OVER() AS min_job_posted,yearly_avg, MAX(yearly_avg) OVER() AS max_yearly_salary,MIN(yearly_avg) OVER() AS min_yearly_salary,hourly_avg,MAX(hourly_avg) OVER() AS max_hourly_salary,MIN(hourly_avg) OVER() AS min_hourly_salary
FROM salary_via_demand)

SELECT skill_id,skills,num_job_posted,yearly_avg,hourly_avg,ROUND(0.7*(num_job_posted-min_job_posted)/(max_job_posted-min_job_posted)+0.3*COALESCE((yearly_avg-min_yearly_salary)/(max_yearly_salary-min_yearly_salary),(hourly_avg-min_hourly_salary)/(max_hourly_salary-min_hourly_salary)),4) AS optimal_index
FROM max_min_salary_via_demand
ORDER BY optimal_index DESC NULLS LAST
LIMIT 10;
