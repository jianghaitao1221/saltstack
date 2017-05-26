filebeat-repo:
  pkgrepo.managed:
    - name: deb {{salt['pillar.get']('elk:elastic:filebeat:apt_source')}} stable main
    - dist: stable
    - file: /etc/apt/sources.list
    - keyid: D88E42B4
    - keyserver: keyserver.ubuntu.com
    - clean_file: true
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: {{salt['pillar.get']('elk:elastic:apt_key')}}
  pkg.latest:
    - name: filebeat
    - refresh: True

/etc/filebeat/filebeat.yml:
  file.managed:
    - source:  salt://elk/etc/filebeat/filebeat.yml
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - require:
      - pkgrepo: filebeat-repo

filebeat:
  service.running:
    - enable: True
    - sig: filebeat
    - require:
      - file: /etc/filebeat/filebeat.yml
    - watch:
      - file: /etc/filebeat/filebeat.yml
