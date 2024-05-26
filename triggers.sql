DELIMITER //
CREATE TRIGGER add_basic_ingrd
	AFTER INSERT ON hasIngredient FOR EACH ROW
		IF NEW.isBasic = TRUE THEN
			INSERT INTO recipe_to_food_group (recipe_id, group_name) VALUES (NEW.recipe_id, (SELECT group_name FROM ingredient_to_food_group WHERE ingredient_name = NEW.ingredient_name));
	END IF;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER check_duplicate_judge
	BEFORE INSERT ON episode FOR EACH ROW
		IF ( (new.judge1 = new.judge2) OR (new.judge1 = new.judge3) OR (new.judge3 = new.judge2) ) then
			set new.judge1 = (select cook_id from cook where cook_id NOT IN (new.judge1, new.judge2, new.judge3) order by rand() limit 1);
            set new.judge2 = (select cook_id from cook where cook_id NOT IN (new.judge1, new.judge2, new.judge3) order by rand() limit 1);
			set new.judge3 = (select cook_id from cook where cook_id NOT IN (new.judge1, new.judge2, new.judge3) order by rand() limit 1);
		END IF;
//
DELIMITER ;
