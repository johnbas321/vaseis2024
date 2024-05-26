select cook_id, origin_name from cook_to_origin where origin_name='Italian';

select o.cook_id, o.origin_name,t2.episode_year from cook_to_origin o join 
(select o.origin_name,t.episode_year from episode_to_origin e join episode t on e.episode_id = t.episode_id join origin o on e.origin_id = o.origin_id ) as t2
on o.origin_name = t2.origin_name where o.origin_name ='Italian' and t2.episode_year = 2025;