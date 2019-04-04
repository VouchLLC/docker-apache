FROM intxlog/ubuntu1804

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_ALLOW_XDEBUG=1
ENV COMPOSER_DISABLE_XDEBUG_WARN=1
ENV COMPOSER_MEMORY_LIMIT=-1

RUN echo "deb http://ppa.launchpad.net/malteworld/ppa/ubuntu bionic main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 20D0BB61B700CE29

RUN echo "deb http://ppa.launchpad.net/ondrej/apache2/ubuntu bionic main" >> /etc/apt/sources.list
RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu bionic main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C

RUN apt-get update

RUN apt-get install --assume-yes --no-install-recommends --no-install-suggests \
    apache2 \
    libapache2-mod-php7.2 \
    pdftk \
    php-geoip \
    php-yaml \
    php7.2-bcmath \
    php7.2-bz2 \
    php7.2-cli \
    php7.2-common \
    php7.2-curl \
    php7.2-gd \
    php7.2-intl \
    php7.2-json \
    php7.2-ldap \
    php7.2-mbstring \
    php7.2-msgpack \
    php7.2-pdo \
    php7.2-pgsql \
    php7.2-pdo-pgsql \
    php7.2-readline \
    php7.2-simplexml \
    php7.2-soap \
    php7.2-sockets \
    php7.2-xml \
    php7.2-yaml \
    php7.2-zip \
    php7.2-xdebug \
    php7.2-redis 

RUN apt-get purge --assume-yes --auto-remove \
    --option APT::AutoRemove::RecommendsImportant=false \
    --option APT::AutoRemove::SuggestsImportant=false
RUN rm -rf /var/lib/apt/lists/*

RUN curl -LS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer

COPY etc/apache2 /etc/apache2
COPY etc/php /etc/php/7.2

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

RUN chown root:root /usr/local/bin/*
RUN chmod 755 /usr/local/bin/*

STOPSIGNAL SIGWINCH

CMD ["apache2", "-DFOREGROUND"]
