# Installing, Starting, and Administering PostgreSQL

Database systems have a lot of components, which can make managing a database difficult. Most of the time analysts and programmers are only accessing a database rather than setting one up and maintaining it. However, going through these steps can really help programmers see "under the hood" and understand databases more deeply, which in turn can help in communications with technical support, database administrators, and more. 

Additionally, in order to fully explore SQL it helps a lot to have super-user / administrative access to a database. Especially a database that can be deleted and modified without consequence to the business. 

## Step 1: Install Postgres

Because it's easy and supported on all three major OS platforms (MacOS, Windows, and Linux) we're using the EDB installer for Postgres. You can find that here: [https://www.enterprisedb.com/downloads/postgres-postgresql-downloads](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)

Things to note:

* Use the default directory for the installation, but make a note of where that is. 
    * Also make special note of the Data Directory location.
    * You'll want to know these later when we initialize our database and start / stop the server.
* You must install PostgreSQL Server, pgAdmin 4, and Command Line Tools. 
    * You can install Stack Builder if you wish, but we won't use it in this workshop.
* Use a password you will remember for the postgres user, or write it down somewhere. 
    * If you forget this, resetting it is a real pain. 
* Use the default port: 5432
* Unless you know what you're doing and why, use the default locale.

If all went well, a Postgres database server will have started itself and is waiting for a connection!

## Step 2: Launch pgAdmin and Connect To Our Server

You have installed an app called pgAdmin 4 as part of step 1. Find it and launch it using Spotlight or the Windows search feature. If you cannot find it that way, navigate to the install directory that you noted in step 1, and look for the app in that folder.

* On the left you'll see an icon labeled "servers"
* Click on the arrow to expand the list of servers.
* You should see an icon that says "Postgres 13"
* Click on it, you should be asked for the password for your postgres user which you noted in step 1.
* Now you should see that you have (at least) one database in the Postgres 13 server called `postgres`

You're now connected as the superuser and you can create more databases, query those databases, and more from here.

## Step 3: Create Our First Database

* Right click on the "databases" underneath the Postgres 13 server and select `create > database`
* Name it `test` and make the owner the `postgres` user.
* Click save.
* It should appear in your list on the left hand panel
* Right click it and select `query tool`
