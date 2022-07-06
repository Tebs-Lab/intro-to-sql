# Solution: operators

1. Select the full names of the people from `person.person` whose last name is longer than 10 characters.

```sql
SELECT 
  concat_ws(' ', title, firstname, middlename, lastname, suffix) as fullname,
  lastname, -- The writeup didn't ask for these, but it helps verify the results.
  length(lastname) 
FROM person.person
WHERE length(lastname) > 10;
```

2. Select the `orderqty`, and `scrappedqty` from `production.workorder` and also compute the percent of the total order that was scarped for each order. 

```sql
SELECT
  orderqty,
  scrappedqty,
  cast(scrappedqty as float) / orderqty AS scrapped_precent
FROM production.workorder;
```

3. Using the `-` operator, expand your answer from number 2 to include the number of days that elapsed between `startdate` and `enddate`.

```sql
SELECT
  orderqty,
  scrappedqty,
  cast(scrappedqty as float) / orderqty AS scrapped_precent,
  enddate-startdate as time_to_process
FROM production.workorder;
```

4. For every entry in the `person.address` table compute the full mailing address, including proper line breaks for each section of the address. 

This might be harder than it seems at first...

Hint 1: in Postgres you can use `E'\n'` to represent a linebreak in a string. 

Hint 2: the coalesce function might help as well: [https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-coalesce/](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-coalesce/)

Hint 3: You need to use a join, because some of the information you need is in the `person.stateprovince` table, and some more is in the `person.countryregion` table. Use joins!

```sql
SELECT
concat_ws(E'\n',
    concat_ws(' ', p.title, p.firstname, p.middlename, p.lastname, p.suffix),
    a.addressline1,
    a.addressline2,
    concat_ws(' ', a.city || ',', sp.stateprovincecode, a.postalcode),
    cr.name
) AS "Full Address",
at.name
FROM person.person p
join person.businessentityaddress bea on bea.businessentityid = p.businessentityid
join person.address a on bea.addressid = a.addressid
join person.stateprovince sp on sp.stateprovinceid = a.stateprovinceid
join person.countryregion cr on cr.countryregioncode = sp.countryregioncode
join person.addresstype at on at.addresstypeid = bea.addresstypeid;

```
