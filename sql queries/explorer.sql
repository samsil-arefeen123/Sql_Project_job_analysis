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