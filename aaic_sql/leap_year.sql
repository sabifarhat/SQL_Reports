use imdb;
SELECT * from directors;



select * from movies_genres;
select * from movies_directors;
select * from movies;
/* ---------------------------------------------------------------------------------------------------- */
with movie_director_details as 
(
select director_moviesId.full_name, director_moviesId.movie_id, m.name as movie_name, m.year as years from 
(
select concat(first_name,' ',last_name) as full_name, movie_id from 
directors d inner join movies_directors md 
on d.id = md.director_id 
) director_moviesId inner join movies_genres mg
on director_moviesId.movie_id = mg.movie_id 
left join movies m 
on director_moviesId.movie_id = m.id
where mg.genre = 'Comedy'
)


select director_name, movie_name, movie_year  from 
(
select full_name as director_name, movie_name, 
case when (years % 4 = 0 and years % 100 <> 0) OR years % 400 = 0 then years end movie_year 
from movie_director_details 
) as final where movie_year is not null


