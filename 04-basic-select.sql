-- Lets get our books back
DROP TABLE book;
CREATE TABLE book (
    book_id BIGSERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    publish_date DATE, -- Allowed to be null because our DB may contain some unpublished books.
    price DEC(6, 2),   -- 6 significant figures, 2 after the decimal, meaning 9999.99 is our "most expensive" possible book.
    CONSTRAINT unique_author_title_publish_date UNIQUE (author, title, publish_date)
);

-- Inserting when all columns are specified
-- NOTE, generally, you would not want to specify the value for a (BIG)SERIAL (See next example)
INSERT INTO book (title, author, publish_date, price) VALUES ('Pride and Prejudice', 'Jane Austen', '01-28-1813', 6.99);
INSERT INTO book (title, author, publish_date, price) VALUES ('To Kill a Mockingbird', 'Harper Lee', '07-11-1960', 6.99);
INSERT INTO book (title, author, publish_date, price) VALUES ('The Great Gatsby', 'F. Scott Fitzgerald', '04-10-1925', 12.50);
INSERT INTO book (title, author, publish_date, price) VALUES ('One Hundred Years of Solitude', 'Gabriel García Márquez', '05-5-1967', 8.99);
INSERT INTO book (title, author, publish_date, price) VALUES ('In Cold Blood', 'Truman Capote', '09-25-1965', 4.99);

-- Select everything
SELECT * FROM book;

-- Specify columns
SELECT title, author FROM book;
SELECT publish_date FROM book;

-- MICRO-EXERCISE: select just the book_id and price.

-- Specify rows with where
SELECT * FROM book WHERE publish_date < '01-01-1960'; 
SELECT title FROM book WHERE title LIKE 'T%'; -- This finds titles that start with a T
SELECT DISTINCT price FROM book; -- Finds all the prices, without duplicates.

-- MICRO-EXERCISE: Select all the books that cost less than $5

-- Sort the results with order by
SELECT * FROM book ORDER BY price DESC;
SELECT * FROM book ORDER BY price ASC;
SELECT * FROM book ORDER BY price; -- Note, if not specified, ASCENDING is used.

-- Limit number of results.
SELECT * FROM book limit 2; -- only return the first 2 results

-- Note that limits apply after sorting with ORDER BY.
SELECT * FROM book ORDER BY publish_date LIMIT 3; -- Which means these are the three "oldest" books.

-- MICRO-EXERCISE: Use ORDER BY and LIMIT to select the two most expensive books.

-- You can combine multiple where clauses using "and" and "or"
-- With OR any record where at least one of the clauses is true
-- will be returned.
SELECT 
  *
FROM book
WHERE price > 10 OR publish_date > '1-1-1950';

-- With AND only records where both clauses are true will be returned
SELECT 
  *
FROM book
WHERE price < 5 AND publish_date > '1-1-1950';

-- One last useful trick (though there are many more): Use the "BETWEEN" keyword
-- for any type of data that is organized in a range (numbers, dates, even text alphabetically)
-- Note that case matters in most databases, and that all capital letters are before any lowercase betters.
SELECT title FROM book WHERE title BETWEEN 'O' and 'P'; 
SELECT title FROM book WHERE title BETWEEN 'o' and 'p';

SELECT publish_date FROM book WHERE publish_date BETWEEN '01-01-1950' and '01-01-1970';

SELECT price FROM book WHERE price BETWEEN 5 and 9;

-- You can combine all these features, but they MUST always appear in the proper order (SELECT, COLS, FROM, WHERE, ORDER, LIMIT).
-- Similarly, the features happen in this order, which means this query:
  -- Fetches alll the books priced above $5.00,
  -- Then sorts those books by price (in ascending order)
  -- Then returns just the first two results from that sorted list.
SELECT 
  title,
  author,
  price
FROM book
WHERE price > 5
ORDER BY price
LIMIT 2;

-- MICRO-EXERCISE: Write a query which will return just the single most expensive book published
-- after 1925.
