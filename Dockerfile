FROM freeradius/freeradius-server:latest

COPY raddb/ /etc/raddb/

RUN chmod 640 /etc/raddb/clients.conf
RUN chmod 644 /etc/raddb/mods-config/files/authorize
