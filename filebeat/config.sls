{% from "filebeat/map.jinja" import conf with context %}

{% if salt['pillar.get']('filebeat:logz:tls:enabled', False)  %}
{{ salt['pillar.get']('filebeat:logz:tls:ssl_cert_path', '/etc/pki/tls/certs/COMODORSADomainValidationSecureServerCA.crt') }}:
  file.managed:
    - source: https://raw.githubusercontent.com/logzio/public-certificates/master/AAACertificateServices.crt
    - name: /etc/pki/tls/certs/COMODORSADomainValidationSecureServerCA.crt
    - template: jinja
    - makedirs: True
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - filebeat.config
{% endif %}

filebeat.config:
  file.managed:
    - name: {{ conf.config_path }}
    - source: {{ conf.config_source }}
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - cmd: filebeat.service

{% if conf.runlevels_install %}
filebeat.runlevels_install:
  filebeat.service
{% endif %}