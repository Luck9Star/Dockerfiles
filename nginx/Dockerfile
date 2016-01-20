FROM debian:jessie
MAINTAINER Luck9Star <hadyenvip@gmail.com>
RUN apt-get update && apt-get install -y git wget make gcc libpcre3-dev zlib1g-dev &&\
git clone -b OpenSSL_1_0_2-stable --single-branch https://github.com/openssl/openssl/ && git clone https://github.com/cloudflare/sslconfig &&\
cd openssl && patch -p1 < ../sslconfig/patches/openssl__chacha20_poly1305_cf.patch && cd .. &&\
wget -qO- http://nginx.org/download/nginx-1.9.9.tar.gz | tar -xvz && mv nginx-1.9.9 nginx && cd nginx && ./configure \
--prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_stub_status_module --with-http_auth_request_module --with-threads --with-stream --with-stream_ssl_module --with-http_slice_module --with-mail --with-mail_ssl_module --with-file-aio --with-http_v2_module --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed' --with-ipv6 \
--with-openssl=/openssl &&\
make && make install &&\
apt-get remove --auto-remove -y libpcre3-dev zlib1g-dev git wget make gcc && rm -rf /var/lib/apt/lists/* && rm -rf /nginx && rm -rf /openssl
# forward request and error logs to docker log collector

RUN adduser --system --no-create-home --disabled-password --group nginx
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
