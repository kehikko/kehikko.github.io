---
---

In code and templates routes are written in the form ***mainroutename:subroutename***.

The first part (before colon) defines the directory under routes where routing will go next.
The Second part is the name of the route defined in `routes/mainroutename/route.yaml` file.

Just like for [configuration](Configuration), `route-local.yaml` can be used to add and overwrite
routes locally.

# Example
```
config/
       route.yaml
       route-local.yaml (optional)
routes/
       frontpage/
                 route.yaml
                 route-local.yaml (optional)
       auth/route.yaml
       common/route.yaml
       test/route.yaml
```

## main route.yaml
*config/route.yaml*
```yaml
frontpage: # this goes to directory frontpage under routes
    pattern: '/'

auth: # this goes to directory auth under routes
    pattern: '/'

common: # this goes to directory common under routes
    pattern: '/ccc'

test: # you should be getting it now...
    pattern: '/test'
    access: 'role:admin'
```
## route.yaml under routes
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

# Usage Examples
## From Twig template
### Rendering
```html
{% raw %}
<div class="index-content">
    <!-- this will render index action from route test into the twig template -->
    {{ render('text:index') }}
</div>
<!-- this will render example action from route test giving slug1 value slug1value
     and input (GET) parameter GET1 value value1 -->
<div class="example-content">
    {{ render('test:example', { 'slug1': 'slug1value' }, { 'GET1': 'value1' }) }}
</div>
{% endraw %}
```
### Links
```html
{% raw %}
<!-- this will create a link to index action of route test -->
<a href="{{ route('test:index') }}">link</a>

<!-- this will create a link to exmaple action of route test,
     the link url will look something like this:
     /test/slug1value/?GET1=value1 -->
<a href="{{ route('test:example', { 'slug1': 'slug1value' }, { 'GET1': 'value1' }) }}">link</a>
{% endraw %}
```
## From controller code
```php
class TestController extends Controller
{
    public function indexAction()
    {
        /* create link url to another route */
        $url = $this->route('test:example',
                            array('slug1' => 'slug1value'),
                            array('GET1' => 'value1'));

        /* rendering is different in PHP,
         * you could use renderRoute() which is similar to twig template style,
         * but you should not.
         */

        return $this->render('index.html', array('url' => $url));
    }

    public function exampleAction($slug1)
    {
        $params = array(
            'slug1' => $slug1,
            'GET1' => $this->input('GET1'),
        );
        return $this->render('test-template.html', $params);
    }
}
```