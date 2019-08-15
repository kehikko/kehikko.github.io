---
---

# RESTful APIs

## Keywords

**Note:** When a keyword accepts a call, that call must return one of the other accepted types.

### accept *(array or call)*

Define accepted values.

#### Example

```yaml
api_request:
  pattern: /api/request
  api:
    my-value1:
      type: int
      accept:
        - 0
        - 50
        - 100
    my-value2:
      type: string|null
      accept:
        - low
        - medium
        - high
        - null
```

### format *(string or call)*

Define formatting of a value. This applies only when outputting values, not for input (*create* or *update*).
For types `string`, `int`, `float` and `number` [`🔗sprintf`](http://php.net/manual/en/function.sprintf.php) is used.
`datetime` uses php's [`🔗DateTime::format`](http://php.net/manual/en/datetime.format.php).

**Note:** Formatting is done after validating output value according to `type`, so the output might not be valid
according to `type` after formatting.

#### Example: float

This example will always print 3 decimals:

```yaml
api_request:
  pattern: /api/request
  api:
    my-value:
      type: float
      format: '%.3f'
```

#### Example: string

This example will cut string to at most 8 characters:

```yaml
api_request:
  pattern: /api/request
  api:
    my-value:
      type: string
      format: '%8s'
```

#### Example: datetime

This example will only output year, month and day:

```yaml
api_request:
  pattern: /api/request
  api:
    my-value:
      type: float
      format: 'Y-m-d'
```

### min and max *(integer or call)*

Define minimum and maximum value (for numbers) or length (for strings).

### required *(bool, array or call)*

Define value requirement for each request mode.
Mode can be *create (POST)*, *update (PUT/PATCH)* or *read (GET)*.

1. If not given it is `true` as default
1. If given as bool, the same value is applied for all modes
1. If given only for some modes, default is still `true` for modes that are not given

So you need only to disable requirement for a value for modes you want to.

#### Example

```yaml
api_request:
  pattern: /api/request
  api:
    my-value1:
      type: int
      required: false
    my-value2:
      type: int
      required:
        create: false
        update: false
        read: false
```

### timezone *(string or call)*

Default timezone used when `type` is `datetime`.

### type *(string)*

`type` is a string that defines validator for API request value.
Same validator types can be applied as for [`🔗validate()`](/v2/kernel/validation)
as it is directly called when validating API data.

Define multiple types using `|` as separator.
Most usual use-case is allowing `null` or `bool` with some other type.
Even in this case with example the keyword `accept` you need to define
`null`, `true` or `false` as accepted value besides others.

Defining too many multiple types at once can lead to undefined behaviour when combined with other keywords.

**Note:** This keyword *cannot* use calls to fetch it's value.
