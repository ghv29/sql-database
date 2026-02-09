USE jobschema;


ALTER TABLE company MODIFY company_ISIN VARCHAR(50) NOT NULL;
ALTER TABLE rating MODIFY company_ISIN VARCHAR(50) NOT NULL;
ALTER TABLE job MODIFY company_ISIN VARCHAR(50) NOT NULL;

alter table company
ADD PRIMARY KEY (company_ISIN);

alter table rating
ADD PRIMARY KEY (rating_id);

alter table job
ADD PRIMARY KEY (job_id);

SELECT *
FROM company c
LEFT JOIN rating r
ON c.company_ISIN = r.company_ISIN;

alter table job
ADD CONSTRAINT fk_company_isin_j
foreign key(company_ISIN)
references company(company_ISIN)
;

alter table rating
ADD CONSTRAINT fk_company_isin_r
foreign key(company_ISIN)
references company(company_ISIN)
;

ALTER TABLE job
DROP FOREIGN KEY fk_company_isin;

####################################################

##### LIST OF SALARIES PER CATEGORY
SELECT
    AVG(job.salary/10) as avg_Yearly_Salary,
    CASE
        WHEN job.title LIKE '%Analyst%' OR job.title LIKE '%Analytics%' THEN 'Data Analyst'
        WHEN job.title LIKE '%Engineer%' THEN 'Data Engineer'
        WHEN job.title LIKE '%Scientist%' OR job.title LIKE '%Science%' THEN 'Data Scientist'
        ELSE 'Other'
    END AS job_category
FROM job
GROUP BY job.title
ORDER BY avg_Yearly_Salary DESC;

##### AVG PER CATEGORY
SELECT
    job_category,
    ROUND(AVG(salary/10), 1) AS average_salary
FROM
(
    SELECT
        salary,
        CASE
            WHEN title LIKE '%Analyst%' OR title LIKE '%Analytics%' THEN 'Data Analyst'
            WHEN title LIKE '%Engineer%' THEN 'Data Engineer'
            WHEN title LIKE '%Scientist%' OR title LIKE '%Science%' THEN 'Data Scientist'
            ELSE 'Other'
        END AS job_category
    FROM job
) AS categorized_jobs
GROUP BY job_category
ORDER BY average_salary DESC;


##### Maximum salary and Minimum salary per Category

SELECT
    job_category,
    MIN(ROUND((salary/10), 1)) AS minimum_salary,
    MAX(ROUND((salary/10), 1)) AS maximum_salary
FROM
(
    SELECT
        salary,
        CASE
            WHEN title LIKE '%Analyst%' OR title LIKE '%Analytics%' THEN 'Data Analyst'
            WHEN title LIKE '%Engineer%' THEN 'Data Engineer'
            WHEN title LIKE '%Scientist%' OR title LIKE '%Science%' THEN 'Data Scientist'
            ELSE 'Other'
        END AS job_category
    FROM job
) AS categorized_jobs
GROUP BY job_category
ORDER BY job_category;
