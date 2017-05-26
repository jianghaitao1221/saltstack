kibana-repo:
  pkgrepo.managed:
    - name: deb {{salt['pillar.get']('elk:elastic:kibana:apt_source')}} stable main
    - dist: stable
    - file: /etc/apt/sources.list
    - keyid: D88E42B4
    - keyserver: keyserver.ubuntu.com
    - clean_file: true
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: {{salt['pillar.get']('elk:elastic:apt_key')}}
  pkg.latest:
    - name: kibana
    - refresh: True

kibana:
  service.running:
    - enable: True
    - sig: kibana
    - require:
      - pkgrepo: kibana-repo
