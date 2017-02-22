#!/bin/bash
set +e

nc -w 1 localhost 65432 && exit 100
nc -dk -l 65432 &
ncPid=$!
consul-template -consul localhost:8500 -template "/data/nginx/consul_templ/app.templ:/data/nginx/conf.d/app_upstream.conf:docker exec NginxLatest service nginx reload" > /tmp/consul-template.log
kill -9 ${ncPid}
