---
---

# Validate *(class)*

Simple class for validation.

# Methods

## assoc($array) *static*

Check whether or not an array is associative. Array is considered to be an associative array
when keys are not the same as indexes.

## email($email) *static*

* ⇒ `string $email` String to validate as email
* ⤶ `bool` true if email was valid

Check if string is a valid email address. Uses [filter_var()](http://php.net/manual/en/function.filter-var.php).

## FQDN($domain, $allow_wildcard = false) *static*

* ⇒ `string $domain` String to validate as [FQDN](https://en.wikipedia.org/wiki/Fully_qualified_domain_name)
* ⇒ `bool $allow_wildcard` Allow wildcard (`*.example.com`)
* ⤶ `bool` true if domain was valid

Validate string as Fully Qualified Domain Name (FQDN).

## slug($slug) *static*

* ⇒ `string $slug` String to validate as slug
* ⤶ `bool` true if slug was valid

Validate simple slug. Allow only lower case ascii letters, numbers and underscore.

## UUID($uuid) *static*

* ⇒ `string $uuid` String to validate as UUID
* ⤶ `bool` true if UUID was valid

Validate UUID.
