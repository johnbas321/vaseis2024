SELECT * FROM cook.episode_to_recipe;
create view ep_dif as
select e.episode_id,e.recipe_id,r.difficulty from episode_to_recipe e join recipe r on e.recipe_id = r.recipe_id;

select *,sum(difficulty) as t from ep_dif t group by (recipe_id)

select e.episode_year,sum(t.difficulty) as dif from ep_dif t join episode e on t.episode_id = e.episode_id group by e.episode_year