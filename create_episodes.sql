DELIMITER //
create procedure calculate_nutrition (in rec int)
begin
	declare i int;
    set i = 1;
    while i <= rec do
		insert into nutrition_per_recipe (recipe_id, fat, protein, carbs, calories)
			select i,
			round(sum(fat*(h.quantity_100 / r.portion)),5),
			round(sum(protein*(h.quantity_100 / r.portion)),5),
			round(sum(carbs*(h.quantity_100 / r.portion)),5),
			round(sum(calories*(h.quantity_100 / r.portion)),5)
			from (recipe r inner join hasingredient h on r.recipe_id = h.recipe_id) join ingredient i on h.ingredient_name = i.ingredient_name where r.recipe_id = i;
		set i = i + 1;
	end while;
end;
//
DELIMITER ;

CREATE TABLE cook_to_recipe as
	SELECT c.cook_id, r.recipe_id,r.origin_id FROM cook_to_origin c INNER JOIN recipe_origin_name r ON c.origin_name = r.origin_name;
    
DELIMITER //
create procedure get_grades (in ep_num int)
begin
	declare i int;
    set i = 1;
    while 1 <= ep_num do
		insert into grade
			select c.episode_id,c.cook_id,floor(1 + rand() * 5) AS grade_judge1 ,floor(1 + rand() * 5) AS grade_judge2,floor(1 + rand() * 5) AS grade_judge3
            from (episode_to_cook c join episode_to_judge j1 on c.episode_id = j1.episode_id) join 
			episode_to_judge j2 on c.episode_id = j2.episode_id join
			episode_to_judge j3 on c.episode_id = j3.episode_id;
		set i = i + 1;
	end while;
end;
//
DELIMITER ;
            
DELIMITER //
create procedure get_winners(in ep_num int)
begin
	-- declare i int;
    -- set i = 1;
    -- while i <= ep_num do
		insert into episode_winner
			select t.episode_id,t.cook_id as winner, t.total_grade, e.episode_year as comp_year from episode e join (
			SELECT g.episode_id,g.cook_id,MAX(type_of_cook) as type_of_cook,(grade_judge1 + grade_judge2 + grade_judge3) as total_grade
			FROM cook.grade g join cook c on g.cook_id = c.cook_id
			WHERE episode_id = ep_num and (grade_judge1 + grade_judge2 + grade_judge3) =(select MAX(grade_judge1 + grade_judge2 + grade_judge3) from grade)
			) as t on t.episode_id = e.episode_id;
	-- set i = i + 1;
	-- end while;
end;
//
DELIMITER ;
drop procedure get_winners
call get_winners(3)
drop table episode_winner