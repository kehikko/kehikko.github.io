---
---

# Getting started

1. Prerequisites

    * PHP7
        * cli
        * xml
    * composer
    * git

    Easy install in Ubuntu 18.04:
    ```sh
    sudo apt install php php-cli php-xml composer git
    ```

2. Download project base, go to project directory and *optionally* remove `.git` directory:

    ```sh
    git clone https://github.com/kehikko/root <YOUR-PROJECT-NAME>
    cd <YOUR-PROJECT-NAME>
    rm -rf .git
    ```

3. Install basic depencies using [composer](https://getcomposer.org/):

    ```sh
    composer update
    ```

4. Setup asset links:

    ```sh
    ./kehikko assets:update
    ```

5. Run the site as a development version using PHP's built-in web server:

    ```sh
    php -S localhost:8000 web/app.php
    ```

    Then checkout [http://localhost:8000](http://localhost:8000).

6. To make the basic site work with apache, copy example htaccess to web directory:
    
    ```sh
    cp config/htaccess.default web/.htaccess
    ```
    
    Of course you need to setup apache (or any other web server) for this to work and that will not be covered here.

# Basic account and authorization

Install basic account handling packages:
```sh
composer require kehikko/account
composer require kehikko/route-account
composer require kehikko/route-admin
```

Enable authenticator by adding following under modules in `config/config.yml`:
```yaml
# define module configurations and sometimes classes to be autoloaded
modules:
  # authentication and account handling
  Core\Session:
    timeout: 1800
    authenticators:
      - Account\Yaml\Account
```

Enable routing by prepending following to `config/route.yml`:
```yaml
admin:
  pattern: /admin
account:
  pattern: /account
```

Update asset links:
```sh
./kehikko assets:update
```

Add first *admin* user (this might complain about missing file `config/users.yml` before creating it):
```sh
./kehikko account:user -c -r role:admin -p password username
```

Switch to navigation that includes account stuff by modifying `views/base.html` to this:
```twig
  <body>{% raw %}
    {% block navigation %}
    {% include 'navigation-account.html' %}
    {% endblock %}{% endraw %}
```

Now you should be able to login with given *username* and *password* and see some tools under *Account*-menu.


# Filesystem structure

Base system:
```sh
project-root/
    config/
        cli-config.php # doctrine helper, if doctrine is used
        config.yaml # main configuration
        route.yaml # main routes
        translations.yaml # main translations
    routes/
        common/ # single route
            public/ # public files 
                css/
                js/
            views/ # views (templates) to be rendered
                400.html
                403.html
                404.html
                500.html
            config.yml # route configuration, usually contains "javascript:" and "css:" lists
            route.yml # subroutes under this route
            translations.yml # translations to be merged with main translations
    vendor/ # contains external components installed by composer
        ...
    views/ # base views for the site
        base.html # bootstrap based "normal" view
        base-wide.html # bootstrap based wide view
        css.html # included usually from base*.html to insert css
        error-exception.html # exception view for serious errors
        javascript.html # included usually from base*.html to insert javascript
        messages.html # simple layout to view messages system to user
        navigation.html # basic navigation
        navigation-account.html # basic navigation with account menu
    web/ # public (static) files
        app.php # router
        css/
            site.css
        common -> ../routes/common/public # link to public files for a specific route
        js/
            site.js
        images/
            ...
    kehikko # command line tool to do different system tasks
```

# Larger example

## Creating a new module
* Create directory `modules/GoodestCode`
* Create class file `GC.php` in that directory
* This class will use namespace `GoodestCode` (in this use-case it is the same as directory name under `modules` so autoloader will find it without any configuration)
* This class should extend class `\Core\Module` so we get some already existing functionality as base for this model
    * See: <a href="CoreModule">\Core\Module</a>
    * You can also check the code in `vendor/kehikko/core/Module.php`
* Add public function called `who()` to this class that takes single parameter (string) and returns some nice string including the parameter

Now you should have a simple model class in `modules/GoodestCode/GC.php`:
```php
<?php

namespace GoodestCode;

class GC extends \Core\Module
{
    public function who(string $name)
    {
        return 'Who is the goodest coder? Who? You are, ' . $name . ', you are!';
    }
}
```

## Creating a new controller
* Create directory `routes/gc`
    * Create directory `routes/gc/controllers`
* Create class file `routes/gc/controller/GooderCodeController.php`
* This class does not use namespacing but must extend `\Core\Controller`
* Add a public function called `whoAction()` to this class that too takes a single parameter (string)
    * Actions should usually return value using `$this->render(TEMPLATE-NAME, PARAMETERS-ARRAY)`
    * In this example parameters must include what is returned by previously created `\GoodestCode\GC::who()` with the parameter given to this method

Now you should have a simple controller class in `routes/gc/controllers/GooderCodeController.php`:
```php
<?php

class GooderCodeController extends \Core\Controller
{
    public function whoAction(string $name)
    {
        $gc = new \GoodestCode\GC();

        $params = array('who' => $gc->who($name));

        return $this->render('goodcode.html', $params);
    }
}
```

## Creating V from MVC
* Create directory called **views** under **routes/gc** created previously
* Create new template file called **goodcode.html**
    * This uses twig templating: https://twig.symfony.com/

This is how the template could look like:
```twig
<h4>{{ who }}</h4>
```

## Setting up routing
Now we need to set up routing so it knows how to serve the page we just created.
This is pretty simple in current case, so this description will be short.

Add base route to file **config/route-local.yml** (create this file if it does not exist):
```yaml
gc: # this is the directory under routes
  pattern: /goodcode # this is the base url for this route
```

Add subroute to file **routes/gc/route.yml** (create this file if it does not exist):
```yaml
who: # this is for pointing to this route elsewhere from the code
  pattern: /who/{name} # this is the url after base url
  controller: GooderCode # guess what this means
  action: who # and where this leads
```

Difference between **route-local.yml** and **route.yml** in both locations is that the local one
should not be added to version control (git) and the other should. So changes in the local one
are just local to your own development environment and the changes in the other are distributed
to everyone. Using one or another depends highly on the use-case. Testing should be always done in
the local one of course so it does not mess up example production servers!

Now you should be able to see the page in your development host: **http://YOUR-DEV-HOST/goodcode/who/NAME-PARAM/**

## Some extended twig usage
Add new action to the previous controller, add new subroute pointing to it and create new view for it:

Action:
```php
    public function whosAction()
    {
        $params = array();
        $params['names'] = array('ville', 'jaakko', 'pekka', 'sami');
        return $this->render('goodcodes.html', $params);
    }
```

Add to **routes/gc/route.yml**:
```yaml
whos:
  pattern: /whos
  controller: GooderCode
  action: whos
```

New view **views/goodcodes.html**:
* This view must extend **base.html** and put its contents in block called **content**
  * You can check **views/base.html** in project root to see what is in there

```twig
{% raw %}{% extends "base.html" %}

{% block content %}
  {% for name in names %}
    {{ render('who', { name: name }) }}
  {% endfor %}
{% endblock %}{% endraw %}
```

From here you can see that the controller defined at start can be also called from another view using **render()**
in which case it will be rendered in that position in html. This has many uses, making views cleaner by dividing
them in smaller pieces (also see: https://twig.symfony.com/doc/2.x/tags/include.html), collecting many views into one
and so on.

## Now for the hard one
You must create a new view, without any more examples, that fetches contents of **config/tasks.yml** and renders those
tasks into html table under url **/goodcode/tasks/**. Even though this is a simple assignment, remember to make it
using the MVC architecture! Don't skip steps just because it would be easier in this particular assignment. All letters from MVC must be used. Also the previous code must still work as it did before.

Contents example to put into **config/tasks.yml**:
```yaml
tasks:
  - label: Create model
    deadline: first
  - label: Create controller
    deadline: second
  - label: Create view
    deadline: third
```

You can load the yaml into an array in php using following code snippet:
```php
$kernel = \kernel::getInstance();
$data = $kernel->yaml_read($kernel->expand('{path:config}/tasks.yml'));
```

Hint: adding class **table** to the table in html makes it bit prettier to start with:
```html
<table class="table">
...
```
