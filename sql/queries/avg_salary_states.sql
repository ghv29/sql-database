USE jobsproject;

SELECT state,
COUNT(job_ID) as job_count
FROM job
GROUP BY STATE;

SELECT *
FROM (
    SELECT
        UPPER(TRIM(state)) AS state,
        ROUND(AVG(salary)/10, 2) AS avg_salary,
        COUNT(job_ID) AS job_count
    FROM job
    WHERE salary IS NOT NULL
    GROUP BY UPPER(TRIM(state))
    ORDER BY job_count DESC
    LIMIT 10
) AS top_states
ORDER BY avg_salary DESC;




SELECT
    state,
    ROUND(AVG(salary),2) AS avg_salary,
    COUNT(job_ID) AS job_count
FROM job
WHERE salary IS NOT NULL
GROUP BY state
ORDER BY job_count DESC;




UPDATE job
SET state = ' CA'
WHERE job_ID = 126;

SELECT state
FROM job
WHERE state LIKE ' CA';

SELECT
    j.state,
   ROUND(AVG(j.salary),2) AS avg_salary,
    ROUND(AVG(r.compensation_benefits),2) AS avg_compensation_rating
FROM job j
JOIN rating r ON j.company_ISIN = r.company_ISIN
WHERE j.salary IS NOT NULL
GROUP BY j.state
ORDER BY avg_salary DESC;

SELECT state, COUNT(*) AS job_count
FROM job
GROUP BY state
ORDER BY job_count DESC;

SELECT TRIM(state) AS state, COUNT(*) AS job_count
FROM job

GROUP BY TRIM(state);

SELECT 
    title,
    AVG(salary/10) AS avg_salary,
    COUNT(*) AS num_jobs,
    MAX(salary/10) AS max_salary,
    MIN(salary/10) AS min_salary
FROM job
WHERE salary IS NOT NULL
GROUP BY title
ORDER BY avg_salary DESC
LIMIT 20;

SELECT 
    title,
    state,
    ROUND(AVG(salary),0) AS avg_salary,
    COUNT(*) AS num_jobs
FROM job
WHERE salary IS NOT NULL
GROUP BY title, state
HAVING COUNT(*) > 1    
ORDER BY state, avg_salary DESC;

