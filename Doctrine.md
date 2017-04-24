---
---
How to use databases via [Doctrine](http://docs.doctrine-project.org/) in this framework.
SQL entity manager and MongoDB document manager are supported.

This document only describes best practices of using Doctrine with this
framework. Atleast some basic knowledge of SQL and/or MongoDB and Doctrine
is required.

# SQL
* [Doctrine 2 ORM](http://docs.doctrine-project.org/projects/doctrine-orm/).

Using SQL via Doctrine entity manager.

## Configuration
Doctrine configuration should be set in `config-local.yaml` (not `config.yaml`) somewhat like this:
```yaml
doctrine:
    sql:
        driver: pdo_mysql
        host: localhost
        port: 3306
        dbname: sql_db_name
        user: username
        password: pass

```
See Doctrine [Installation and Configuration](http://docs.doctrine-project.org/projects/doctrine-orm/en/latest/reference/configuration.html) for more.

# MongoDB
* [Doctrine MongoDB ODM](http://docs.doctrine-project.org/projects/doctrine-mongodb-odm/).

Using MongoDB via Doctrine document manager.

## Configuration
Doctrine configuration should be set in `config-local.yaml` (not `config.yaml`) somewhat like this:
```yaml
doctrine:
    mongo:
        # this is actually default so it is not required
        server: mongodb://localhost:27017
        # this should be set, though it defaults to 'framework'
        dbname: mongo_db_name

```
