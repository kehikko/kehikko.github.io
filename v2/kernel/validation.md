---
---

# Validation

Validating input.

## Functions

### tool_validate($type, &$value, $convert = true, $extra = null)

Validate `$value` according to `$type`.
If `$convert` is `true` then `$value` is modified to be requested type if it is not.
Usually this conversion means converting numeric strings to `int` or `float` and
time based strings to `DateTime`.

**Types supported:**

* `string`
  * String validator is also used when `$type` parameter evaluates to `true` through `empty($type)`
* `int` ⇢ `int`
* `float` ⇢ `float`
* `number` ⇢ `float`
* `bool`
* `null`
* `array`
* `object`
* `email`
* `ip`
  * Both IPv4 and IPv6 are accepted
* `ipv4`
* `ipv6`
* `url`
  * Can be any kind of url, scheme could be `ssh://` or `https://` for example
* `datetime` ⇢ `class DateTime`
  * You can set default timezone by giving `DateTimeZone` in `$extra` parameter
* `timestamp` ⇢ `class DateTime`
  * You can set default timezone by giving `DateTimeZone` in `$extra` parameter
* `fqdn`
* `fqdn-wildcard`
  * Accept FQDN with wildcard at begin (FQDN starting with `*.`)
