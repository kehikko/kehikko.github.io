---
---

# Doctrine

How to use databases via [Doctrine](http://docs.doctrine-project.org/) in kehikko.

Supports:
* [SQL Entity Manager](#sql)
* [MongoDB Document Manager](#mongodb)

This document only describes configuration and best practices of using Doctrine with kehikko.
At least some basic knowledge of SQL and/or MongoDB and Doctrine is required.

# SQL

* [Doctrine 2 ORM](http://docs.doctrine-project.org/projects/doctrine-orm/)

Using SQL via Doctrine Entity Manager.

Metadata for entities must be written in YAML files that end in `.dcm.yml`.

## Installation

```sh
sudo apt install php-mysql
composer require kehikko/data
composer require doctrine/orm
```

## Configuration

Doctrine configuration should be set in `config/config-local.yaml` (not `config/config.yaml`) somewhat like this:
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

## Command-Line

File `config/cli-config.php` creates *Doctrine Entity Manager* for `doctrine` command.
There is no need to modify this file.

After configuration is ok and Doctrine packages have been installed,
try running `./doctrine` command from project root. It should output list of commands
available:
```
aehparta@dev:~/www/kehikko$ ./doctrine
Doctrine Command Line Interface version 2.4.8

Usage:
  command [options] [arguments]

Options:
  -h, --help            Display this help message
...
```
## Usage

[Kernel](Kernel) will search SQL entity metadata under directory named `sql`
from all module parent directories listed in [configuration](Configuration) `modules` section.
Metadata entities must be written in YAML and filenames must end in `.dcm.yml`.

Example of entity metadata file placement in filesystem:
```
modules/
    MyModule/
        MyEntity.php
        sql/
            MyEntity.dcm.yml
```

It is recommended to write simple entity classes without extending them example
with `\Core\Module` so it is easier to transfer them to other systems if needed.
That said:
* If entity class needs `kernel`, it should be requested using `kernel::getInstance()`
* If entity class needs *Entity Manager*, it should be requested using global function `get_entity_manager()`

Try to avoid doing either.

### Code Examples

```php
class TestController extends Controller
{
    public function testAction()
    {
        $em = \get_entity_manager();
        $repository = $em->getRepository('MyEntity');
        $my_entities = $repository->findAll();
        ...
        $my_entity = new MyEntity();
        $em->persist($my_entity);
        $em->flush();
        ...
    }
}
```

```php
class MyClass extends \Core\Module
{
    public function doSomething()
    {
        $em = \get_entity_manager();
        $repository = $em->getRepository('MyEntity');
        $my_entities = $repository->findAll();
        ...
        $my_entity = new MyEntity();
        $em->persist($my_entity);
        $em->flush();
        ...
    }
}
```

# MongoDB

* [Doctrine MongoDB ODM](http://docs.doctrine-project.org/projects/doctrine-mongodb-odm/)

Using MongoDB via Doctrine Document Manager.

Metadata for entities must be written in YAML files that end in `.dcml.yml`.

## Installation

```sh
sudo apt install php-mongodb
composer require kehikko/data
composer require doctrine/mongodb
```

## Configuration

Doctrine configuration should be set in `config/config-local.yaml` (not `config/config.yaml`) somewhat like this:
```yaml
doctrine:
    mongo:
        # localhost:27017 is default so in that case this line is not needed
        server: mongodb://localhost:27017
        # this should be set, though it defaults to 'framework'
        dbname: mongo_db_name

```
## Usage

[Kernel](Kernel) will search MongoDB entity metadata under directory named `mongodb`
from all module parent directories listed in [configuration](Configuration) `modules` section.
Metadata entities must be written in YAML and filenames must end in `.dcm.yml`.

Example of entity metadata file placement in filesystem:
```
modules/
    MyModule/
        MyEntity.php
        mongodb/
            MyEntity.dcm.yml
```

Otherwise using MongoDB through Doctrine is pretty much the same as using SQL.

### Code Examples

```php
class TestController extends Controller
{
    public function testAction()
    {
        $dm = \get_document_manager();
        $repository = $dm->getRepository('MyEntity');
        $my_entities = $repository->findAll();
        ...
        $my_entity = new MyEntity();
        $dm->persist($my_entity);
        $dm->flush();
        ...
    }
}
```

```php
class MyClass extends \Core\Module
{
    public function doSomething()
    {
        $dm = \get_document_manager();
        $repository = $dm->getRepository('MyEntity');
        $my_entities = $repository->findAll();
        ...
        $my_entity = new MyEntity();
        $dm->persist($my_entity);
        $dm->flush();
        ...
    }
}
```
