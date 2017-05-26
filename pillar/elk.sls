elk:
  elastic:
    apt-key: http://packages.elastic.co/GPG-KEY-elasticsearch
    elasticsearch: 
      apt_source: http://packages.elastic.co/elasticsearch/2.x/debian
    kibana: 
      apt_source: http://packages.elastic.co/kibana/4.5/debian
    logstash: 
      apt_source: http://packages.elastic.co/logstash/2.3/debian
    filebeat: 
      apt_source: http://packages.elastic.co/beats/apt
