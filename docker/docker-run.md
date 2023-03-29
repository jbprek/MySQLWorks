````sh
docker run -d --name mysql-simple \
-e MYSQL_ROOT_PASSWORD=my-secret \
-p 3306:3306 \
mysql:latest
````