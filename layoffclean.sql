desc  layoffs;
select * from layoffs limit 100
;

create table layoff_staging like layoffs;
insert layoff_staging select * from layoffs;
SELECT * from layoff_staging;

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  row_num INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoff_staging2;
insert into layoff_staging2 select * , row_number() over(
partition by company, location , industry, total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions
) as row_num from layoff_staging ; 
select * from layoff_staging2 where row_num > 1 order by 1;

delete  from layoff_staging2 where row_num > 1;

select * from layoff_staging2 ;

select distinct company from layoff_staging2 order by 1;
update  layoff_staging2  set company = trim(company)  ;

select * from layoff_staging2;
select DISTINCT location from layoff_staging2 ORDER BY 1;
update layoff_staging2 set location = trim(trailing '.' from location) where location like 'NON-U.S%';
SELECT distinct location from layoff_staging2 order by 1 ;

update layoff_staging set location = trim(location);
select  * from layoff_staging2;
SELECT DISTINCT industry from layoff_staging2;
update layoff_staging2 set industry = 'Crypto' where industry like 'Crypto%';
SELECT DISTINCT industry from layoff_staging2 order by 1;
SELECT DISTINCT country from layoff_staging2;
UPDATE layoff_staging2 set country = trim(trailing('.') from country);

update layoff_staging2 set `date` = str_to_date(`date`,'%m/%d/%Y');
select `date` from layoff_staging2;
alter table layoff_staging2 modify  column `date` date;
select * from layoff_staging2 where total_laid_off is null and percentage_laid_off is null order by 1;
update layoff_staging2 set industry = null where industry  = '';
select * from layoff_staging2 where  industry = null or industry = '';

update  layoff_staging2 as s1 join   
layoff_staging2 as s2 on s1.company = s2.company and s1.location = s2.location where 
s1.industry is null or s1.industry = '' and s2.industry is not null;

UPDATE layoff_staging2 as s1 join layoff_staging2 as s2 on 
s1.company = s2.company and s1.location = s2.location set s1.industry = s2.industry where 
s1.industry  ;

alter table layoff_staging2 drop column row_num;
select * from  layoff_staging2 ; 