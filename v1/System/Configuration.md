---
---

# Configuration

# config.yaml
For a working setup, you need a `config/config.yaml`.

Following fields ***can*** be set in basic kernel configuration:

* setup *(array)*
    * debug *(boolean)*
    * lang *(string)*: **en**
    * locale *(string)*: [setlocale(LC_ALL, locale)](http://php.net/manual/en/function.setlocale.php)
* urls *(array)*
    * base *(string)*: **/**
    * error *(string)*: **/404/**
    * forbidden *(string)*: **/403/**
    * login *(string)*: **/login/**
    * assets *(string)*: **/**
* directories *(array)* (usually you simply do not define these and leave them as is)
    * root *(string)*: **defaults to project directory**
    * config *(string)*: **{directory:root}/config**
    * modules *(string)*: **{directory:root}/modules**
    * routes *(string)*: **{directory:root}/routes**
    * views *(string)*: **{directory:root}/routes**
    * web *(string)*: **{directory:root}/web**
    * cache *(string)*: **{directory:root}/cache**
    * data *(string)*: **{directory:root}/data**
    * tmp *(string)*: **/tmp/**
* modules *(array)*
    * *array of modules available to this project*
* javascript *(list)*
    * *list of javascript files to include from [Files|Public Files]([Kernel#Public)]*
* css *(list)*
    * *list of css files to include from [Files|Public Files]([Kernel#Public)]*

# config-local.yaml
*config-local.yaml* is meant for local modifications to *config.yaml*. Everything you put in *config-local.yaml* will override that specific setting in *config.yaml*.

Example:

*config.yaml*
```yaml
setup:
    debug: false
    lang: en
```
*config-local.yaml*
```yaml
setup:
    debug: true
```
Resulting configuration:
```yaml
setup:
    debug: true
    lang: en
```

# Example configuration
*config.yaml*
```yaml
# as default production is assumed, so no debug which defaults to false
setup:
  lang: fi

# define autoloader class files here
modules:
  # core
  AbstractModule: 'Core/AbstractModule'
  Exceptions: 'Core/Exceptions'
  Controller: 'Core/Controller'
  Validate: 'Core/Validate'
  Compose: 'Core/Compose'
  # authentication and account handling
  Session:
    class: 'Core/Session'
    authenticators:
      - UserDefault
  AbstractUser: 'Auth/AbstractUser'
  AbstractRoles: 'Auth/AbstractRoles'
  UserDefault: 'Auth/Default/UserDefault'
  RolesDefault: 'Auth/Default/RolesDefault'
  # for project
  MyClass:
    class: 'MyModule/MyClass'
    # accesible from module using $this->getModuleValue('settings')
    settings:
      # accesible from module using $this->getModuleValue('settings', 'my_setting1')
      my_setting1: true
      my_setting2:
        my_array_setting1: 'yes and no'
        my_array_setting2: null

# twig setup
twig:
  debug: false
  cache: false

# basic site js/css includes
javascript:
  - common:*
  - bootstrap:*
  - auth:*
  - admin:*
  - site.js # includes web/js/site.js
css:
  - common:*
  - bootstrap:*
  - auth:*
  - admin:*
  - site.css # includes web/css/site.js
```
*config-local.yaml*
```yaml
# override debug from your local configuration
setup:
  debug: true
# setup database settings ALWAYS locally
doctrine:
  driver: pdo_mysql
  host: sql.server
  port: 3306
  dbname: database
  user: name
  password: pass
```
