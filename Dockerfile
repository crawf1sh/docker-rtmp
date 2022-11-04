FROM ubuntu

LABEL maintainer="NGINX-RTMP-SERVER"

ENV NGINX_VERSION   1.18.0

RUN set -x \
		&& sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
		&& sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
		&& apt update \
		&& apt upgrade -y \
		&& apt install -y nginx libnginx-mod-rtmp

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
		&& ln -sf /dev/stderr /var/log/nginx/error.log

ADD docker-entrypoint.sh docker-entrypoint.sh
ADD docker-entrypoint.d docker-entrypoint.d

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80/tcp
EXPOSE 1935/tcp

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
