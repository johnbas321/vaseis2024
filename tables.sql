CREATE TABLE IF NOT EXISTS recipe (
	recipe_id INT AUTO_INCREMENT,
    recipe_name VARCHAR(100) NOT NULL,
    is_pastry BOOLEAN NOT NULL,
    origin_id INT NOT NULL,
    difficulty INT NOT NULL,
    recipe_description VARCHAR(300) NOT NULL,
    prep_time INT NOT NULL,
    cook_time INT NOT NULL,
    steps INT NOT NULL,
    portion INT NOT NULL,
    PRIMARY KEY(recipe_id),
    FOREIGN KEY(origin_id) REFERENCES origin(origin_id) 
    );
    
CREATE TABLE IF NOT EXISTS users (
	username VARCHAR(20),
    full_name VARCHAR(20) NOT NULL,
    user_type INT NOT NULL, -- 1 for admin 2 for cook
    PRIMARY KEY(username)
    );

CREATE TABLE IF NOT EXISTS label(
	label_id INT AUTO_INCREMENT,
    label_name VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY(label_id)
    );

CREATE TABLE IF NOT EXISTS equipment(
	equipment_id INT AUTO_INCREMENT,
    eq_name VARCHAR(100) NOT NULL UNIQUE,
    instructions VARCHAR(1000) NOT NULL,
    PRIMARY KEY(equipment_id)
    );

CREATE TABLE IF NOT EXISTS nutrition_per_recipe(
	nutrition_id INT AUTO_INCREMENT,
    recipe_id INT NOT NULL,
    fat FLOAT NOT NULL,
    protein FLOAT NOT NULL,
    carbs FLOAT NOT NULL,
    calories FLOAT NOT NULL,
    PRIMARY KEY(nutrition_id),
    FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id)
    );
    
CREATE TABLE IF NOT EXISTS episode(
    episode_id INT AUTO_INCREMENT,
    episode_year INT NOT NULL,
    PRIMARY KEY(episode_id)
  );

CREATE TABLE IF NOT EXISTS origin(
    origin_id INT AUTO_INCREMENT,
    origin_name VARCHAR(20) NOT NULL UNIQUE,
    PRIMARY KEY(origin_id)
);

CREATE TABLE IF NOT EXISTS cook(
	cook_id INT AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    surname VARCHAR(30) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    birth_date DATE NOT NULL,
    age INT AS (2024 - birth_date), -- we use 2024 instead of currdate() becuase 
    experince INT NOT NULL, -- mysql doesnt support non-deterministic function on tables
    type_of_cook INT NOT NULL, -- we will map their position with integers see bellow for the mapping
    PRIMARY KEY(cook_id)
    );
-- Type of Cook Mapping
-- 1 -> C Cook
-- 2 -> B Cook
-- 3 -> A Cook
-- 4 -> Sous-Chef
-- 4 -> Chef

CREATE TABLE IF NOT EXISTS theme(
	theme_id INT AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    theme_description VARCHAR(200) NOT NULL,
    PRIMARY KEY(theme_id)
    );

CREATE TABLE IF NOT EXISTS ingredient(
	ingredient_id INT AUTO_INCREMENT,
    ingredient_name VARCHAR(30) NOT NULL,
    fat FLOAT NOT NULL,
    protein FLOAT NOT NULL,
    carbs FLOAT NOT NULL,
    calories FLOAT NOT NULL,
    PRIMARY KEY(ingredient_id)
    );

CREATE TABLE IF NOT EXISTS hasIngredient(
	recipe_id INT,
	ingredient_name VARCHAR(30) NOT NULL,
	quantity VARCHAR(20) NOT NULL,
    quantity_100 FLOAT NOT NULL,
    isBasic BOOLEAN NOT NULL,
	PRIMARY KEY(recipe_id, ingredient_name),
    FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id) ,
    FOREIGN KEY(ingredient_name) REFERENCES ingredient(ingredient_name) 
    );
    
CREATE TABLE IF NOT EXISTS image_ingredient(
	image_id INT AUTO_INCREMENT,
    picture MEDIUMBLOB NOT NULL,
    ingredient_name VARCHAR(30) NOT NULL,
    image_description VARCHAR(200) NOT NULL,
    PRIMARY KEY(image_id),
	FOREIGN KEY(ingredient_name) REFERENCES ingredient(ingredient_name) 
    );
    
CREATE TABLE IF NOT EXISTS food_group(
	food_group_id INT AUTO_INCREMENT,
    group_name VARCHAR(30) NOT NULL,
    group_description VARCHAR(100) NOT NULL,
    PRIMARY KEY(food_group_id)
    );

CREATE TABLE IF NOT EXISTS meal_type(
	meal_type VARCHAR(60),
	PRIMARY KEY(meal_type)
    );

CREATE TABLE IF NOT EXISTS tips(
	tip VARCHAR(100),
	PRIMARY KEY(tip)
    );

-- Here we create the intermediate tables

CREATE TABLE IF NOT EXISTS cook_to_origin(
	ref_id INT AUTO_INCREMENT,
    cook_id INT NOT NULL,
    origin_name VARCHAR(20) NOT NULL,
    PRIMARY KEY(ref_id),
	FOREIGN KEY(cook_id) REFERENCES cook(cook_id) ,
    FOREIGN KEY(origin_name) REFERENCES origin(origin_name) 
    );

CREATE TABLE IF NOT EXISTS recipe_to_label(
	ref_id INT AUTO_INCREMENT,
    recipe_id INT NOT NULL,
    label_name VARCHAR(100) NOT NULL,
    PRIMARY KEY(ref_id),
	FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id) ,
    FOREIGN KEY(label_name) REFERENCES label(label_name) 
    );

CREATE TABLE IF NOT EXISTS recipe_to_equipment(
	ref_id INT AUTO_INCREMENT,
    recipe_id INT NOT NULL,
    eq_name VARCHAR(100) NOT NULL,
    PRIMARY KEY(ref_id),
	FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id) ,
    FOREIGN KEY(eq_name) REFERENCES equipment(eq_name) 
    );

CREATE TABLE IF NOT EXISTS recipe_to_theme(
	ref_id INT AUTO_INCREMENT,
    recipe_id INT NOT NULL,
    theme_id INT NOT NULL,
    PRIMARY KEY(ref_id),
	FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id) ,
    FOREIGN KEY(theme_id) REFERENCES theme(theme_id) 
    );

CREATE TABLE IF NOT EXISTS recipe_to_meal_type(
	ref_id INT AUTO_INCREMENT,
    recipe_id INT NOT NULL,
    meal_type VARCHAR(60) NOT NULL,
    PRIMARY KEY(ref_id),
	FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id) ,
    FOREIGN KEY(meal_type) REFERENCES meal_type(meal_type) 
    );
    
CREATE TABLE IF NOT EXISTS grade(
	episode_id INT NOT NULL,
    cook_id INT NOT NULL,
	grade_judge1 INT NOT NULL,
    grade_judge2 INT NOT NULL,
    grade_judge3 INT NOT NULL,
	PRIMARY KEY(episode_id,cook_id),
    FOREIGN KEY(cook_id) REFERENCES cook(cook_id),
    FOREIGN KEY(episode_id) REFERENCES episode(episode_id) 
    );


CREATE TABLE IF NOT EXISTS recipe_to_tip(
	ref_id INT AUTO_INCREMENT,
    recipe_id INT NOT NULL,
    tip VARCHAR(100) NOT NULL,
    PRIMARY KEY(ref_id),
	FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id) ,
    FOREIGN KEY(tip) REFERENCES tips(tip) 
    );
    
CREATE TABLE IF NOT EXISTS ingredient_to_food_group(
	ref_id INT auto_increment,
    ingredient_name VARCHAR(30) NOT NULL,
    group_name VARCHAR(30) NOT NULL,
	PRIMARY KEY(ref_id),
	FOREIGN KEY(ingredient_name) REFERENCES ingredient(ingredient_name) ,
    FOREIGN KEY(group_name) REFERENCES food_group(group_name) 
    );  

CREATE TABLE IF NOT EXISTS recipe_to_food_group(
	ref_id INT auto_increment,
    recipe_id INT NOT NULL,
    group_name VARCHAR(30) NOT NULL,
    PRIMARY KEY(ref_id),
	FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id) ,
    FOREIGN KEY(group_name) REFERENCES food_group(group_name) 
    );
    
CREATE TABLE IF NOT EXISTS episode_to_origin(
	ref_id INT auto_increment,
    episode_id INT NOT NULL,
    origin_id INT NOT NULL,
	PRIMARY KEY(ref_id),
    FOREIGN KEY(episode_id) REFERENCES episode(episode_id),
    FOREIGN KEY(origin_id) REFERENCES origin(origin_id)
    );
    
CREATE TABLE IF NOT EXISTS episode_to_cook(
	ref_id INT auto_increment,
    episode_id INT NOT NULL,
    cook_id INT NOT NULL,
	PRIMARY KEY(ref_id),
    FOREIGN KEY(episode_id) REFERENCES episode(episode_id),
    FOREIGN KEY(cook_id) REFERENCES cook(cook_id)
    );
    
CREATE TABLE IF NOT EXISTS episode_to_recipe(
	ref_id INT auto_increment,
    episode_id INT NOT NULL,
    recipe_id INT NOT NULL,
	PRIMARY KEY(ref_id),
    FOREIGN KEY(episode_id) REFERENCES episode(episode_id),
    FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id)
    );
    
CREATE TABLE IF NOT EXISTS episode_to_judge(
	ref_id INT auto_increment,
    episode_id INT NOT NULL,
    judge1 INT NOT NULL,
    judge2 INT NOT NULL,
    judge3 INT NOT NULL,
	PRIMARY KEY(ref_id),
    FOREIGN KEY(episode_id) REFERENCES episode(episode_id),
    FOREIGN KEY(judge1) REFERENCES cook(cook_id),
	FOREIGN KEY(judge2) REFERENCES cook(cook_id),
    FOREIGN KEY(judge3) REFERENCES cook(cook_id)
    );
    
        
CREATE TABLE IF NOT EXISTS episode_winner(
	episode_id INT NOT NULL,
    winner INT NOT NULL,
    total_grade INT NOT NULL,
    comp_year INT NOT NULL,
    PRIMARY KEY(episode_id,winner),
    FOREIGN KEY(episode_id) REFERENCES episode(episode_id),
    FOREIGN KEY(winner) REFERENCES cook(cook_id)
    );
    