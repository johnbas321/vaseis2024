select c.cook_id,count(c.recipe_id) as total_recipes from cook_to_recipe c join cook t on c.cook_id = t.cook_id WHERE t.age < 30 group by cook_id order by  total_recipes desc
-- limit 5