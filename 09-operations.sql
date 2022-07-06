-- Often times we'll want to combine fields from an individual row to create a new column.
-- SQL provides a wide variety of operators and functions for such situations.
-- Consider this query:
SELECT 
  salesorderid,
  unitprice,
  unitpricediscount,
  unitprice - (unitpricediscount*unitprice) as discounted_unit_price,
  orderqty,
  (unitprice - (unitpricediscount*unitprice))*orderqty as total_price,
  orderqty > 5 as "Ordered more than 5"
FROM sales.salesorderdetail
WHERE unitpricediscount > 0
LIMIT 500;

-- Here, we're using numerical operators (subtraction and multiplication) to create two "derived columns"
-- that we call discounted_unit_price and total_price.
-- Also notice that the same comparison operators we used in WHERE clauses can also be used this way, 
-- and always produce "true" or "false"

-- We can also use functions and operators with textual data. For example:
SELECT 
	title,
	firstname,
	middlename,
	lastname,
	suffix,
	firstname || ' ' || lastname as firstlast,
	concat(firstname, ' ', middlename, ' ', lastname) as firstmiddlelast,
	concat_ws(' ', title, firstname, middlename, lastname, suffix) as fullname
FROM person.person
limit 500;

-- Here are some other useful string processing functions...
SELECT 
	concat_ws(' ', title, firstname, middlename, lastname, suffix) as fullname,
	length(concat_ws(' ', title, firstname, middlename, lastname, suffix)) as fullname_length,
	substring(concat_ws(' ', title, firstname, middlename, lastname, suffix), 1, 5) as first_5_chars_of_fullname,
	substring(concat_ws(' ', title, firstname, middlename, lastname, suffix), 5, 4) as chars_5_to_9,
	upper(firstname) as firstname_all_caps,
	lower(firstname) as firstname_lower,
	strpos(UPPER(firstname), 'D') position_of_first_d
FROM person.person
limit 500;

-- A note on datatypes: some operations might return a surprising result.
SELECT 1/2; -- one divided by two returns zero?!
SELECT 1.0/2.0; -- But this returns 0.5

-- This is because "integer division" always truncates the result 
-- by rounding down to a whole number (always DOWN, never up). 
-- If you want to perform division with columns that have integer types,
-- you need to cast at least one of them first:
SELECT cast(1 as float) / 2;
SELECT 1 / cast(2 as float);

-- Micro-Exercise: Examine the table purchasing.purchaseorderdetail, then write a query that computes the following:
--  * The initial price (combine unitprice and orderqty)
--  * The rejection refund amount (combine rejectedqty and unitprice)
--  * The price after incoroprating the rejection refund (combine both of the two previously derived values)