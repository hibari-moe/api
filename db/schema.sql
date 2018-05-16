CREATE TABLE users (
  'id' INTEGER NOT NULL PRIMARY KEY,
  'name' TEXT,
  'created_at' TEXT,
  'updated_at' TEXT
);

CREATE TABLE anime_library_entries (
  'id' INTEGER NOT NULL PRIMARY KEY,
  'anime_id' INTEGER REFERENCES anime('id'),
  'user_id' INTEGER REFERENCES users('id'),
  'status' INTEGER,
  'rating' INTEGER,
  'progress' INTEGER,
  'created_at' TEXT,
  'updated_at' TEXT
);

CREATE TABLE anime (
  'id' INTEGER NOT NULL PRIMARY KEY,
  'status' INTEGER,
  'episodes' INTEGER,
  'start_date' TEXT,
  'created_at' TEXT,
  'updated_at' TEXT
);
