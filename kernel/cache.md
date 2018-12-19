---
---

# Cache

Kehikko provides a simple caching function called `cache()` that returns
a [PSR-16](https://www.php-fig.org/psr/psr-16/) cache driver.
This eases cache usage at application level.

As default calling `cache()` will return so called *null* driver which does not
actually cache anything.

## Example

Accessing cache:

```php
$data = cache()->get('my.data.key');
if ($data !== null) {
    return $data;
}
$data = fetch_data_from_somewhere_slow();
cache()->set('my.data.key', $data, 300);
return $data;
```

## Configuration

Configuring caching is simple.

Setting up Symfony PSR-16 cache component after installing it using `composer require symfony/cache`:

```yaml
cache:
  enabled: true
  call: Symfony\Component\Cache\Simple\FilesystemCache@
  args: # arguments are optional
    - test           # namespace
    - 0              # default ttl
    - '{path:cache}' # path
```

Setting up PhpFastCache PSR-16 component after installing it using `composer require phpfastcache/phpfastcache`:

```yaml
cache:
  enabled: true
  call: Phpfastcache\Helper\Psr16Adapter@
  args:
    - Files # type of caching
#    - path: '{path:cache}' # options, phpfastcache will log a warning about
                            # an old configuration style if you set this
```

**See also:** [Read more about how *calls* can be used](calls)

## Functions

### object cache($object = null)

Get current cache object. Will initialize cache object with either default *null* driver or with settings
from configuration if cache has not been initialized yet.

Another way is to give a PSR-16 cache object in argument `$object` if you need to initialize
your cache driver somewhat manually. This **will** override current cache driver, but only if
`cache.enabled = true` in configuration.

**Note:** If `cache.enabled = false` a *null* driver is **always** returned

## System functions

These should not be used from any application.

### bool cache_clear()

Remove all files under `{path:cache}`.

### mixed cache_write_system_data(string $file, $data)

Write data to system cache.

### mixed cache_read_system_data(string $file)

Read data from system cache.

### bool cache_config()

Create configuration cache file.

### bool cache_translations()

Create translations cache files.
