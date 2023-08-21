# Exercise: Joins

Use this SQL block to create the simple books database (if you've been following along, you wonh't need to do this).

```sql
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
INSERT INTO author (name) VALUES ('William Williamson');

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
INSERT INTO book (title, publish_date, price) VALUES ('Pretty People Partying' , '07-7-2007', 7.99);

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
INSERT INTO review (book_id, rating, content) VALUES (3, 10, 'Powerful commentary on the lies communities tell themselves about their own goodness.');
INSERT INTO review (book_id, rating, content) VALUES (3, 8, 'Cutting and poignient, but dated. For a book about modern racism try "The Hate U Give"');
INSERT INTO review (book_id, rating, content) VALUES (3, 6, 'I do not understand how they could find Tom Robinson guilty. He obviously did not do it. Unrealistic.');
INSERT INTO review (book_id, rating, content) VALUES (4, 4, 'Gatsby was a real jerk.');
INSERT INTO review (book_id, rating, content) VALUES (4, 8, 'A masterwork about the evils of oppulence.');
INSERT INTO review (book_id, rating, content) VALUES (5, 4, 'The translation to English was poor, you should read this in the original Spanish if you can.');
INSERT INTO review (book_id, rating, content) VALUES (5, 9, 'A remarkable story about how our ancenstry follows us into the future and haunts our present.');
INSERT INTO review (book_id, rating, content) VALUES (6, 10, 'A genre defining masterwork with a chilling subject.');
INSERT INTO review (book_id, rating, content) VALUES (6, 3, 'Too much evil in this book, don''t read it!');
INSERT INTO review (book_id, rating, content) VALUES (6, 6, 'The writing is incredible, but Capote takes too many liberties with crucial facts of the case to be considered non-fiction.');

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
```

# The Exercise:

Write a SQL query for each of the following prompts.

1. Write a query that returns the title and author(s) of every book in our dataset, but does NOT include any authors who have not written a book.

2. Write a query that returns just the title of each book that does not have any reviews. (Hint, use a `WHERE ___ is null` clause and an outer join)

3. Write a query that returns just the name of authors who haven't written any books.

4. Write a query that includes the title, author(s), and each review rating, but only for books that have at least one review.

5. Modify your query from #4 to include all books, regardless of whether or not they have any reviews.

6. Write a query that identifies which books don't have a book_fulltext record.
