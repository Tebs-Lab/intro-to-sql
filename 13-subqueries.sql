/* 
  Subqueries are when you put a query inside another query. 
  Perhaps the most common use of a subquery is as part of a WHERE clause.
  
  Suppose we want all the information from all the rows where the unitprice
  is equal to the maximum value of unit price. We could do it in two queries:
*/

SELECT max(unitprice) FROM sales.salesorderdetail; -- 3578.27
SELECT * FROM sales.salesorderdetail WHERE unitprice = 3578.27;

-- But, if we wanted to automate this task, we'd have a problem if the largest unit price ever got larger.
-- With a subquery, we can put both of these queries in a single query!
SELECT 
  *
FROM 
  sales.salesorderdetail
WHERE
  unitprice=(SELECT max(unitprice) FROM sales.salesorderdetail);
  
-- Subqueries make a lot of things possible which might otherwise be difficult and tedious.
-- Another example, this query determines the top 10 most common first names in our database:
SELECT 
  firstname,
  count(firstname)
FROM person.person
GROUP BY firstname
ORDER BY count(firstname) DESC
LIMIT 10;

-- Using that as a subquery, we can select all the records for all the individuals who have one of these names:
SELECT * FROM person.person WHERE firstname IN (
	SELECT
	  firstname
	FROM person.person
	GROUP BY firstname
	ORDER BY count(firstname) DESC
	LIMIT 10
)
ORDER BY firstname;

-- One more, all the sales that have a larger than average total price (a derived column!)
SELECT 
  salesorderid,
  orderqty,
  unitprice,
  orderqty*unitprice as total_price 
FROM sales.salesorderdetail 
WHERE orderqty*unitprice >= (SELECT avg(orderqty*unitprice) FROM sales.salesorderdetail);

-- MICRO-EXERCISE: Using a subquery, create a query that will return all the salesorderdetails
-- belonging only to the customer who has made the most orders total. You'll need to use the salesorderheader table
-- and a join!
