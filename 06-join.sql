-- Working with the database we defined in the schema design basics, copied here for ease.
-- The walkthrough starts on line 88.
DROP TABLE IF EXISTS author CASCADE;
DROP TABLE IF EXISTS book CASCADE;
DROP TABLE IF EXISTS book_author CASCADE;
DROP TABLE IF EXISTS review CASCADE;
DROP TABLE IF EXISTS book_fulltext CASCADE;

CREATE TABLE author (
    author_id BIGSERIAL PRIMARY KEY,
    name text
);

CREATE TABLE book (
    book_id BIGSERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    publish_date DATE, -- Allowed to be null because our DB may contain some unpublished books.
    price DEC(6, 2)   -- 6 significant figures, 2 after the decimal, meaning 9999.99 is our "most expensive" possible book.
);

CREATE TABLE book_author (
    book_id BIGSERIAL REFERENCES book(book_id),
    author_id BIGSERIAL REFERENCES author(author_id),
    CONSTRAINT pk_book_author PRIMARY KEY (book_id, author_id)
);

CREATE TABLE review (
    review_id BIGSERIAL PRIMARY KEY,
    book_id BIGSERIAL NOT NULL REFERENCES book(book_id), -- REFERENCES enforces "referential integrity"
    rating INTEGER CHECK (rating >= 0 AND rating <= 10), -- Rating can only be whole numbers between 0 and 10.
    content text
);

CREATE TABLE book_fulltext (
	book_id BIGINT PRIMARY KEY REFERENCES book(book_id),
	fulltext TEXT
);


INSERT INTO author (name) VALUES ('Jane Austen');
INSERT INTO author (name) VALUES ('Harper Lee');
INSERT INTO author (name) VALUES ('F. Scott Fitzgerald');
INSERT INTO author (name) VALUES ('Gabriel García Márquez');
INSERT INTO author (name) VALUES ('Truman Capote');
INSERT INTO author (name) VALUES ('Aldous Huxley');
INSERT INTO author (name) VALUES ('Virginia Woolf');
INSERT INTO author (name) VALUES ('Mary Shelley');
INSERT INTO author (name) VALUES ('Toni Morrison');
INSERT INTO author (name) VALUES ('Peter Norvig');
INSERT INTO author (name) VALUES ('Stuart J. Russell');

INSERT INTO book (title, publish_date, price) VALUES ('Pride and Prejudice', '01-28-1813', 6.99);
INSERT INTO book (title, publish_date, price) VALUES ('Sense and Sensibility', '10-14-1811', 6.99);
INSERT INTO book (title, publish_date, price) VALUES ('To Kill a Mockingbird', '07-11-1960', 6.99);
INSERT INTO book (title, publish_date, price) VALUES ('The Great Gatsby', '04-10-1925', 12.50);
INSERT INTO book (title, publish_date, price) VALUES ('One Hundred Years of Solitude', '05-5-1967', 8.99);
INSERT INTO book (title, publish_date, price) VALUES ('In Cold Blood', '09-25-1965', 4.99);
INSERT INTO book (title, publish_date, price) VALUES ('Brave New World', '01-01-1932', 19.84);
INSERT INTO book (title, publish_date, price) VALUES ('To The Lighthouse', '05-05-1927', 15.00);
INSERT INTO book (title, publish_date, price) VALUES ('Frankenstein', '01-01-1818', 7.50);
INSERT INTO book (title, publish_date, price) VALUES ('Beloved', '09-13-1987', 12.50);
INSERT INTO book (title, publish_date, price) VALUES ('Song of Solomon', '01-01-1977', 12.50);
INSERT INTO book (title, publish_date, price) VALUES ('Artificial Intelligence: A Modern Approach 4th Edition', '04-28-2020', 4.99);

INSERT INTO book_author VALUES (1, 1);
INSERT INTO book_author VALUES (2, 1);
INSERT INTO book_author VALUES (3, 2);
INSERT INTO book_author VALUES (4, 3);
INSERT INTO book_author VALUES (5, 4);
INSERT INTO book_author VALUES (6, 5);
INSERT INTO book_author VALUES (7, 6);
INSERT INTO book_author VALUES (8, 7);
INSERT INTO book_author VALUES (9, 8);
INSERT INTO book_author VALUES (10, 9);
INSERT INTO book_author VALUES (11, 9);
INSERT INTO book_author VALUES (12, 10);
INSERT INTO book_author VALUES (12, 11);

INSERT INTO review (book_id, rating, content) VALUES (1, 3, 'didn''t like it, dry and boring.');
INSERT INTO review (book_id, rating, content) VALUES (1, 7, 'A window into a time gone by, and a sad look at just how little has changed.');
INSERT INTO review (book_id, rating, content) VALUES (2, 10, 'Powerful commentary on the lies communities tell themselves about their own goodness.');
INSERT INTO review (book_id, rating, content) VALUES (2, 8, 'Cutting and poignient, but dated. For a book about modern racism try "The Hate U Give"');
INSERT INTO review (book_id, rating, content) VALUES (2, 6, 'I do not understand how they could find Tom Robinson guilty. He obviously did not do it. Unrealistic.');
INSERT INTO review (book_id, rating, content) VALUES (3, 4, 'Gatsby was a real jerk.');
INSERT INTO review (book_id, rating, content) VALUES (3, 8, 'A masterwork about the evils of oppulence.');
INSERT INTO review (book_id, rating, content) VALUES (4, 4, 'The translation to English was poor, you should read this in the original Spanish if you can.');
INSERT INTO review (book_id, rating, content) VALUES (4, 9, 'A remarkable story about how our ancenstry follows us into the future and haunts our present.');
INSERT INTO review (book_id, rating, content) VALUES (5, 10, 'A genre defining masterwork with a chilling subject.');
INSERT INTO review (book_id, rating, content) VALUES (5, 3, 'Too much evil in this book, don''t read it!');
INSERT INTO review (book_id, rating, content) VALUES (5, 6, 'The writing is incredible, but Capote takes too many liberties with crucial facts of the case to be considered non-fiction.');

INSERT INTO book_fulltext VALUES (1, 'Pride and Prejudice: PRETEND THIS IS A LOOOOOOT OF TEXT');
INSERT INTO book_fulltext VALUES (2, 'Sense and Sensibility: PRETEND THIS IS A LOOOOOOT OF TEXT');
INSERT INTO book_fulltext VALUES (3, 'To Kill a Mockingbird: PRETEND THIS IS A LOOOOOOT OF TEXT');
INSERT INTO book_fulltext VALUES (4, 'The Great Gatsby: PRETEND THIS IS A LOOOOOOT OF TEXT');
INSERT INTO book_fulltext VALUES (5, 'One Hundred Years of Solitude: PRETEND THIS IS A LOOOOOOT OF TEXT');
INSERT INTO book_fulltext VALUES (6, 'In Cold Blood: PRETEND THIS IS A LOOOOOOT OF TEXT');
INSERT INTO book_fulltext VALUES (7, 'Brave New World: PRETEND THIS IS A LOOOOOOT OF TEXT');
INSERT INTO book_fulltext VALUES (8, 'To The Lighthouse: PRETEND THIS IS A LOOOOOOT OF TEXT');
INSERT INTO book_fulltext VALUES (9, 'Frankenstein: PRETEND THIS IS A LOOOOOOT OF TEXT');
INSERT INTO book_fulltext VALUES (10, 'Beloved: PRETEND THIS IS A LOOOOOOT OF TEXT');
INSERT INTO book_fulltext VALUES (11, 'Song of Solomon: PRETEND THIS IS A LOOOOOOT OF TEXT');


-- ================= WALKTHROUGH STARTS! =================

-- We've seen basic joins, but not discussed them in much detail.
-- Joins have 2 basic kinds of modifiers:
--   * Inner vs Outer
--   * Right vs Left vs Full

-- Inner joins only return records that have a match on both sides of the ON clause.
-- When no keyword is used, an inner join is performed. In this case one of our books
-- does not have any reviews, so it doesn't appear in the results.
SELECT * FROM book b
JOIN review r ON r.book_id=b.book_id;

-- An "outer" join must be one of the other three types (left, right, outer).
-- All of these joins allow us to retrieve records that don't have any records
-- that satisfy the on clause. By making our join a "left" join, we'll include any
-- records in the left table (books) that don't have a match in the right table (reviews)
SELECT * FROM book b
LEFT JOIN review r ON r.book_id=b.book_id;

-- Note, LEFT, RIGHT, and FULL joins are "outer" by default, but we can specify it if we want:
SELECT * FROM book b
LEFT OUTER JOIN review r ON r.book_id=b.book_id;

-- In a left join you are guaranteed to get at least one record for every entry in the left table.
-- As you can see in the results, entries in the left table that do not have a match in the right table
-- have all their "right table values" filled with null to indicate that data does not exist.

-- The only difference between a left and right join is which table has the guarantee that all of it's records
-- will be in the resulting query.

-- MICRO-EXERCISE: Write a query using a RIGHT JOIN that selects the exact same information as the previous
-- query, but uses review as the left table, and book as the right table.

-- A "full outer" join will include all records from both tables, with the potential
-- for nulls on both the left and right side. To create a situation where a full outer
-- join is interesting lets create a book without any authors, and an author who hasn't
-- written any books...
INSERT INTO book (title, publish_date, price) VALUES ('Pretty People Partying' , '07-7-2007', 7.99);
INSERT INTO author (name) VALUES ('William Williamson');

-- Now we can use a full outer joins and see their behavior:
SELECT * FROM book_author ba
FULL OUTER JOIN book b on b.book_id=ba.book_id
FULL OUTER JOIN author a on a.author_id=ba.author_id;

-- MICRO-EXERCISE: Execute these two queries, and compare their results to the
-- FULL OUTER join above... What records are missing from each that are present
-- in the FULL OUTER version of this join?
SELECT * FROM book_author ba
LEFT JOIN book b on b.book_id=ba.book_id
LEFT JOIN author a on a.author_id=ba.author_id;

SELECT * FROM book_author ba
RIGHT JOIN book b on b.book_id=ba.book_id
RIGHT JOIN author a on a.author_id=ba.author_id;


-- Join clauses can be complex, and involve values other than primary and foreign keys...
SELECT * FROM book b
JOIN review r on r.book_id=b.book_id AND r.rating > 5;

-- This returns the same result, but will apply the rating filter at a different moment in time.
SELECT * FROM book b
JOIN review r on r.book_id=b.book_id 
WHERE r.rating > 5;

-- Note that on large queries, performing the rating filter in the ON clause will often be faster.





