---
---

# Calls

**TODO: this is a stub**

This document describes how to make calls to code from configuration and routing (and some other places too).

## Examples

### Class

Lets assume you have this piece of code:

```php
namespace Test;

class Test
{
    /* note: in this example it must be possible to
     * call constructor of this class without arguments
     */
    public function __construct($ok_go_on_and_create_this_class = true)
    {
        if (!$ok_go_on_and_create_this_class) {
            throw new \Exception('Invalid constructor parameters');
        }
    }

    public function helloWorld()
    {
        echo "Hello World\n";
    }

    public function yourNameIs($name)
    {
        echo "Your name is $name\n";
    }
}
```

Call a method that would simply echo `Hello World`:

```yaml
call: Test\Test@helloWorld
```

More advanced call to a method that would echo `Your name is Chandler`:

```yaml
call: Test\Test@yourNameIs
args:
  - Chandler
```

Using keyed arguments, this would also echo `Your name is John Doe`:

```yaml
call: Test\Test@yourNameIs(my_name)
args:
  my_name: John Doe
```

Forcing a call without arguments, in this case an exception would occur:

```yaml
call: Test\Test@yourNameIs()
args:
  - Chandler
```

Using a call to create new instance of class in return:

```yaml
call: Test\Test@
```

This time an exception occurs:

```yaml
call: Test\Test@(false)
```

### Function

Calling a function with kehikko system built-in parsing of strings `null`, `true` and `false` to their respective types:

```yaml
call: var_dump(null,true,false)
```

This can also be achieved with `args`, though in that case `null`, `true` and `false` are parsed as part of yaml specification:

```yaml
call: var_dump()
args:
  - null
  - true
  - false

--- OR ---

call: var_dump(first,second,third)
args:
  first: null
  second: true
  third: false
```
