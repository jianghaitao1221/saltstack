logstash-repo:
  pkgrepo.managed:
    - name: deb {{salt['pillar.get']('elk:elastic:logstash:apt_source')}} stable main
    - dist: stable
    - file: /etc/apt/sources.list
    - keyid: D88E42B4
    - keyserver: keyserver.ubuntu.com
    - clean_file: true
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: {{salt['pillar.get']('elk:elastic:apt_key')}}
  pkg.latest:
    - name: logstash
    - refresh: True

/etc/logstash/conf.d/filebeat-input.conf:
  file.managed:
    - source:  salt://elk/etc/logstash/conf.d/filebeat-input.conf
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - require:
      - pkgrepo: logstash-repo

/etc/logstash/conf.d/mylog-filter.conf:
  file.managed:
    - source:  salt://elk/etc/logstash/conf.d/mylog-filter.conf
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - require:
      - file: /etc/logstash/conf.d/filebeat-input.conf

/etc/logstash/conf.d/mylog-output.conf:
  file.managed:
    - source:  salt://elk/etc/logstash/conf.d/mylog-output.conf
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - require:
      - file: /etc/logstash/conf.d/mylog-filter.conf

logstash:
  service.running:
    - enable: True
    - sig: logstash
    - require:
      - file: /etc/logstash/conf.d/mylog-output.conf
    - watch:
      - file: /etc/logstash/conf.d/mylog-output.conf
      - file: /etc/logstash/conf.d/filebeat-input.conf
      - file: /etc/logstash/conf.d/filebeat-input.conf
