-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied

ALTER TABLE anime_library_entries ADD COLUMN progress INT;
ALTER TABLE anime ADD COLUMN episodes INT;

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
