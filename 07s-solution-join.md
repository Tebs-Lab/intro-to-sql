# The Exercise:

Write a SQL query for each of the following prompts.

1. Write a query that returns the title and author(s) of every book in our dataset, but does NOT include any authors who have not written a book.

```sql
SELECT 
  b.title, 
  a.name
FROM book b
LEFT JOIN book_author ba ON ba.book_id=b.book_id
LEFT JOIN author a ON a.author_id=ba.author_id;
```

2. Write a query that returns just the title of each book that does not have any reviews.

```sql
SELECT b.title FROM book b
LEFT JOIN review r ON r.book_id=b.book_id
WHERE r.review_id is null;
```

3. Write a query that returns just the name of authors who haven't written any books.

```sql
SELECT a.name FROM author a
LEFT JOIN book_author ba on a.author_id=ba.author_id
WHERE ba.book_id is null;
```

4. Write a query that includes the title, author(s), and each review rating, but only for books that have at least one review.

```sql
SELECT 
  b.title, 
  a.name,
  ru.username,
  r.rating
FROM book b
JOIN book_author ba ON ba.book_id=b.book_id
JOIN author a ON a.author_id=ba.author_id
JOIN review r on r.book_id=b.book_id
JOIN review_username ru on ru.review_id=r.review_id;
```

5. Modify your query from #4 to include all books, regardless of whether or not they have any reviews.


```sql
SELECT 
  b.title, 
  a.name,
  ru.username,
  r.rating
FROM book b
LEFT JOIN book_author ba ON ba.book_id=b.book_id
LEFT JOIN author a ON a.author_id=ba.author_id
LEFT JOIN review r on r.book_id=b.book_id
LEFT JOIN review_username ru on ru.review_id=r.review_id;
```
