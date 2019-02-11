---
---

# Calls

**TODO: this is a stub**

This document describes how to make calls to code from configuration and routing (and some other places too).

## Return value check

Call return value check can be defined either giving `success` or `fail` in call definition.
Either one can be a string or an array of strings that define type(s) of acceptable return value(s).

**See:** [Validation](validation) for list of accepted types.

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
        return 0.1;
    }

    public function yourNameIs($name)
    {
        echo "Your name is $name\n";
        return new DateTime();
    }
}
```

Call a method that would simply echo `Hello World` and check that it returns a float or int:

```yaml
call: Test\Test@helloWorld
success:
  - int
  - float
```

More advanced call to a method that would echo `Your name is Chandler` and check that it does return an object:

```yaml
call: Test\Test@yourNameIs
args:
  - Chandler
success: object
```

Using keyed arguments, this would also echo `Your name is John Doe` and check that it does not return `null`:

```yaml
call: Test\Test@yourNameIs(my_name)
args:
  my_name: John Doe
fail: 'null' # note that this is in quotes so that it will be parsed as string
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

Calling a function with kehikko system built-in `null`, `true` and `false`:

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
