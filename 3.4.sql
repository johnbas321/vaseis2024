create view all_judges as 
select  distinct(r) as judges from(
select judge1 as r from episode_to_judge
union all
select judge2 as r from episode_to_judge
union all
select judge3 as r from episode_to_judge
) as t ;

select cook_id as cooks_that_are_not_judges from cook where cook_id not in (select judges from all_judges);
