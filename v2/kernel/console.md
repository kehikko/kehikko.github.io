---
---

# Console

Uses [pear/Console_CommandLine](https://github.com/pear/Console_CommandLine).

Project directories that are searched for command definitions:

* ***config*** directory
* ***modules*** directory and directories under it
* ***routes*** directory and directories under it
* directories under ***vendor***

## Defining new commands

1. Create a new `console.yml`
1. Add at least `commands` section to it
1. Create code for command(s)
1. Test and you are done

### Console.yml format

At least `commands` section is required. Each command needs at least a `description` and `call` to be defined.
This is the simplest case when no arguments or options are required.

This example is from kehikko 2 `kernel` directory:

```yaml
commands:
  cache:clear:
    description: Clear cache
    call: cache_clear
  cache:config:
    description: Create configuration cache file
    call: cache_config
  cache:translations:
    description: Create translations cache file
    call: cache_translations
```

**See also:** [Read more about how *calls* can be used](calls)

These commands will appear in command line tool `./kehikko` (executed in project root) as following commands:

* `kernel:cache:clear`
* `kernel:cache:config`
* `kernel:cache:translations`

First part `kernel:` is added automatically based on the directory where in `console.yml` is found from.
You can change this by adding `prefix: my_prefix` to `console.yml` above `commands` section.

#### Arguments

Arguments are defined for each command individually under `arguments` section.
Each argument requires only `description`.

Optional specifiers for arguments are:

 * `optional: true`
 * `default: default value if argument was not given`
 * `multiple: true`

Example arguments definition:

```yaml
commands:
  test:
    description: Example call
    call: exampleCommand
    arguments:
      action:
        description: Some action definition
      optional:
        description: Some optional second argument
        optional: true
        default: none
      files:
        description: List of files, multiple can be given
        multiple: true
        optional: true
```

#### Options

Arguments are defined for each command individually under `options` section.
Each argument requires `description` and either `short_name` or `long_name`.

Optional specifiers for options are:

 * `default: default value if option was not given`
 * `action: StoreInt|StoreTrue|StoreFalse|...`

Example options definition:

```yaml
commands:
  test:
    description: Example call
    call: exampleCommand
    options:
      int:
        short_name: -i
        action: StoreInt
        default: -1
      do:
        long_name: --do
        action: StoreTrue
      string:
        short_name: -s
        long_name: --string
        default: none
```

### Usage from code

Call defined in `console.yml` for each command receives three parameters:

 1. Command name
 1. Arguments array
 1. Options array

Example usage using previous arguments and options:

```php
function exampleCommand($cmd, $args, $options)
{
    log_info('You executed example call, command is: ' . $cmd);
    log_notice('Action given: ' . $args['action']);
    log_notice('Optional given: ' . $args['optional']);
    log_warning('Files given:');
    foreach ($args['files'] as $file) {
        log_warning(' - ' . $file);
    }
    log_error('Options:');
    log_error(' - int: ' . $options['int']);
    log_error(' - do: ' . ($options['do'] ? 'yes' : 'no'));
    log_error(' - string: ' . $options['string']);
    return true;
}
```

Now by typing `./vendor/bin/kehikko my_prefix:test test` under your project root
you get an output similar to this:

```
INFO You executed example call, command is: my_prefix:test
NOTICE Action given: test
NOTICE Optional given: none
WARNING Files given:
ERROR Options:
ERROR  - int: -1
ERROR  - do: no
ERROR  - string: none
```

Go on and add some arguments and options to see what happens.
