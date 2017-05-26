{% set java_version = salt['pillar.get']('java_version', '8') %}

oracle-java{{ java_version }}-installer:
  pkgrepo.managed:
    - ppa: webupd8team/java
  pkg.installed:
    - require:
      - pkgrepo: oracle-java{{ java_version }}-installer
  debconf.set:
   - data:
       'shared/accepted-oracle-license-v1-1': {'type': 'boolean', 'value': True}
   - require_in:
       - pkg: oracle-java{{ java_version }}-installer
