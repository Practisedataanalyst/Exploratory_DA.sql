-- Exploratory data analysis
select *
from layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

select *
from layoffs_staging2
where percentage_laid_off=1
order by total_laid_off desc;

select *
from layoffs_staging2
order by funds_raised_millions desc;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select max(`date`), min(`date`)
from layoffs_staging2;

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select `date`, sum(total_laid_off)
from layoffs_staging2
group by date;

select Year(`date`), sum(total_laid_off)
from layoffs_staging2
group by Year(`date`)
order by 1 desc;

select Year(`date`), avg(percentage_laid_off)
from layoffs_staging2
group by Year(`date`)
order by 1 desc;

select substring(`date`,1,7) as `month` , sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 ;


with Rolling_Total as
(
select substring(`date`,1,7) as `month` , sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 
)
select `month`, total_off, sum(total_off)
over(order by `month`) as rolling_total
from Rolling_Total ;


select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 desc;

WITH Company_Year (company,years, total_laid_off) AS 
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
), Company_Year_Rank as
(
select *, dense_rank() OVER(PARTITION BY years order by total_laid_off desc) as ranking
from Company_year
where years is not null
)
select *
from Company_Year_Rank
where ranking <= 5;


