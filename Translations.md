---
---

Simple translations loading from yaml files is implemented.
They use *lang* variable from [configuration](Configuration).

Main translations are in `config/translations.yaml` and every route can add it's
own translations using `routes/route/translations.yaml`. ***All*** of these files
will be merged into single translation data. `translations.yaml` files are loaded
in the order which routes are defined and main translations from
`config/translations.yaml` will be loaded last so they will always override 
ones loaded from routes.

If some translation tag is not found, the tag itself will be printed:
```php
$this->tr('actions/delete');
```
Will output:
```
actions/delete
```
If translation *actions/delete* is not defined for current language.

# Example:
*routes/test/translations.yaml*
```yaml
en:
    actions:
        save: 'Saving'
        add: 'Adding'
        create: 'Creating'
```
*config/translations.yaml*
```yaml
en:
    title:
        site: 'Framework'
        home: 'Home'
        404: 'Page not found'
        500: 'Internal server error'
    label:
        email: 'Email'
        name: 'Name'
    actions:
        save: 'Save'
        add: 'Add'
    msg:
        my_message: 'Hi there user %s'
fi:
    title:
        site: 'Framework'
    ...
de:
    title:
        site: 'Framework'
    ...
```
Resulting translation data:
```yaml
en:
    ...
    actions:
        save: 'Save'
        add: 'Add'
        create: 'Creating'
    ...
fi:
    ...
de:
    ...
```

# Usage Examples
## From Twig template
```html
<button type="button">{{ tr('actions/save') }}</button>
<!-- this will render example action from route test giving slug1 value slug1value
     and input (GET) parameter GET1 value value1 -->
<p class="message">
    {{ tr('msg/my_message', username()) }}
</p>
```
## From controller code
```php
class TestController extends Controller
{
    public function someAction()
    {
        $username = $this->session->get('username');
        $msg = $this->tr('msg/my_message', $username);
    }
}
```