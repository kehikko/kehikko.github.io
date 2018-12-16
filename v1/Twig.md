---
---

[Twig](https://twig.sensiolabs.org/) is used for templating as default. For Twig installation, see [Setup](Setup#twig).

# Methods exposed to templates
These methods are exposed to templates besides Twig built-ins.

## name()
Get name of current user. If name is empty, username is returned. *null* if not logged in.

## username()
Get username of current user. *null* if not logged in.

## authorize(level)
Check if current user has given authorization level. Returns true or false.

## lang()
Get current language.

## msg(type, message)
Log message to be shown on next time page is rendered. Message types:
*success*, *error*, *warning*, *info*

## tr(key)
Translate text.

## asset(filename)
Get asset URL.

## image(filename)
Get image URL.

## css(filename)
Get css URL.

## js(filename)
Get javascript URL.

## byte_to_human(bytes)
Convert bytes to human readable form.
