#!/bin/sh

cat >> /etc/nginx/nginx.conf << EOF

rtmp {
    server {
        listen 1935;
        chunk_size 4096;

        application live {
            live on;
            hls on;
            wait_key on;
            hls_path /tmp/hls;
            hls_fragment 10s;
            hls_playlist_length 60s;
            hls_continuous on;
            hls_cleanup on;
            hls_nested on;
        }
    }
}

EOF
