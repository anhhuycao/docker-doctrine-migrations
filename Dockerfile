FROM alpine:3.14.2

RUN apk --update add curl composer bash php7 php7-json php7-phar php7-pdo_mysql \
    php7-pdo_pgsql php7-pdo_sqlite php7-simplexml php7-dom php7-xml php7-xmlwriter \
    php7-tokenizer php7-intl php7-ctype

RUN cd /root && \
    curl -sS -0L https://github.com/doctrine/migrations/archive/refs/tags/3.3.0.tar.gz -o 3.3.0.tar.gz && \
    tar -xvf 3.3.0.tar.gz && \
    rm 3.3.0.tar.gz && \
    cd migrations-3.3.0 && \
    bash build-phar.sh && \
    php /root/migrations-3.3.0/bin/doctrine-migrations.phar && \
    cp /root/migrations-3.3.0/bin/doctrine-migrations.phar /usr/bin/doctrine-migrations && \
    chmod +x /usr/bin/doctrine-migrations && \
    apk del curl && \
    rm -rf /var/cache/apk/*

RUN mkdir /data
VOLUME ["/data"]
WORKDIR /data
ENTRYPOINT ["doctrine-migrations"]