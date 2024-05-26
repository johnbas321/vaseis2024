drop view random_origins;
CREATE view random_origins as
SELECT 
    a.origin_name AS origin1,
    b.origin_name AS origin2,
    c.origin_name AS origin3,
    d.origin_name AS origin4,
    e.origin_name AS origin5,
    f.origin_name AS origin6,
    g.origin_name AS origin7,
    h.origin_name AS origin8,
    i.origin_name AS origin9,
    j.origin_name AS origin10
FROM 
    origin a
    JOIN origin b ON a.origin_id < b.origin_id
    JOIN origin c ON b.origin_id < c.origin_id
    JOIN origin d ON c.origin_id < d.origin_id
    JOIN origin e ON d.origin_id < e.origin_id
    JOIN origin f ON e.origin_id < f.origin_id
    JOIN origin g ON f.origin_id < g.origin_id
    JOIN origin h ON g.origin_id < h.origin_id
    JOIN origin i ON h.origin_id < i.origin_id
    JOIN origin j ON i.origin_id < j.origin_id
ORDER BY 
    a.origin_name, b.origin_name, c.origin_name, d.origin_name, e.origin_name, f.origin_name, g.origin_name, h.origin_name, i.origin_name, j.origin_name ;
    
call add_origins_to_episodes(500);

CREATE TABLE all_together as
select o.*,judge1,judge2,judge3 from episode_to_origin o left join episode j on o.episode_id = j.episode_id;

select * from all_together