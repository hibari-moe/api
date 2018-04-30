-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied

CREATE TABLE IF NOT EXISTS users (
  'id' INTEGER NOT NULL PRIMARY KEY,
  'created_at' TEXT,
  'updated_at' TEXT
);

CREATE TABLE IF NOT EXISTS anime_library_entries (
  'id' INTEGER NOT NULL PRIMARY KEY,
  'anime_id' INTEGER REFERENCES anime('id'),
  'status' INTEGER,
  'rating' INTEGER,
  'created_at' TEXT,
  'updated_at' TEXT
);

CREATE TABLE IF NOT EXISTS user_anime_library_entries (
  'user_id' INTEGER REFERENCES users('id'),
  'anime_library_entry_id' INTEGER REFERENCES anime_library_entries('id'),
  'created_at' TEXT,
  'updated_at' TEXT
);

CREATE TABLE IF NOT EXISTS anime (
  'id' INTEGER NOT NULL PRIMARY KEY,
  'status' INTEGER,
  'start_date' TEXT,
  'created_at' TEXT,
  'updated_at' TEXT
);

CREATE TABLE IF NOT EXISTS anime_ratings (
  'id' INTEGER NOT NULL PRIMARY KEY,
  'anime_id' INTEGER REFERENCES anime('id'),
  'total' INTEGER,
  'mean' INTEGER,
  'median' INTEGER,
  'mode' INTEGER,
  'variance' INTEGER,
  'standard_deviation' INTEGER,
  'created_at' TEXT,
  'updated_at' TEXT
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back

DROP TABLE IF EXISTS 'user_anime_library_entries';
DROP TABLE IF EXISTS 'anime_library_entries';
DROP TABLE IF EXISTS 'users';
DROP TABLE IF EXISTS 'anime';
DROP TABLE IF EXISTS 'anime_ratings';
