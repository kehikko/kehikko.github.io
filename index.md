---
---

# Getting started
1. Download project base, go to project directory and *optionally* remove **.git** directory:
```sh
git clone https://github.com/kehikko/root <YOUR-PROJECT-NAME>
cd <YOUR-PROJECT-NAME>
rm -rf .git
```

2. Install basic depencies using [composer](https://getcomposer.org/):
```sh
composer update
```

3. Setup asset links:
```sh
./kehikko assets:update
```

3. Run the site as a development version using PHP's built-in web server:
```sh
php -S localhost:8000 web/app.php
```
Then checkout [http://localhost:8000](http://localhost:8000).

4. To make the basic site work with apache, copy example htaccess to web directory:
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
