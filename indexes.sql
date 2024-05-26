CREATE INDEX idx_all_together_episode_id ON all_together(episode_id);
CREATE INDEX idx_all_together_judge1 ON all_together(judge1);
CREATE INDEX idx_all_together_judge2 ON all_together(judge2);
CREATE INDEX idx_all_together_judge3 ON all_together(judge3);
CREATE INDEX idx_all_together_origin1 ON all_together(origin1);
CREATE INDEX idx_all_together_origin2 ON all_together(origin2);
CREATE INDEX idx_all_together_origin3 ON all_together(origin3);
CREATE INDEX idx_all_together_origin4 ON all_together(origin4);
CREATE INDEX idx_all_together_origin5 ON all_together(origin5);
CREATE INDEX idx_all_together_origin6 ON all_together(origin6);
CREATE INDEX idx_all_together_origin7 ON all_together(origin7);
CREATE INDEX idx_all_together_origin8 ON all_together(origin8);
CREATE INDEX idx_all_together_origin9 ON all_together(origin9);
CREATE INDEX idx_all_together_origin10 ON all_together(origin10);

CREATE INDEX idx_cook_recipe_origin_episode_episode_id ON cook_recipe_origin_episode(episode_id);
CREATE INDEX idx_cook_recipe_origin_episode_cook_id ON cook_recipe_origin_episode(cook_id);
