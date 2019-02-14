---
---

# RESTful APIs

## Keywords

### accept *(array or call)*

Define accepted values.

### format *(string or call)*

Define formatting of a value.
For `string`, `int`, `float` and `number` [`🔗sprintf`](http://php.net/manual/en/function.sprintf.php) is used.
`datetime` uses php's [`🔗DateTime::format`](http://php.net/manual/en/datetime.format.php).

### min and max *(integer or call)*

Define minimum and maximum value (for numbers) or length (for strings).
