SELECT * FROM cook.episode_to_recipe;
create view recipe_counts as
select episode_id,recipe_id,count(*) as num_rec from episode_to_recipe group by recipe_id;

create view episode_carbs as
select r.episode_id,sum(n.carbs*r.num_rec) as sum_carbs from recipe_counts r join nutrition_per_recipe n on r.recipe_id = n.recipe_id group by r.episode_id;

select e.episode_year,avg(r.sum_carbs) from episode e join episode_carbs r on e.episode_id = r.episode_id group by e.episode_year;