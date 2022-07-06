# Exercise: Joins

Use this SQL block to create the simple books database (if you've been following along, you wonh't need to do this).

```sql
-- Working with the database we defined in the schema design basics, copied here for ease.
-- The walkthrough starts on line 88.
DROP TABLE author CASCADE;
DROP TABLE book CASCADE;
DROP TABLE book_author CASCADE;
DROP TABLE review CASCADE;
DROP TABLE review_username CASCADE;

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

CREATE TABLE review_username (
    review_id BIGSERIAL PRIMARY KEY REFERENCES review(review_id),
    username text
);

INSERT INTO author (name) VALUES ('Jane Austen');
INSERT INTO author (name) VALUES ('Harper Lee');
INSERT INTO author (name) VALUES ('F. Scott Fitzgerald');
INSERT INTO author (name) VALUES ('Gabriel García Márquez');
INSERT INTO author (name) VALUES ('Truman Capote');
INSERT INTO author (name) VALUES ('Peter Norvig');
INSERT INTO author (name) VALUES ('Stuart J. Russell');

INSERT INTO book (title, publish_date, price) VALUES ('Pride and Prejudice' , '01-28-1813', 7.99);
INSERT INTO book (title, publish_date, price) VALUES ('To Kill a Mockingbird', '07-11-1960', 6.99);
INSERT INTO book (title, publish_date, price) VALUES ('The Great Gatsby', '04-10-1925', 12.50);
INSERT INTO book (title, publish_date, price) VALUES ('One Hundred Years of Solitude', '05-5-1967', 8.99);
INSERT INTO book (title, publish_date, price) VALUES ('In Cold Blood', '09-25-1965', 4.99);
INSERT INTO book (title, publish_date, price) VALUES ('Artificial Intelligence: A Modern Approach 4th Edition', '04-28-2020', 4.99);

INSERT INTO book_author VALUES (1, 1);
INSERT INTO book_author VALUES (2, 2);
INSERT INTO book_author VALUES (3, 3);
INSERT INTO book_author VALUES (4, 4);
INSERT INTO book_author VALUES (5, 5);
INSERT INTO book_author VALUES (6, 6); -- NOTE, book 6 (AI A Modern Approach) has 2 authors.
INSERT INTO book_author VALUES (6, 7);

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

INSERT INTO review_username VALUES (1, 'babbler');
INSERT INTO review_username VALUES (2, 'T');
INSERT INTO review_username VALUES (3, 'sadie_says');
INSERT INTO review_username VALUES (4, 'reading_ruler');
INSERT INTO review_username VALUES (5, 'issaaaacccc');
INSERT INTO review_username VALUES (6, 'boxboy27');
INSERT INTO review_username VALUES (7, 'xi_xi_xi');
INSERT INTO review_username VALUES (8, 'babbler');
INSERT INTO review_username VALUES (9, 'rahm_reads');
INSERT INTO review_username VALUES (10, 'tina55');
INSERT INTO review_username VALUES (11, 'sungurl20');
INSERT INTO review_username VALUES (12, 'MayaForever');

INSERT INTO book (title, publish_date, price) VALUES ('Pretty People Partying' , '07-7-2007', 7.99);
INSERT INTO author (name) VALUES ('William Williamson');
```

# The Exercise:

Write a SQL query for each of the following prompts.

1. Write a query that returns the title and author(s) of every book in our dataset, but does NOT include any authors who have not written a book.

2. Write a query that returns just the title of each book that does not have any reviews. (Hint, use a `WHERE ___ is null` clause and an outer join)

3. Write a query that returns just the name of authors who haven't written any books.

4. Write a query that includes the title, author(s), and each review rating, but only for books that have at least one review.

5. Modify your query from #4 to include all books, regardless of whether or not they have any reviews.