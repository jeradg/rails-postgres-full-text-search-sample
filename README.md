# rails-postgres-full-text-search-sample

## Prerequisites

- Setting up Postgres on your system is beyond the scope of this tutorial. [Digital Ocean has a great post on this topic](https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-macos), which you can check out for instructions.

## Database setup

1. Assuming you already have postgresql installed and running, create the database user for this app with

    ```sh
    createuser -P -d cat_treat_hq
    ```

    and use the password `1234` (which is the username/password combination already set up in `./config/database.yml`).

2. Create the app database by running

    ```sh
    rails db:create
    ```

## Seeding `HelpfulLink` records

You can seed the database with some `HelpfulLink` records by running

```sh
rails db:fixtures:load
```

## Starting the server

Start the app server with

```sh
rails s
```

This starts the app server with the default port `3000`.

Confirm the app is running correctly by visiting http://127.0.0.1:3000/ in a web browser.
