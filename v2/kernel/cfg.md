---
---

# Configuration

**TODO: this is a stub**

## Files

**TODO: remember to write about pointing to other configuration options**

## Cache

Configuration can be cached on system level. This is separate from [cache](cache) meant for application
and does not use the same mechanics. Instead configuration cache file is written either using PHP's built-in
*json*-functions or *igbinary*-extension if it is available.

Configuration cache file is created by running `./kehikko kernel:cache:config` in project root.
This command will print a *NOTICE*-level message of where it wrote the file.

After creating cache file, configuration must be initialized manually to use this cached file before any other
calls to system functions. This is usually done in application entry point.

Example `index.php` that every page load uses:

```php
<?php
require_once __DIR__ . '/../vendor/autoload.php';
/* first argument points to main configuration, second to cache file */
cfg_init(__DIR__ . '/../config/config.yml',
         __DIR__ . '/../cache/__kehikko/configuration.cache.json');
/* normal stuff after this ... */
```

**Note:** If configuration cache file is not found, normal configuration loading is executed, so it is not harmful trying to load it

## Functions

### mixed cfg($arg1, $arg2 = null, $arg3 = null)

* `$arg1` can be an array of keys or a string key or an object
* `$arg2` default value to return or sub-key depending on first argument
* `$arg3` default value or ignored depending on first argument

Return value from configuration or default if value with given key-chain is not found.
If key is a string it is separated using period into sections.

#### Examples

Most common use-case is simply to give key and optional default:

```php
/* using array keys */
echo cfg(['my_config', 'sub_value']) . "\n";
echo cfg(['my_config', 'sub_value2'], 'my default value') . "\n";
/* using string key with period as section separator */
echo cfg('my_config.sub_value') . "\n";
echo cfg('my_config.sub_value2', 'my default value') . "\n";
```

Using this configuration:

```yaml
my_config:
  sub_value: I set this in my own config
```

Previous code would echo following:

```
I set this in my own config
my default value
I set this in my own config
my default value
```

### bool cfg_debug()

A simple call to check if debugging is enabled.

### array cfg_init(string $cfg_file = null, string $cfg_cache_file = null)

Initializes configuration from file given as first argument or from default location if it is null.
This function is called automatically using default if configuration has not been initialized manually.
Usually there is no need to call this manually.

**TODO: this is a stub**
