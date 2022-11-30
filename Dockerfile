FROM freeradius/freeradius-server:latest

COPY raddb/ /etc/raddb/

RUN chmod 640 /etc/raddb/clients.conf && \
    chmod 644 /etc/raddb/mods-config/files/authorize && \
    chmod +x /etc/raddb/*.sh

RUN apt update && \
    apt install -y ncat

CMD nohup /etc/raddb/healthcheck.sh & freeradius -X
