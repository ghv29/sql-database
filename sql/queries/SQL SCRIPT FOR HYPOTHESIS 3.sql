SELECT * FROM company;

SELECT * FROM job;

SELECT * FROM rating;

#H3: Sector "Finance" pays the highest salaries

#NEED sector column from company table, salary col from job table

SELECT sector FROM company; #need to remove the -1, unknown, etc

SELECT salary/10, title FROM job; #need to find out unit

#how do i connect these two variables? join

#1. This query retrieves sectors along with their corresponding company ISINs.
SELECT DISTINCT c.sector, c.company_ISIN
FROM company c
WHERE c.sector NOT IN ('-1', 'Unknown');

#2. This query calculates the average salary for each company based on its ISIN from the job table.
SELECT j.company_ISIN, ROUND(AVG(j.salary/10), 2) AS average_salary
FROM job j
GROUP BY j.company_ISIN;

#3. This query joins the company and job tables using the foreign key (isin) to calculate the average salary for each sector.
SELECT c.sector, ROUND(AVG(j.salary/10), 2) AS average_salary
FROM company c
JOIN job j ON c.company_ISIN = j.company_ISIN
WHERE c.sector NOT IN ('-1', 'Unknown')
GROUP BY c.sector;

#4. This query lists the top 5 sectors with the highest average salaries.
SELECT c.sector, ROUND(AVG(j.salary/10), 2) AS average_salary
FROM company c
JOIN job j ON c.company_ISIN = j.company_ISIN
WHERE c.sector <> -1 OR 'Unknown'
GROUP BY c.sector
ORDER BY average_salary DESC
LIMIT 5;

#5, This query retrieves detailed salary data along with their corresponding sectors, useful for a detailed analysis in Python.
SELECT c.sector, j.salary/10 AS salary
FROM company c
JOIN job j ON c.company_ISIN = j.company_ISIN
WHERE c.sector NOT IN ('-1', 'Unknown');




