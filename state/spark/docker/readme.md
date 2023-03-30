docker run --name spark-shell -it apache/spark /opt/spark/bin/spark-shell
# docker cp input.csv <container_id>:/app/
docker cp echo.txt spark-shell:/opt/spark/work-dir/

docker exec -it  spark-shell  sh


docker cp data.csv spark-shell:/opt/spark/work-dir/