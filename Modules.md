---
---

# The *M* from [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller)

# AbstractModule
Variable *kernel* is always available in *AbstractModule* instances:
```php
$this->kernel->...;
```
## Methods
### getModuleValue()
Get configuration value under this module or null if value with given key-chain is not found.
Give chain of keys as parameters.

#### Example
*config/config.yaml*
```yaml
modules:
    MyClass:
        class: MyModule/MyClass
        settings:
            my_setting1: true
```
*modules/MyModule/MyClass.php*
```php
class MyClass extends AbstractModule
{
    public function doSomething()
    {
        $this->getModuleValue('settings', 'my_setting1');
    }
}
```
* ⤶ `mixed` Value of the given key set in config

### cacheGet($key, $default = null)
Get value with given cache key.

* ⇒ `string $key` Cache key
* ⇒ `mixed $default` Default value to return if value not found or caching not available
* ⤶ `mixed` Value of the given key set in cache or *$default* if not found or caching not available

### cacheSet($key, $value, $ttl = 600)
Set value for given cache key.

* ⇒ `string $key` Cache key
* ⇒ `int $ttl` Expiration time for cached data
* ⤶ `mixed` *true* if set or *null* if caching not available

### cacheDelete($key)
Delete value for given cache key.

* ⇒ `string $key` Cache key
* ⤶ `mixed` *true* if deleted or *null* if caching not available

### emit($name)
Emit signal, additional arguments can be given after *$name*.

Emitted signal name, when receiving signals, is *class name:$name*.

* ⇒ `string $name` Name of the signal

# Example
```php
class MyClass extends AbstractModule
{
    public function doSomething($content)
    {
        /* get module setting which is set in
         * configuration modules section
         */
        $yes = $this->getModuleValue('settings', 'my_setting1');
        if ($yes !== true)
        {
            return false;
        }

        $filename = $this->kernel->createTempFile();
        if (file_put_contents($filename, $content) === false)
        {
            $this->kernel->log(LOG_ERR, 'failed writing to temp file');
            return false;
        }

        /* this will emit signal 'MyClass:write-temp-file' */
        $this->emit('write-temp-file', $filename);
        return true;
    }
}
```
