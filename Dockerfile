FROM sebp/elk
MAINTAINER cosmin.cimpoi@gmail.com

RUN echo "discovery.zen.fd.ping_timeout: 60s" >> /etc/elasticsearch/elasticsearch.yml

RUN mkdir -p /var/homebank_small_data
COPY ./data /var/homebank_small_data/data/
RUN chmod 644 /var/homebank_small_data/data/*
COPY ./scripts/homebank_csv_processor.sh /var/homebank_small_data/homebank_csv_processor.sh
WORKDIR /var/homebank_small_data
RUN chmod u+x ./homebank_csv_processor.sh
RUN ["/bin/bash", "-c", "/var/homebank_small_data/homebank_csv_processor.sh"]

COPY ./config/00-homebank-input.conf /etc/logstash/conf.d/00-homebank-input.conf