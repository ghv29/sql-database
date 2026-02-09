USE jobsproject;

SELECT ISIN
FROM company;

ALTER TABLE company MODIFY company_ISIN VARCHAR(50) NOT NULL;
ALTER TABLE rating MODIFY company_ISIN VARCHAR(50) NOT NULL;
ALTER TABLE job MODIFY company_ISIN VARCHAR(50) NULL;

alter table company
ADD PRIMARY KEY (company_ISIN);

alter table rating
ADD PRIMARY KEY (rating_id);

alter table job
ADD PRIMARY KEY (job_id);



SELECT count(*)
FROM job;

SELECT count(*)
FROM rating;

SELECT count(*)
FROM company;

SELECT *
FROM company c
LEFT JOIN rating r
ON c.company_ISIN = r.company_ISIN;







alter table job
ADD CONSTRAINT fk_company_isin
foreign key(company_ISIN)
references company(company_ISIN)
;

alter table rating
ADD CONSTRAINT fk_company_isin
foreign key(company_ISIN)
references company(company_ISIN)
on delete set null;

SELECT *
FROM job;