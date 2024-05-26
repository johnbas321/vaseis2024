INSERT INTO recipe_to_meal_type (recipe_id, meal_type)
SELECT id,
       CASE ROUND(RAND() * 6)
           WHEN 0 THEN 'Breakfast'
           WHEN 1 THEN 'Brunch'
           WHEN 2 THEN 'Lunch'
           WHEN 3 THEN 'Dinner'
           WHEN 4 THEN 'Supper'
           WHEN 5 THEN 'Snack'
           ELSE 'Dessert'
       END AS meal_type
FROM (
    SELECT (a.N + b.N * 10 + c.N * 100) AS id
    FROM (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a
    CROSS JOIN (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS b
    CROSS JOIN (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS c
) AS t
WHERE t.id BETWEEN 1 AND 144;

INSERT INTO recipe_to_theme (recipe_id, theme_id)
SELECT recipe_id, (
    SELECT theme_id 
    FROM theme 
    ORDER BY RAND() 
    LIMIT 1
) AS theme_id
FROM (
    SELECT recipe_id, FLOOR(RAND() * 3) + 1 AS num_appearances -- Adjust the range as needed
    FROM recipe
) AS t1
CROSS JOIN (
    SELECT 1 AS n UNION ALL
    SELECT 2 UNION ALL
    SELECT 3 -- Change this number to the maximum number of themes you want per recipe
) AS t2
WHERE t2.n <= t1.num_appearances;

INSERT INTO recipe_to_tip (recipe_id, tip)
SELECT recipe_id, (
    SELECT tip 
    FROM tips 
    ORDER BY RAND() 
    LIMIT 1
) AS tip
FROM (
    SELECT recipe_id, FLOOR(RAND() * 4)  AS num_appearances -- Adjust the range as needed
    FROM recipe
) AS t1
CROSS JOIN (
    SELECT 1 AS n UNION ALL
    SELECT 2 UNION ALL
    SELECT 3 -- Change this number to the maximum number of themes you want per recipe
) AS t2
WHERE t2.n <= t1.num_appearances;