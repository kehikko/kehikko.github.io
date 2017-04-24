
# Files 
Kernel searches it's basic setup files from `config/`-directory in project root folder. To be exactly specific, kernel searches these files from `<kernel.php>/../config`-directory.

Kernel needs some basic setup files in order to work. These two files are mandatory:

* config/config.yaml (see [Configuration](Configuration))
* config/route.yaml (see [Routing](Routing))

Optional setup files are:

* config/config-local.yaml
* config/route-local.yaml
* config/translations.yaml (see [Translations](Translations))

# External Libraries
External libraries are supported as default using [Composer](https://getcomposer.org/). Install libraries under directory `lib/`. Kernel will automatically detect if Composer autoloader exists in `lib/vendor/autoload.php`.

## Install Composer
If directory `lib/` does not already exist, create it. Go to directory `lib/` and install composer into this directory if your system does not include the command `composer`.
```sh
mkdir lib
cd lib
# Go to https://getcomposer.org/download/ to see about installation.
```

## Twig
Twig is the only ***mandatory*** library. Kernel will work fine without Twig, but templating does not. If templating is not needed at all or base [Controller](Controller) class is rewritten, then installing Twig can be skipped.

### Install Twig
```sh
cd lib
composer require "twig/twig:~1.0"
```

# Basic Directory Structure Example
```
config/
       config.yaml
       route.yaml
kernel/
       kernel.php
       console.php
modules/
        Core/
             AbstractModule.php
             Compose.php
             Controller.php
             Exceptions.php
             Session.php
             Validate.php
        Auth/
             AbstractRoles.php
             AbstractUser.php
             Default/
                     RolesDefault.php
                     UserDefault.php
        MyModule/MyClass.php
routes/
       auth/...
       common/...
       test/
            controllers/TestController.php
            views/test-template.html
            public/
                   css/...
                   js/...
                   images/...
            config.yaml
            route.yaml
views/base.html
lib/
    vendor/...
    composer.json
web/
    .htaccess
    app.php
    css/...
    js/...
    images/...
    auth/ -> routes/auth/
    common/ -> routes/common/
    test/ -> routes/test/
```
