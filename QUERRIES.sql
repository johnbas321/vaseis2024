create view grades_per_origin as
select t.origin_id,(grade_judge1 + grade_judge2 + grade_judge3) as total_grade from grade e join episode_to_origin t on e.episode_id = t.episode_id;

create view grades_per_cook as
select t.cook_id,(grade_judge1 + grade_judge2 + grade_judge3) as total_grade from grade e join episode_to_cook t on e.episode_id = t.episode_id;

select cook_id,avg(total_grade) from grades_per_cook group by cook_id;
select cook_id,origin_id,avg(total_grade) from grades_per_origin group by origin_id,cook_id;
