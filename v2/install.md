---
---

# Installation

**Note:** Following examples require *composer* to be installed.

## Easy install

Just use *composer* to create new project:

```sh
composer create-project -s dev kehikko/kehikko project_name
cd project_name
```

Now run command `./kehikko` to see available commands:

```sh
./kehikko
```

Start serving:

```sh
php -S localhost:8080 web/index.php
```

## Manual installation

### Base system with command-line only support

Run this wherever you want your project to be created:

```sh
mkdir project
cd project
mkdir cache data config log modules
composer require kehikko/kernel
```

Optionally create local configuration file `config/config-local.yml`. Example contents:

```yaml
setup:
  debug: true
```

Optionally set *composer* binary directory in `composer.json` to project root,
so there is not need to write `./vendor/bin/...` in order to execute binaries.
After this your `composer.json` should look something like this:

```yaml
{
  "require": {
    "kehikko/kernel": "dev-master"
  },
  "config": {
    "bin-dir": "./"
  }
}
```

Test to see available commands:

```sh
./kehikko
```

### Base http routing

Initialize http routing support:

```sh
composer require kehikko/http
mkdir web
```

Create `web/index.php`:

```php
<?php
require_once __DIR__ . '/../vendor/autoload.php';
route_execute();
```

Create `config/route.yml`:

```yaml
index:
  pattern: /
  content: Just installed this
```

Start serving:

```sh
php -S localhost:8080 web/index.php
```
