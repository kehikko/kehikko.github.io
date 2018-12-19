---
---

# Logging facilities

Three logging methods are supported:  
* console: write log entries into console when using kehikko from command line
* file: write to file
* syslog: write to syslog using php's syslog() -function

## Configuration

Your configuration may change following attributes about logging:

```yaml
log:
  level: VERBOSE|..|EMERGENCY # DEBUG
  console: # these apply when using kehikko from command line
    enabled: true|false # true
    level: VERBOSE|..|EMERGENCY # log.level
    colors: true|false # true
  file: # generic logging into a file
    enabled: true|false # true
    level: VERBOSE|..|EMERGENCY # log.level
    file: /path/to/log.file # "{path.log}/kernel.log"
  syslog: # writing log entries into syslog using php's syslog() -function
    enabled: true|false # false
    level: VERBOSE|..|EMERGENCY # log.level
```

**Note:** Default shown as comment  
**Note:** Any other style logging method can be handled how ever you wish by hooking into the signal logging functions send

### Levels

* VERBOSE (custom level, actually translated to DEBUG, enables bit more fine-grained debugging)
* DEBUG
* INFO
* NOTICE
* WARNING
* ERROR
* CRITICAL
* ALERT
* EMERGENCY

## Signals

Logging functions send one and exactly one signal when any logging function is called ***after*** system configuration has been loaded
and last after all other methods:

`(int $level, string $message)`

**Note:** Message has already been translated using context given to logging functions  
**Note:** This signal is always emitted and receiver should take care about what to do with what level messages

## Functions

[PSR-3](https://www.php-fig.org/psr/psr-3/) style logger functions. Note that this is not PSR-3 per se.

If context array is given for any logging function then any placeholder in message that matches delimiting braces and a key in 
context array, will be replaced with the value for that key in context (see example).

Every function also has a conditional counterpart.
Example `log_if_debug($condition, string $message, array $context = [])` will write to log if `$condition` evaluates as `true`.
This is a loose evaluation using `if ($condition) { write to log }`.

### Examples

To produce an error log entry with contents *"Test error from My Name"*, you could call `log_error()` with following arguments:

```php
log_error('Test error from {name}', ['name' => 'My Name']);
```

To produce conditional debug message:

```php
log_if_debug(are_we_in_dev(), 'We are in development environment.');
```

### log_verbose(string $message, array $context = [])

Write a verbose message to log. Verbose messages are rarely shown.

### log_debug(string $message, array $context = [])

Write a debug level message to log.

### log_info(string $message, array $context = [])

Write an info level message to log.

### log_warning(string $message, array $context = [])

Write a warning level message to log.

### log_error(string $message, array $context = [])

Write an error level message to log.

### log_critical(string $message, array $context = [])

Write a critical level message to log.

### log_alert(string $message, array $context = [])

Write an alert level message to log.

### log_emergency(string $message, array $context = [])

Write an emergency level message to log.

### log_if_verbose($condition, string $message, array $context = [])

Write a verbose message conditionally to log. Verbose messages are rarely shown.

### log_if_debug($condition, string $message, array $context = [])

Write a debug level message conditionally to log.

### log_if_info($condition, string $message, array $context = [])

Write an info level message conditionally to log.

### log_if_warning($condition, string $message, array $context = [])

Write a warning level message conditionally to log.

### log_if_error($condition, string $message, array $context = [])

Write an error level message conditionally to log.

### log_if_critical($condition, string $message, array $context = [])

Write a critical level message conditionally to log.

### log_if_alert($condition, string $message, array $context = [])

Write an alert level message conditionally to log.

### log_if_emergency($condition, string $message, array $context = [])

Write an emergency level message conditionally to log.

### log_record(int $level, string $message, array $context = [], $emit = true)

* `$level` Message severity level, see [php syslog() -> priority](http://php.net/manual/en/function.syslog.php)
* `$message` Message to write
* `$context` Optional message context array
* `$emit` Optional, mainly for internal use. If false, no signal will be emitted within this function.

Write to log with given arbitrary level.

