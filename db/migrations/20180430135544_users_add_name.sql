-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied

ALTER TABLE users ADD COLUMN name TEXT;

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
