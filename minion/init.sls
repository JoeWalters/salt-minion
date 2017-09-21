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

restart-salt-minion:
  cmd.run:
    - name: 'salt-call --local service.restart salt-minion'
    - bg: True
    - order: last
    - onchanges:
      - file: salt-minion
      - pkg: salt-minion
