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
    apt install php php-cli php-xml composer git
    ```

2. Download project base, go to project directory and *optionally* remove **.git** directory:

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

Enable authenticator by adding following under modules in **config/config.yml**:
```yaml
# define module configurations and sometimes classes to be autoloaded
modules:
  # authentication and account handling
  Core\Session:
    timeout: 1800
    authenticators:
      - Account\Yaml\Account
```

Enable routing by prepending following to **config/route.yml**:
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

Add first *admin* user (this might complain about missing file **config/users.yml** before creating it):
```sh
./kehikko account:user -c -r role:admin -p password username
```

Switch to navigation that includes account stuff by modifying **views/base.html** to this:
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
