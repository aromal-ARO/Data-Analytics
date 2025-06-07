select * from corona_data;
SELECT count(*) from corona_data;
select * from corona_data limit 100;
-- Q1 if null values are present , update them with zeroes for all columns
select * from corona_data where Province is null or `Country/Region` is null
or Latitude is null
or Longitude is null or `Date` is null 
or Confirmed is null or Deaths is null or Recovered is null ;

-- Q2 total number of rows

SELECT count(*) from corona_data;

-- correct the date datatype
alter table corona_data modify column `Date` DATE;



desc corona_data;
select min(`Date`) ,max(`Date`) from corona_data;

select * from corona_data LIMIT 100;
-- count the number of months the virus spread 
select   count( DISTINCT substr(`Date`,1,7)) as `month`  from corona_data;

select * from corona_data LIMIT 100;

-- Find the monthly average for confirmed , deaths , recovered

select distinct substr(`Date`,1,7) as `month`,avg(Confirmed), avg(Deaths),avg(Recovered)
from corona_data group by `month` order by 1;