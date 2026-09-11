select DISTINCT job_title_short FROM job_postings_fact
SELECT (SELECT COUNT (*)
FROM job_postings_fact
WHERE job_no_degree_mention = FALSE)
;
SELECT 
(SELECT COUNT (*)
FROM job_postings_fact
WHERE job_no_degree_mention = TRUE)


SELECT *
From job_postings_fact
WHERE LOWER(job_schedule_type) LIKE '%internship%'
AND LOWER(job_title_short) LIKE '%analyst%'
AND job_work_from_home = TRUE 

SELECT skills ,COUNT(*) 
FROM skills_dim
GROUP BY skills
ORDER BY COUNT(*) DESC;
SELECT skill_id, skills, type
FROM skills_dim
WHERE LOWER(skills) IN ('sas', 'powerbi', 'power bi', 'sqlserver', 'sql server')
ORDER BY skills;