SELECT * FROM cook.cook_recipe_origin_episode
select c.cook_id,c.recipe_id,c.origin_name,c.episode_id,a.judge1,a.judge2,a.judge3 from cook_recipe_origin_episode c  join all_together a on c.episode_id = a.episode_id