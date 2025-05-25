# Dockerfile

FROM httpd:2.4.59

# PHP-FPM 및 관련 모듈 설치
RUN apt-get update && \
    apt-get install -y \
        php8.1 php8.1-fpm php8.1-mysql php8.1-curl php8.1-mbstring \
        procps curl vim && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN sed -i '/^security.limit_extensions/c\security.limit_extensions =' /etc/php/8.1/fpm/pool.d/www.conf

# mod_proxy 및 mod_proxy_fcgi 활성화
RUN sed -i 's|#LoadModule proxy_module modules/mod_proxy.so|LoadModule proxy_module modules/mod_proxy.so|' /usr/local/apache2/conf/httpd.conf && \
    sed -i 's|#LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so|LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so|' /usr/local/apache2/conf/httpd.conf

# 웹 파일 복사
COPY html/ /usr/local/apache2/htdocs/

# PHP-FPM과 Apache를 함께 실행하는 스크립트
RUN echo '#!/bin/bash\n\
php-fpm8.1 &\n\
httpd-foreground' > /start.sh && chmod +x /start.sh

EXPOSE 80

CMD ["/start.sh"]

