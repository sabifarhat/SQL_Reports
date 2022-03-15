use imdb;

/* ------------------------------------------------------------- */

select years.year as decade_first_year, years.year + 9 as decade_last_year, sum(total_yearly_movies) from

(select distinct year from movies) years
inner join
(
select year, count(name) as total_yearly_movies
from movies
group by 1
) yearly_movies
on years.year >= yearly_movies.year and yearly_movies.year <= years.year + 9
group by 1
order by 3 desc
limit 1;

select year, count(name)
from
(
select years.year, movies.year years_in_decade, name from 
(select distinct year from movies) years
inner join
(select year, name from movies
where name is not null
) movies
on movies.year >= years.year  and movies.year <= years.year + 9
) decade_data
group by 1
order by 2 desc
limit 1
