FROM bridgecrew/checkov

COPY entrypoint.sh /entrypoint.sh

COPY config_empty.yml /config_empty.yml

RUN chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]