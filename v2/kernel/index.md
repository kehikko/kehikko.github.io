---
---

# Kernel

In *kehikko 2* kernel is not really some singular file of code or a class, it is a set of
functions.

## [Cache ⇢](cache)

System built-in PSR-16 cache configuration and usage documentation.

## [Calls ⇢](calls)

How to make calls to code from configuration and routing.

## [Configuration ⇢](cfg)

Configuration documentation, both usage and setup.

## [Console ⇢](console)

Console usage and configuration.

## [Log ⇢](log)

Logging related facilities in PSR-3 related style.
Basicly a small set of functions consisting of `log_*($message, $context = [])`
and `log_if_*($condition, $message, $context = [])`
added with configuration.

## [Signals ⇢](signals)

Using signalling.

## [Validation ⇢](validation)

Validating input.

## Other related documentation

### [Profiling 🔗](https://github.com/kehikko/profiler){:target="_blank"}

Profiling can be a very important step in development, sometimes even in the early phases.
Kehikko provides a standalone profiling module that can be used to profile any PHP code.
