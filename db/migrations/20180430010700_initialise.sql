-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied

CREATE TABLE IF NOT EXISTS users (
  'id' INTEGER NOT NULL PRIMARY KEY,
  'created_at' TEXT,
  'updated_at' TEXT
);

CREATE UNIQUE INDEX users_id ON users ('id');

CREATE TABLE IF NOT EXISTS anime_library_entries (
  'id' INTEGER NOT NULL PRIMARY KEY,
  'anime_id' INTEGER REFERENCES anime('id'),
  'user_id' INTEGER REFERENCES users('id'),
  'status' INTEGER,
  'rating' INTEGER,
  'created_at' TEXT,
  'updated_at' TEXT
);

CREATE UNIQUE INDEX anime_library_entries_id ON anime_library_entries ('id');
CREATE INDEX anime_library_entries_anime_id ON anime_library_entries ('anime_id');
CREATE INDEX anime_library_entries_user_id ON anime_library_entries ('user_id');

CREATE TABLE IF NOT EXISTS anime (
  'id' INTEGER NOT NULL PRIMARY KEY,
  'status' INTEGER,
  'start_date' TEXT,
  'created_at' TEXT,
  'updated_at' TEXT
);

CREATE UNIQUE INDEX anime_id ON anime ('id');

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back

DROP TABLE IF EXISTS 'anime_library_entries';
DROP TABLE IF EXISTS 'users';
DROP TABLE IF EXISTS 'anime';
