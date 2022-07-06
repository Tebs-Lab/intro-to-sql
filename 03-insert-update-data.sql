-- Lets recreate our book table and add some data to it...
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
INSERT INTO book VALUES (1, 'Pride and Prejudice', 'Jane Austen', '01-28-1813', 7.99);

-- MICRO-EXERCISE: Why does this line raise an error? What has to change to fix the error?
INSERT INTO book VALUES (1, 'Pride and Prejudice', 'Jane Austen', '01-28-1813', 15.50);

-- Specify only some columns, null or the default value will be used for unspecified columns.
INSERT INTO book (title, author, publish_date, price) VALUES ('To Kill a Mockingbird', 'Harper Lee', '07-11-1960', 6.99);
INSERT INTO book (title, author, publish_date, price) VALUES ('The Great Gatsby', 'F. Scott Fitzgerald', '04-10-1925', 12.50);
INSERT INTO book (title, author, publish_date, price) VALUES ('One Hundred Years of Solitude', 'Gabriel García Márquez', '05-5-1967', 8.99);
INSERT INTO book (title, author, publish_date, price) VALUES ('In Cold Blood', 'Truman Capote', '09-25-1965', 4.99);

-- We'll do a lot more selecting later, but lets look at the result of these inserts:
select * from book;

-- MICRO-EXERCISE: insert two more books of your choice to the table, then use SELECT to prove it worked as you expected.

-- Update existing row(s)
UPDATE book SET price=10.99; -- sets the price of ALL BOOKS to 10.99
UPDATE book SET price=12.50 WHERE book_id=4; -- Only changes book 1's price.
UPDATE book SET price=50.00 WHERE publish_date < '01-01-1960'; -- Change prices for all books published before 1960.

-- Lets see what happened
select * from book;

-- MICRO-EXERCISE: Change the prices of the two books you inserted using UPDATE

-- Delete existing row(s)
DELETE FROM book WHERE book_id=1;

-- MICRO-EXERCISE: Delete Truman Capote's book from the table.

-- FYI: Deletes all the books, generally a *very* bad idea in production databases.
DELETE FROM book; 


