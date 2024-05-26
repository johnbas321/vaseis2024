create view cook_number_of_appearences as
select cook_id,count(*) as num_of_app from episode_to_cook group by cook_id;

select cook_id,count(*) as num_of_app from episode_to_cook group by cook_id
having count(*) <= ((select num_of_app from cook_number_of_appearences order by num_of_app desc limit 1) - 5)
order by num_of_app desc;

