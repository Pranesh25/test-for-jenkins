#! /bin/bash
node server.js
mkdir /root/.aws
touch /root/.aws/config
mv  /test-for-jenkins/credentils   /root/.aws/
