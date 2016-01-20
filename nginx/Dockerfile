FROM debian:jessie
RUN apt-get update && apt-get install -y git wget make gcc libpcre3-dev zlib1g-dev
RUN git clone -b OpenSSL_1_0_2-stable --single-branch https://github.com/openssl/openssl/ && git clone https://github.com/cloudflare/sslconfig
RUN cd openssl && patch -p1 < ../sslconfig/patches/openssl__chacha20_poly1305_cf.patch && cd ..
RUN wget -qO- http://nginx.org/download/nginx-1.9.9.tar.gz | tar -xvz && mv nginx-1.9.9 nginx && cd nginx && ./configure \
--with-http_ssl_module \
--with-http_stub_status_module \
--with-http_gzip_static_module \
--with-http_realip_module \
--with-openssl=/openssl \
&& make && make install && ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx
RUN apt-get remove --auto-remove -y libpcre3-dev zlib1g-dev git wget make gcc && rm -rf /var/lib/apt/lists/*
# forward request and error logs to docker log collector
RUN mkdir /var/log/nginx/ && ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
