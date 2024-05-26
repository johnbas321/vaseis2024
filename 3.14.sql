SELECT * FROM cook.recipe_to_meal_type;

select e.episode_id,count(theme_id) from recipe_to_theme r join episode_to_recipe e on r.recipe_id = e.recipe_id group by e.episode_id order by count(*) desc limit 1;