create view count_eq as
SELECT recipe_id,count(eq_name) as num_eq FROM cook.recipe_to_equipment group by recipe_id

select e.episode_id,sum(t.num_eq) from episode_to_recipe e join count_eq as t on e.recipe_id = t.recipe_id group by e.episode_id;

