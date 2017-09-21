{% from "minion/map.jinja" import minion with context %}
{% set hostname=grains['id'] %}
salt-minion:
  pkg:
    - installed
  {% if salt['pillar.get']('minion:'+hostname+':roles', '') is defined %}
  file.managed:
    - name: {{ minion.lookup.path }}
    - user: root
    - group: root
    - mode: 640
    - source: salt://minion/minion.jinja
    - template: jinja
  {% endif %}
  service.running:
    - enable: True
    - name: {{ minion.lookup.service }}
    - require:
      - file: {{ minion.lookup.path }}
at:
  pkg.installed: []

restart-salt-minion:
  cmd.wait:
    - name: echo salt-call --local service.restart salt-minion | at now + 1 minute
    - order: last
    - require:
      - pkg: at
    - watch:
      - file: salt-minion
      - pkg: salt-minion
