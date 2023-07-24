export IP=$(hostname -I)
curl -X POST -d "{\"ip\": \"$IP\"}" 75.119.144.234:9999/node/make
