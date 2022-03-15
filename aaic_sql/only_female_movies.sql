WITH actor_movies AS
(
SELECT m.year  ,  r.actor_id , a.gender , m.id as movie_id
FROM movies m LEFT JOIN roles r 
ON m.id = r.movie_id 
left join actors a
on r.actor_id = a.id
),

yearly_females_only_movies as 
(
SELECT year , count(movie_id) as only_female_movie_count
FROM actor_movies
where gender not in  ( 
select gender from actors where gender not in ('F'))
group by 1
order by 1
),

yearly_movies_count as
(
select year, count(distinct id) as yearly_movies_count
from movies
group by 1)

select *
from
yearly_movies_count ym left join yearly_females_only_movies yfm
on ym.year = yfm.year;