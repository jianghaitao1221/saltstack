salt-minion-repo:
  pkgrepo.managed:
    - humanname: SaltStack Repo
    - name: deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest {{ grains['lsb_distrib_codename'] }} main
    - dist: {{ grains['lsb_distrib_codename'] }}
    - key_url: https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub
  pkg.latest:
    - name: salt-minion
    - refresh: True

/etc/salt/minion:
  file.managed:
    - source: salt://{{ sls }}/etc/salt/minion
    - user: root
    - group: root
    - makedirs: True
    - require:
      - pkgrepo: salt-minion-repo

salt-minion:
  service.running:
    - enable: True
    - sig: salt-minion
    - require:
      - file: /etc/salt/minion
    - watch:
      - file: /etc/salt/minion
