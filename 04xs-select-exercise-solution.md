# Basic Select Practice

## The Solutions:

Write queries that satisfy the following prompts:

1. Select just the titles of all the books by Jane Austen.

```sql
SELECT * FROM book WHERE author='Jane Austen';
```

2. Select all the books whose price is larger than $7.00.

```sql
SELECT * FROM book WHERE price > 7;
```

3. Select all the books that were published before 1975.

```sql
SELECT * FROM book WHERE publish_date < '1-1-1975';
```

4. Select the price and publish date of the 3 most expensive books.

```sql
SELECT 
  price,
  publish_date 
FROM book 
ORDER BY price DESC 
LIMIT 3;
```

5. Select the 3 most expensive books that were published after 1960.

```sql
SELECT 
  *
FROM book 
WHERE publish_date >= '1-1-1961'
ORDER BY price DESC
LIMIT 3;
```

6. Select the publish date and price of all the books that were either published before 1930 or that cost more than $10.00.

```sql
SELECT
  price,
  publish_date
FROM book
WHERE publish_date < '1-1-1930' OR price > 10;
```

7. Select all the books that were published after 1930 and cost more than $10.00.

```sql
SELECT
  *
FROM book
WHERE publish_date >= '1-1-1931' AND price > 10;
```

8. Select all the books whose title contains the letter 'e'.

```sql
SELECT * FROM book WHERE title like '%e%';
```

9. Select all the books whose title starts with the letter 'T'.

```sql
SELECT * FROM book WHERE title like 'T%';
```

10. Select all the books that were published in any decade besides the 1960s.

```sql
SELECT * FROM book WHERE publish_date NOT BETWEEN '01-01-1960' AND '12-31-1969';
```

11. Select all the books that were published in in the 1960s.

```sql
SELECT * FROM book WHERE publish_date BETWEEN '01-01-1960' AND '12-31-1969';
```

12. Select all the prices without duplicates.

```sql
SELECT DISTINCT price FROM book;
```
