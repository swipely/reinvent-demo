reinvent-demo
=============

Demo for Swipely's Data Pipeline talk

Setup
-----

* Settlements data file saved to s3://swipely-reinvent-demo/data/settlements.csv with form `card_token, store, occurred_at, price, authorization_id`:

    ```
    abc01,merchant-20,2012-06-08 00:59:25,1495,123
    abc02,merchant-09,2012-06-12 22:09:30,2800,456
    abc03,merchant-09,2012-06-12 22:43:37,2550,789
    ```

* MySQL instance:

    ```
    create database customer_demo;
    use customer_demo;
    create table sales_by_day (store varchar(64), day datetime, total_sales decimal(10,2), primary key (store, day));

    create user 'pipeline'@'%' identified by '...';
    grant all privileges on customer_demo.* to 'pipeline'@'%';
    ```

* config.yml:

    ```
    db_host: db-customer-demo.cynvbd7p6omk.us-east-1.rds.amazonaws.com
    db_database: customer_demo
    db_username: pipeline
    db_password: ...
    ```

