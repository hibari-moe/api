-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied

CREATE TABLE IF NOT EXISTS 'anime_library_entries' (
  'id' INTEGER PRIMARY KEY,
  'anime_id' INTEGER,
  'status' INTEGER,
  'rating' INTEGER,
  'created_at' DATETIME,
  'updated_at' DATETIME
)

CREATE TABLE IF NOT EXISTS 'manga_library_entries' (
  'id' INTEGER PRIMARY KEY,
  'manga_id' INTEGER,
  'status' INTEGER,
  'rating' INTEGER,
  'created_at' DATETIME,
  'updated_at' DATETIME
)

CREATE TABLE IF NOT EXISTS 'users' (
  'id' INTEGER PRIMARY KEY,
  'created_at' DATETIME,
  'updated_at' DATETIME
)

CREATE TABLE IF NOT EXISTS 'anime' (
  'id' INTEGER PRIMARY KEY,
  'start_date' DATETIME,
  'created_at' DATETIME,
  'updated_at' DATETIME
)

CREATE TABLE IF NOT EXISTS 'anime_ratings' (
  'id' INTEGER PRIMARY KEY,
  'total' INTEGER,
  'mean' INTEGER,
  'median' INTEGER,
  'mode' INTEGER,
  'variance' INTEGER,
  'standard_deviation' INTEGER,
  'created_at' DATETIME,
  'updated_at' DATETIME
)

CREATE TABLE IF NOT EXISTS 'manga' (
  'id' INTEGER PRIMARY KEY,
  'start_date' DATETIME,
  'created_at' DATETIME,
  'updated_at' DATETIME
)

CREATE TABLE IF NOT EXISTS 'manga_ratings' (
  'id' INTEGER PRIMARY KEY,
  'total' INTEGER,
  'mean' INTEGER,
  'median' INTEGER,
  'mode' INTEGER,
  'variance' INTEGER,
  'standard_deviation' INTEGER,
  'created_at' DATETIME,
  'updated_at' DATETIME
)

CREATE TABLE IF NOT EXISTS 'categories' (
  'id' INTEGER PRIMARY KEY,
  'name' TEXT,
  'created_at' DATETIME,
  'updated_at' DATETIME
)

CREATE TABLE IF NOT EXISTS 'categories_anime_id' (
  'id' INTEGER PRIMARY KEY,
  'category_id' INTEGER,
  'anime_id' INTEGER,
  'created_at' DATETIME,
  'updated_at' DATETIME
)

CREATE TABLE IF NOT EXISTS 'categories_manga_id' (
  'id' INTEGER PRIMARY KEY,
  'category_id' INTEGER,
  'manga_id' INTEGER,
  'created_at' DATETIME,
  'updated_at' DATETIME
)

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back

DROP TABLE IF EXISTS 'anime_library_entries'
DROP TABLE IF EXISTS 'manga_library_entries'
DROP TABLE IF EXISTS 'users'
DROP TABLE IF EXISTS 'anime'
DROP TABLE IF EXISTS 'anime_ratings'
DROP TABLE IF EXISTS 'manga'
DROP TABLE IF EXISTS 'manga_ratings'
DROP TABLE IF EXISTS 'categories'
DROP TABLE IF EXISTS 'categories_anime_id'
DROP TABLE IF EXISTS 'categories_manga_id'
