
Public files are files that are directly exposed and accessible from site URL
(static files).

Global public files live in `web/`:
```
web/
    css/
    js/
    images/
```

Route specific public files live in `public/` under route:
```
routes/
       test/
            public/
                   css/
                   js/
                   images/
```

# Usage
## From Twig template
URLs to static files can be generated in Twig using these four functions:
* asset(filename)
* css(filename)
* js(filename) or javascript(filename)
* image(filename)

*css()*, *js()* or alias *javascript()* and *image()* are just there to make your life bit
easier. They prefix given filename with path `css/`, `js/` or `images/` accordingly and call *asset()*.

Default public file links point to `web/`.
By prepending the filename with *routename:* (note the following colon) they can be set to point to
directory `public/` under given route.
For this to work correctly, you need to run `php kernel/console.php update:assets`
when you modify your main `config/route.yaml` file.


### Examples
```html
<a href="{{ asset('docs/my.pdf') }}">My PDF doc</a>
<img src="{{ image('logo.png') }}" />
<img src="{{ image('test:custom.png') }}" />
```
