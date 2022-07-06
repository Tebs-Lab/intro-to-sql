# Exercise: Operations

Before attempting this exercise, you'll have to have restored the AdventureWorks backup included in this repo. Follow the steps laid out in `08s-solution-restore-and-explore` to do so.

## The Exercise:

Write a SQL query for each of the following prompts.

1. Select the full names of the people from `person.person` whose last name is longer than 10 characters.

2. Select the `orderqty`, and `scrappedqty` from `production.workorder` and also compute the percent of the total order that was scrapped for each order. Hint: if you forget to "cast" the input data, you might get an unexpected result.

3. Using the `-` operator, expand your answer from number 2 to include the number of days that elapsed between `startdate` and `enddate`.

4. For every entry in the `person.address` table compute the full mailing address, including proper line breaks for each section of the address. 

This might be harder than it seems at first...

Hint 1: in Postgres you can use `E'\n'` to represent a linebreak as a string. 

Hint 2: the coalesce function might help as well: [https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-coalesce/](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-coalesce/)

Hint 3: You need to use a join, because some of the information you need is in the `person.stateprovince` table, and some more is in the `person.countryregion` table. Use joins!
