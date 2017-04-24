---
---
Controllers are found under routes.
They contain the logic for all calls made to every route.

# Example
## Directory Setup
```
routes/test/
            controllers/TestController.php
            views/index.html
            views/test-template.html
            route.yaml
```
## route.yaml
*routes/test/route.yaml*
```yaml
index: # url: /test/
    pattern: '/'
    controller: 'Test'
    action: 'index'

example: # url: /test/{slug1}/
    pattern: '/{slug1}'
    controller: 'Test'
    action: 'example'
```
## Twig Templates
*views/index.html*
```html
{% extends 'base.html' %}
{% block content %}

{% endblock content %}
```
*views/test-template.html*
```html
{% extends 'base.html' %}
{% block content %}

{% endblock content %}
```
