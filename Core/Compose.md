---
---

# Compose *(class)*

Simple class for composing stuff from other stuff, i.e. some helpers.

# Methods

## unique($length = 8, $chars = false) *static*
* ⇒ `int $length` Length of the string to return
* ⇒ `mixed $chars` Characters to use, defaults to a-z, A-Z and 0-9
* ⤶ `string` Unique string

Create unique string.

## slug($value) *static*
* ⇒ `string $value` Original string value
* ⤶ `string` Slug string or null if unable to generate

Generate slug from a string.

## bytesToHuman($bytes, $decimals = 2, $divider = 1024) *static*
* ⇒ `int $bytes` Number of bytes
* ⇒ `int $decimals` Decimals to display
* ⇒ `int $divider` Divider, only 1000 and 1024 accepted
* ⤶ `string` Human readable form of bytes to display

Bytes to human readable form.
For divider 1000 postfix can be B, kB, MB and so on.
For divider 1024 postfix can be B, kiB, MiB and so on.

## UUIDv4() *static*
* ⤶ `string` UUID version 4

Create random [UUID, version 4](https://en.wikipedia.org/wiki/Universally_unique_identifier#Version_4_(random)).
