/*
   This is a SQL file. It contains SQL statements which can be executed by
   any SQL database. It also contains statements like this one (called a 
   comment) which are ignored by the computer and only for the humans who
   might read it.
*/

-- By convention, SQL keywords are written in all caps. This is not a requirement
-- but it is considered a best practice for maintaining "readable" SQL code.
CREATE TABLE book (
    book_id BIGSERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    publish_date DATE, -- Allowed to be null because our DB may contain some unpublished books.
    price DEC(6, 2),   -- 6 significant figures, 2 after the decimal, meaning 9999.99 is our "most expensive" possible book.
    CONSTRAINT unique_author_title UNIQUE (author, title)
);

-- Remember to discuss...
-- Datatypes
-- Constraints (unique, null/not null, "there are many others")
-- Default Values

-- Alter existing table (not common, but sometimes needed)
-- Say we realized that "republication" is a thing, and we have some books
-- that have the same title and author, but were republished at different dates...
ALTER TABLE book DROP CONSTRAINT unique_author_title;
ALTER TABLE book ADD CONSTRAINT unique_author_title_publish_date UNIQUE (author, title, publish_date);

-- Drop tables, very uncommon in production databases, but still worth knowing.
DROP TABLE book;