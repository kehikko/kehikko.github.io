---
---

# Kernel
Everything goes through the kernel.

# Methods

## getInstance() *static*
Get current kernel singleton by calling `kernel::getInstance()`.
Use this when there is no other way of accessing kernel:
 from static methods and classes that are not subclasses of
*Controller* or *AbstractModule*.

In controllers and subclasses of *AbstractModule* you should preffer using
`$this->kernel`.

* ⤶ `kernel` Singleton instance of class kernel

## debug()
* ⤶ `bool` *true* if *debug* is set to *true* in config

## expand($content, $vars = null)
Expand variables in *content*.
Variables are detected from `{variable_name}` notation.

Built-in variables:
*path:home*, *path:root*, *path:config*, *path:modules*, *path:routes*, 
*path:views*, *path:cache*, *path:data*, *path:tmp*, *path:web*, *session:username*, 
*session:lang*, *url:base*, *url:error*, *url:login*, *url:assets*, *server:user*, 
*server:group*, *server:uid*, *server:gid*, 

* ⇒ `string $content` String where to expand variables
* ⇒ `array $vars` Key-value paired array of optional extra variables to expand
* ⤶ `string` Expanded content

## tr($text, ...)
Translate.
Optional parameters after *text* are printed as if using
[sprintf()](http://php.net/manual/en/function.sprintf.php).

* ⇒ `string $text` Text to translate
* ⤶ `string` Translated text

## log($level, $message, ...)
Write to log.
Works like php [syslog()](http://php.net/manual/en/function.syslog.php) function except
additional tags can be given.

Any (*string*) arguments given after the first two are
taken as tags for this message.

* ⇒ `int $level` Message severity level, see http://php.net/manual/en/function.syslog.php
* ⇒ `string $message` Message to write
* ⤶ `string` Will always return the message given

## msg($type, $message)
Add a message to be shown to user on next page load.
This is a convenient way to queue messages through session data
to be shown on the next page load for current browser session.

These messages are usually rendered in `views/messages.html`.

Following types, though not restricted to, can be used:
*success*, *error*, *warning*, *info*

* ⇒ `string $type` Message type
* ⇒ `string $message` Message to write
* ⤶ `string` Will always return the message given

## getConfigValue(...)
Get value from configuration or null if value with given key-chain is not found.
Give chain of keys as parameters.

Example:
```php
/* returns true or false */
$kernel->getConfigValue('setup', 'debug');
/* returns whole setup array */
$kernel->getConfigValue('setup');
```
* ⤶ `mixed` Value of the given key set in config

## historyPop($count = 0)
Pop *$count* items from history and return last one popped.

* ⇒ `int $count` Items to pop from history before returning value popped
* ⤶ `string` Popped value


## historyDisable()
Disable current request from being saved into history (session data).

## createTempFile($postfix = null)
Create a temporary file that will be removed when request is finished (in kernel destructor).

* ⇒ `string $postfix` Append this string at the end of the filename
* ⤶ `string` Filename

## url($path = false)
Create manual URL that is prepended with site assets path.

* ⇒ `string $path` Append this string at the end of the URL
* ⤶ `string` URL

## getEntityManager()
Get doctrine entity manager.
See:
* [Using Doctrine with this framework](Doctrine)
* [Doctrine 2 ORM](http://docs.doctrine-project.org/projects/doctrine-orm/)

* ⤶ `Doctrine\ORM\EntityManager` Doctrine entity manager

## getDocumentManager()
Get doctrine document manager.
See:
* [Using Doctrine with this framework](Doctrine)
* [Doctrine MongoDB ODM](http://docs.doctrine-project.org/projects/doctrine-mongodb-odm/)

* ⤶ `Doctrine\ODM\MongoDB\DocumentManager` Doctrine document manager

## getCacheInstance()
Get current cache instance.
This is most probably an instance of *phpfastcache*.

* ⤶ `mixed` Current cache instance or *null* if cache is not available


