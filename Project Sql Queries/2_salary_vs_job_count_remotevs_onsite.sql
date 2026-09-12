SELECT job_work_from_home,COUNT(*) AS num_job_posted,AVG(salary_hour_avg) AS hourly_avg, AVG(salary_year_avg) AS yearly_avg
FROM job_postings_fact
WHERE LOWER(job_title_short) LIKE '%analyst%'
GROUP BY job_work_from_home;