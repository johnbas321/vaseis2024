DELIMITER //
create procedure add_judges_to_episodes ()
begin
	declare i int;
    set i = 1;
    while i <= 50 do
		insert into episode values (i,(select cook_id from cook where cook_id order by rand() limit 1),
									  (select cook_id from cook where cook_id order by rand() limit 1),
									  (select cook_id from cook where cook_id order by rand() limit 1));
		set i = i + 1;
	end while;
end;
//
DELIMITER ;

DELIMITER //
create procedure add_origins_to_episodes ()
begin
	declare i int;
    set i = 1;
    while i <= 50 do
		insert into episode_to_origin values (i,(select origin_name from origin where origin_name order by rand() limit 1));
		set i = i + 1;
	end while;
end;
//
DELIMITER ;

call add_judges_to_episodes();
call add_origins_to_episodes();