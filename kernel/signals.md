---
---

# Signals

Kehikko supports signalling which can be used to catch signals emitted from anywhere
else in the code without modifications to that part of the code.

## Catching signals

Signals are catched by hooking into them in configuration:

```yaml
signals:
  log_record: # this signal is always emitted by any log_* -function
    - call: MyModule\MyClass@recordLogMessage
  MyModule\MyClass@generateNewSignal: # this is our own custom signal
    - call: someoneElseMadeThisFunction
```

Now by creating following code snippets the signalling starts working:

```php
namespace MyModule;

class MyClass
{
    public function recordLogMessage($level, $message)
    {
        if ($level === LOG_EMERGENCY) {
            /* now we are in trouble */
            mail('admin@example.com', 'Very bad thing', $message);
        }
    }

    public function generateNewSignal($data) {
        emit();
    }
}
```

```php
function someoneElseMadeThisFunction($data)
{
    var_dump($data);
}

$o = new MyModule\MyClass();
/* dump array in the function above */
$o->generateNewSignal([1,2,3]);
/* send an error email */
log_emergency('Error!');
```

**Note:** So far there is no way to hook into signals in the run time

**See also:** [Read more about how *calls* can be used](calls)

## Functions

### emit(string $signal = null, array $args = [])

Emit a signal that can be caught elsewhere in the software.

When called without any arguments, emits a signal with the same exact
arguments as the function/method it was called in. Name of the signal
in this case is either the *function name* or *class@method*.

When called with arguments, first argument is the signal name and the second
is an array of arguments given to the signal.

