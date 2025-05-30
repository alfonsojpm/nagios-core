FROM debian:bullseye-slim

LABEL maintainer="Alfonso Pumar"

RUN apt-get update && apt-get install -y \
    autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php \
    libgd-dev libmcrypt-dev libssl-dev daemon \
    && rm -rf /var/lib/apt/lists/*

RUN useradd nagios && groupadd nagcmd && usermod -a -G nagcmd nagios

WORKDIR /tmp

RUN wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.14.tar.gz && \
    tar zxvf nagios-4.4.14.tar.gz && \
    cd nagios-4.4.14 && \
    ./configure --with-command-group=nagcmd && \
    make all && \
    make install && \
    make install-commandmode && \
    make install-init && \
    make install-config && \
    make install-webconf

RUN htpasswd -cb /usr/local/nagios/etc/htpasswd.users nagiosadmin nagiosadmin && \
    a2enmod cgi && \
    chown -R www-data:www-data /usr/local/nagios/share

RUN a2ensite nagios

EXPOSE 80

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
