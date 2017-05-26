install_nginx:
  pkg.installed:
    - name: nginx

nginx:
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: install_nginx

/etc/nginx/sites-available/default:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source:  salt://{{ sls }}/etc/nginx/sites-available/default
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: nginx_service
