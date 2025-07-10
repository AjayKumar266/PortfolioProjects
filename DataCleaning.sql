-- DATA CLEANING

select *
from worldlayoffs.layoffs;

-- Remove Duplicates
-- Standardize the Data
-- Null Values or Blank Values
-- Remove Any Column

Create table LayoffsStaging
Like layoffs; 

select *
from worldlayoffs.layoffsstaging;

Insert layoffsstaging
select *
from layoffs;

select *,
row_number() over(
partition by company, location, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions) as rownum
from worldlayoffs.layoffsstaging;

with duplicate_cte as (
select *,
row_number() over(
partition by company, location, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions) as rownum
from worldlayoffs.layoffsstaging
)
select *
from duplicate_cte
where rownum > 1;

select *
from worldlayoffs.layoffsstaging
where company = 'Casper';


create table layoffsstaging3 (
`company` text,
`location` text,
`industry` text,
`total_laid_off` int default NULL, 
`percentage_laid_off` text,
`date` text,
`stage` text,
`country` text,
`funds_raised_millions` int default NULL,
`rownum` int
);

select *
from worldlayoffs.layoffsstaging3;

insert into layoffsstaging3
select *,
row_number() over(
partition by company, location, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions) as rownum
from layoffsstaging;

select *
from worldlayoffs.layoffsstaging3
where rownum > 1
;

delete
from worldlayoffs.layoffsstaging3
where rownum > 1;

select *
from worldlayoffs.layoffsstaging3;

select *
from worldlayoffs.layoffsstaging3
where company = 'Casper';

-- Standardizing the Data

select *
from worldlayoffs.layoffsstaging3;

select distinct(company)
from worldlayoffs.layoffsstaging3
order by 1;

select *
from worldlayoffs.layoffsstaging3;

update layoffsstaging3
set company = trim(company);

select distinct(industry)
from worldlayoffs.layoffsstaging3
order by 1;

select *
from worldlayoffs.layoffsstaging3
where industry Like 'Crypto%';

update layoffsstaging3
set industry = 'Crypto'
where industry like 'Crypto%';

select *
from worldlayoffs.layoffsstaging3;

select distinct country
from worldlayoffs.layoffsstaging3
order by 1;

select * 
from worldlayoffs.layoffsstaging3
where country like 'United States%';

select distinct country, trim(trailing '.' from country)
from worldlayoffs.layoffsstaging3
order by 1;

update layoffsstaging3
set country = trim(trailing '.' from country)
where country like 'United States%';

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from worldlayoffs.layoffsstaging3;

update worldlayoffs.layoffsstaging3
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table worldlayoffs.layoffsstaging3
modify column `date` date;

select *
from worldlayoffs.layoffsstaging3;

select *
from worldlayoffs.layoffsstaging3
where total_laid_off is null
and percentage_laid_off is null;

select *
from worldlayoffs.layoffsstaging3
where industry is null
or industry = '';

select *
from worldlayoffs.layoffsstaging3
where company = 'Airbnb'
;

update worldlayoffs.layoffsstaging3
set industry = null
where industry = '';


select *
from worldlayoffs.layoffsstaging3 t1
join worldlayoffs.layoffsstaging3 t2
	on t1.company = t2.company
    and t1.location = t2.location
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update worldlayoffs.layoffsstaging3 t1
join worldlayoffs.layoffsstaging3 t2
	on t1.company = t2.company
    and t1.location = t2.location
set t1.industry = t2.industry
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

select *
from worldlayoffs.layoffsstaging3
where total_laid_off is null
and percentage_laid_off is null;

delete
from worldlayoffs.layoffsstaging3
where total_laid_off is null
and percentage_laid_off is null;

select *
from worldlayoffs.layoffsstaging3;

alter table worldlayoffs.layoffsstaging3
drop column rownum;







































































































































