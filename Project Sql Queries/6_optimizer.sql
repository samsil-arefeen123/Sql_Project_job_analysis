--seeing the deviation of mean from median in terms of yearly and hourly salary rates
WITH avg_n_median_salary AS (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY salary_year_avg) AS median_yearly_salary, AVG(salary_year_avg) AS mean_yearly_salary, PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY salary_hour_avg) AS median_hourly_salary, AVG(salary_hour_avg) as mean_hourly_salary
FROM job_postings_fact)
SELECT mean_yearly_salary,median_yearly_salary, (mean_yearly_salary-median_yearly_salary)/(median_yearly_salary)*100 AS deviation_percentile_yearly,mean_hourly_salary,median_hourly_salary,(mean_hourly_salary-median_hourly_salary)/(median_hourly_salary)*100 AS deviation_percentile_hourly
FROM avg_n_median_salary;
--finding missing value of overall salary data both hourly and yearly for internships
SELECT COUNT(*)::numeric/(SELECT COUNT(*) FROM job_postings_fact WHERE LOWER(job_schedule_type) LIKE '%internship%')*100. AS percentile_missing_info
FROM job_postings_fact
WHERE salary_year_avg IS  NULL AND salary_hour_avg IS NULL AND LOWER(job_schedule_type) LIKE '%internship%'

--finding duplicates of using lowest_distance and based on skill_counted
CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
WITH skill_count_based_on_name AS 
(SELECT skills,LAG(skills) OVER (ORDER BY skills ASC) AS prev_skill ,COUNT(*) AS skill_counted
FROM skills_dim
GROUP BY skills
ORDER BY skills ASC)
SELECT skills,prev_skill,levenshtein(skills,prev_skill) AS lowest_distance ,skill_counted
FROM skill_count_based_on_name
ORDER BY skill_counted DESC ,lowest_distance ASC;