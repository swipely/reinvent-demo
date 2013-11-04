reinvent-demo
=============

Demo for Swipely's Data Pipeline talk

Setup
-----

* MySQL instance:

    ```
    create database customer_demo;
    use customer_demo;
    create table sales_by_day (store varchar(32), day datetime, total_sales decimal(10,2), primary key (store, day));

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

