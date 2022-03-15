/* 
---- Films with largest cast
---- "cast size" we mean the number of distinct actors that played in that movie
---- if an actor played multiple roles or had occured multiples times in the cast count him/her only once
*/
use imdb;
SELECT * from actors;
/* id | first_name | Last_name | gender */
select * from roles
order by movie_id, actor_id;
/* actor_id | movie_id | role */
select * from directors;
/* id | first_name | last_name */
select * from movies_directors;
/* director_id | movie_id */

/*output 
movie | Largest cast size 
*/

/* ---------------------------------------------------------------------------------------- */
select movie_id, sum(actors + directors) as cast_size from 
(
	select movie_id, count(distinct actor_id) actors, count(distinct director_id_transformed) directors
	from 
		(
		select movie_id, actor_id, director_id,
		case when director_id = actor_id then director_id =  null else director_id end director_id_transformed
		 from
			(
				select director.movie_id,  director.director_id, r.actor_id
				from 
					(
						select m.id as movie_id, dc.director_id
						from movies m  inner join (
						select d.id as director_id, md.movie_id
						from directors d right join movies_directors md
						on d.id = md.director_id
					) dc
					on m.id = dc.movie_id
				) director inner join roles r
				on director.movie_id = r.movie_id
		) director_actor_combined 
	) cast_transformed
	group by 1 
) dc_count
group by 1
order by 2 desc

