---
---

# Console

Console uses [pear/console_commandline](https://github.com/pear/Console_CommandLine) package from composer to
parse command-line input. Configuration for this parser is given in `console.yml` files across application.

Application directories that are searched for command definitions:

1. ***configuration*** directory
1. ***modules*** directory and subdirectories
1. ***routes*** directory and subdirectories
1. ***vendor*** subdirectories

## Defining new commands

1. Create a new `console.yml` example under `modules`
1. Add at least `commands` section to it
1. Create code for command(s)
1. Test and you are done

### Console.yml format

Field `prefix` can be used to define a prefix for all commands in certain `console.yml`.
If `console.yml` does not specify `prefix`,
prefix is added automatically based on the directory where in `console.yml` is found from.
Prefix can also be set to `false` to disable it.

At least `commands` section is required. Each command needs at least a `description` and `call` to be defined.

This example is from `vendor/kehikko/kernel/console.yml`:

```yaml
#prefix: kernel # this is not needed since we are using default

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

#### Command-line arguments

Defining command-line arguments

