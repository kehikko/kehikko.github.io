---
---

# Exceptions

Core defines some exception classes to be used as helpers.
These exceptions should be catched in base application entry point or somewhere like that.
System will not handle them.

Example from `web/app.php`:
```php
try {
    ...
} catch (Exception $e) {
    $code = $e->getCode();
    if ($code < 100) {
        $code = 500;
    }
    if ($kernel->format == 'json') {
        json_exception($e, $code);
    } else {
        html_exception($e, $code);
    }
}

function json_exception($e, $code) {
    /* output json exception content */
}

function html_exception($e, $code) {
    /* output html exception content */
}
```

# Classes

* `RedirectException($url, $code = 302, $get = array())`
  * Throws expection that redirects user to given url
* `Exception304($msg = 'Not Modified')`
  * This and following will throw an exception with given http status code
* `Exception400($msg = 'Bad Request')`
* `Exception401($msg = 'Unauthorized')`
* `Exception403($msg = 'Forbidden')`
* `Exception404($msg = 'Not Found')`
* `Exception405($msg = 'Method Not Allowed')`
* `Exception409($msg = 'Conflict')`
* `Exception410($msg = 'Gone')`
* `Exception418($msg = "I'm a teapot")`
* `Exception500($msg = 'Internal Server Error')`
* `Exception501($msg = 'Not Implemented')`
