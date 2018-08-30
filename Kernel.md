---
---

# Kernel
Everything goes through the kernel.

# Methods

## getInstance() *static*
* ⤶ `kernel` Singleton instance of class kernel

Get kernel singleton by calling `kernel::getInstance()`.
Use this when there is no other way of accessing kernel:
 from static methods and classes that are not subclasses of
*Controller* or *AbstractModule*.

In controllers and subclasses of *AbstractModule* you can use `$this->kernel`.

## debug() *static*
* ⤶ `bool` *true* if *debug* is set to *true* in config

## emit($parent, $name) *static*
* ⇒ `string $parent` Parent (class) emiting this signal
* ⇒ `string $name` Name of signal

Emit a signal. Usually you should use `\Core\Module::emit()` for this.

## expand($content, $vars = null) *static*
* ⇒ `string $content` String where to expand variables
* ⇒ `array $vars` Key-value paired array of optional extra variables to expand
* ⤶ `string` Expanded content

Expand variables in *content*.
Variables are detected from `{variable_name}` notation.

#### Built-in variables:
* *path:home*
* *path:root*
* *path:config*
* *path:modules*
* *path:routes*
* *path:views*
* *path:cache*
* *path:data*
* *path:tmp*
* *path:web*
* *session:username*
* *session:lang*
* *url:base*
* *url:error*
* *url:login*
* *url:assets*
* *server:user*, 
* *server:group*
* *server:uid*
* *server:gid*

#### Example
```php
$custom_config_file = kernel::expand('{path:config}/custom_config.yml');
```

## tr($text_id, ...) *static*
* ⇒ `string $text_id` Text identifier to translate
* ⤶ `string` Translated text

Translate identifier to text.
Optional parameters after *text* are printed as if using
[sprintf()](http://php.net/manual/en/function.sprintf.php).

#### Example
Contents of `config/translations.yml`:
```yaml
en:
  title:
    site: My Site
```
Code:
```php
/* will echo "My Site" when language is set to english */
echo kernel::tr('title:site');
```

## log($level, $message, ...) *static*
* ⇒ `int $level` Message severity level, see [php syslog()](http://php.net/manual/en/function.syslog.php)
* ⇒ `string $message` Message to write
* ⤶ `string` Will always return the message given

Write to log.
Works like [php syslog()](http://php.net/manual/en/function.syslog.php) function except
additional tags can be given.

Levels:
* ***LOG_EMERG***:	system is unusable
* ***LOG_ALERT***:	action must be taken immediately
* ***LOG_CRIT***:	critical conditions
* ***LOG_ERR***:	error conditions
* ***LOG_WARNING***:	warning conditions
* ***LOG_NOTICE***:	normal, but significant, condition
* ***LOG_INFO***:	informational message
* ***LOG_DEBUG***:	debug-level message

Any (*string*) arguments given after the first two are
taken as tags for this message. Tags can be used to sort and filter messages afterwards.

## msg($type, $message) *static*
* ⇒ `string $type` Message type
* ⇒ `string $message` Message to write
* ⤶ `string` Will always return the message given

Add a message to be shown to user on next page load.
This is a convenient way to queue messages through session data
to be shown on the next page load for current browser session.

These messages are usually rendered in `views/messages.html`.

Following types, though not restricted to, can be used:
* *success*
* *error*
* *warning*
* *info*

## getConfigValue(...) *static*
* ⤶ `mixed` Value of the given key set in config

Get value from configuration or null if value with given key-chain is not found.
Give chain of keys as parameters.

Example:
```php
/* returns true or false */
kernel::getConfigValue('setup', 'debug');
/* returns whole setup array */
kernel::getConfigValue('setup');
```

## historyPop($count = 0) *static*
* ⇒ `int $count` Items to pop from history before returning value popped
* ⤶ `string` Popped value

Pop *$count* items from history and return last one popped.

## historyDisable() *static*
Disable current request from being saved into history (session data).

## createTempFile($postfix = null) *static*
* ⇒ `string $postfix` Append this string at the end of the filename
* ⤶ `string` Filename

Create a temporary file that will be removed when request is finished (in kernel destructor).

## url($path = false) *static*
* ⇒ `string $path` Append this string at the end of the URL
* ⤶ `string` URL

Create manual URL that is prepended with site assets path.

## getCacheInstance() *static*
* ⤶ `mixed` Current cache instance or *null* if cache is not available

Get current cache instance.
This is most probably an instance of *phpfastcache*.

## yamlRead($file, $ttl = 600) *static*
* ⇒ `string $file` Filename of YAML-file to read
* ⇒ `int $ttl` TTL for caching file contents
* ⤶ `mixed` Data read from file or *false* on errors

Read data from YAML-file.

## yamlWrite($file, $data) *static*
* ⇒ `string $file` Filename of YAML-file to be written
* ⇒ `mixed $data` Data to write into YAML-file
* ⤶ `bool` *true* on success, *false* on failure

Write data to YAML-file.

# Signals

## kernel:log
* ⇒ `string $message` Message logged
* ⇒ `int $level` [syslog()](http://php.net/manual/en/function.syslog.php) priority level
* ⇒ `int $timestamp` Timestamp from time()
* ⇒ `string $address` Remote address (from `$_SERVER['REMOTE_ADDR']`) or `console`
* ⇒ `int $port` Server port to which the connection was made (from `$_SERVER['SERVER_PORT']`)
* ⇒ `string $session_id` Session ID
