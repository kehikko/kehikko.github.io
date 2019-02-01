---
---

# Installation

## Manual install

```sh
mkdir project
cd project
composer require kehikko/kernel
mkdir config modules cache data log
```

Optionally create base configuration file `config/config.yml`. Example contents:

```yaml
setup:
  debug: true
```
