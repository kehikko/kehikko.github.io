---
---

# Kernel

In *kehikko 2* kernel is not really some singular piece of code or a class, it is a conceptual set of
functions.

## [Configuration](cfg)

Configuration handling functions.

## [Log](log)

Here are all logging related facilities in PSR-3 related style.
Basicly a very simple set of functions consisting of `log_*($message, $context = [])` and `log_if_*($condition, $message, $context = [])`.
