#!/bin/sh
cd ${WORKSPACE}/src
docker build -t 192.168.100.215:5002/weblogic/python-redis-demo:b${BUILD_NUMBER} .
docker push 192.168.100.215:5002/weblogic/python-redis-demo:b${BUILD_NUMBER}
cd ${WORKSPACE}/test-build
sed -i 's/\$\$BUILD_NUMBER\$\$/'${BUILD_NUMBER}'/g' docker-compose.yml
sed -i 's/\$\$PORT_NUMBER\$\$/'`expr 5000 + ${BUILD_NUMBER}`'/g' docker-compose.yml
chmod 777 ./rancher-compose
./rancher-compose --url http://192.168.100.170:8080 --access-key D46EBB1236FD1C4428D0 --secret-key ZEkEdYwj1V5EXmBzpHAZuPBtzYTdQKAAxtF3XjUK -p python-redis-demo-build${BUILD_NUMBER} up -d
#./rancher-compose --url http://10.0.0.5:8080 --access-key CA23527D9BE1E5855619 --secret-key GF6Q1vMsimqY8MHp6t17eqoZXcbQ8VEBcjU11z7H -p python-redis-demo-build27 up --pull -d --upgrade pyapp
# --confirm-upgrade
