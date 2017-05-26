elasticsearch-repo:
  pkgrepo.managed:
    - name: deb {{salt['pillar.get']('elk:elastic:elasticsearch:apt_source')}} stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/elasticsearch-2.x.list
    - keyid: D88E42B4
    - keyserver: keyserver.ubuntu.com
    - clean_file: true
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: {{salt['pillar.get']('elk:elastic:apt_key')}}
  pkg.latest:
    - name: elasticsearch
    - refresh: True


elasticsearch:
  service.running:
    - enable: True
    - sig: elasticsearch
    - require:
      - pkgrepo: elasticsearch-repo
