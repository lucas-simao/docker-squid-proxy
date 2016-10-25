FROM ubuntu:16.04
MAINTAINER lucas.simao01@gmail.com <Lucas da Silva Simão>

RUN apt-get update && apt-get install -y nano squid3 sarg apache2 \
	&& apt-get clean

COPY webmin.tar.gz /home
COPY entrypoint.sh /home/entrypoint.sh
RUN chmod 755 /home/entrypoint.sh

EXPOSE 10000/tcp 3128/tcp 80/tcp 443/tcp

ENTRYPOINT groupadd -r squid && useradd -r -g squid squid \
        && chmod -R 775 /var/spool/squid \
        && chmod -R 775 /var/log/squid \
        && chown -R squid:squid /var/spool/squid \
        && chown -R squid:squid /var/log/squid \
        && /etc/init.d/squid start \
        && /home/entrypoint.sh \
        && /bin/bash
