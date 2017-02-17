#!/bin/bash
set +e

nc -dk -l 65432 &
consul-template -consul localhost:8500 -template "/data/nginx/consul_templ/app.templ:/data/nginx/conf.d/app_upstream.conf:docker exec NginxLatest service nginx reload" > /tmp/consul-template.log
echo Killing: $$
kill -9 -$$
