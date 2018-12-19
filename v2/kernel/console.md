---
---

# Console

Project directories that are searched for command definitions:

* ***configuration*** directory
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


