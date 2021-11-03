FROM alpine:3.14.2

RUN apk --update add curl composer bash php7 php7-json php7-phar php7-pdo_mysql \
    php7-pdo_pgsql php7-pdo_sqlite php7-simplexml php7-dom php7-xml php7-xmlwriter \
    php7-tokenizer php7-intl php7-ctype git

RUN git clone https://github.com/doctrine/migrations.git && \
    cd migrations && \
    cp ./box.json.dist ./box.json && \
    sh ./build-phar.sh && \
    mv ./build/doctrine-migrations.phar /usr/bin/doctrine-migrations && \
    composer global require symfony/yaml

RUN mkdir /data
VOLUME ["/data"]
WORKDIR /data
ENTRYPOINT ["doctrine-migrations"]