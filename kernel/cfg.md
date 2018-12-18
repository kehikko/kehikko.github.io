---
---

# Configuration

## Files

**TODO: remember to write about pointing to other configuration options**

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
