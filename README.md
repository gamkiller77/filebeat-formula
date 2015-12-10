# filebeat-formula
Install and configure filebeat.

## Available states

* filebeat.install
* filebeat.config
* filebeat.service

## filebeat.install

Installs the filebeat package.

## filebeat.config

configures filebeat, and installs rc levels for startup on reboot.

### Usage

See pillar.example for example configuration.

### Overriding defaults

This formula puts some system specific configuration in map.jinja. the may be overridden in your pillar data like so:
```
filebeat:
  lookup:
    config_source: salt://mycustom/filebeat/filebeat.jinja
```

## filebeat.service

Starts the filebeat service. 

* Due to filebeat requiring tty to start, this state uses a SSH loopback to achieve this. (use_vt / sudoers !requiretty did not resolve this on 2015.8.x...) *
