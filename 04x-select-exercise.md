# Basic Select Practice

You can use this SQL code to reset your current books database to a default state. If you've been following along in class you should not need to do this, but may wish to if you want your results to match the instructor's.

```sql
DROP TABLE IF EXISTS book;
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
INSERT INTO book (title, author, publish_date, price) VALUES ('Sense and Sensibility', 'Jane Austen', '10-14-1811', 6.99);
INSERT INTO book (title, author, publish_date, price) VALUES ('To Kill a Mockingbird', 'Harper Lee', '07-11-1960', 6.99);
INSERT INTO book (title, author, publish_date, price) VALUES ('The Great Gatsby', 'F. Scott Fitzgerald', '04-10-1925', 12.50);
INSERT INTO book (title, author, publish_date, price) VALUES ('One Hundred Years of Solitude', 'Gabriel García Márquez', '05-5-1967', 8.99);
INSERT INTO book (title, author, publish_date, price) VALUES ('In Cold Blood', 'Truman Capote', '09-25-1965', 4.99);
INSERT INTO book (title, author, publish_date, price) VALUES ('Brave New World', 'Aldous Huxley', '01-01-1932', 19.84);
INSERT INTO book (title, author, publish_date, price) VALUES ('To The Lighthouse', 'Virginia Woolf', '05-05-1927', 15.00);
INSERT INTO book (title, author, publish_date, price) VALUES ('Frankenstein', 'Mary Shelley', '01-01-1818', 7.50);
INSERT INTO book (title, author, publish_date, price) VALUES ('Beloved', 'Toni Morrison', '09-13-1987', 12.50);
INSERT INTO book (title, author, publish_date, price) VALUES ('Song of Solomon', 'Toni Morrison', '01-01-1977', 12.50);
```

## The Exercise:

Write queries that satisfy the following prompts:

1. Select just the titles of all the books by Jane Austen.

2. Select all the books whose price is larger than $7.00.

3. Select all the books that were published before 1975.

4. Select the price and publish date of the 3 most expensive books.

5. Select the 3 most expensive books that were published after 1960.

6. Select the publish date and price of all the books that were either published before 1930 or that cost more than $10.00.

7. Select all the books that were published after 1930 and cost more than $10.00.

8. Select all the books whose title contains the letter 'e'.

9. Select all the books whose title starts with the letter 'T'.

10. Select all the books that were published in any decade besides the 1960s.

11. Select all the books that were published in in the 1960s.

12. Select all the prices without duplicates.