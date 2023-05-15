# June1 Mosz (jm) One Page Project Docker
## OS base use baseimage:0.11 (Ubuntu 18.04.5 LTS)

## Build docker images and service

### Start docker container
~~~
docker-compose up -d nginx php73
~~~

### Show docker process
~~~
docker-compose ps
~~~

### Stop docker container
~~~
docker-compose down 
~~~

### Running in container
~~~
docker exec -it php73 bash
~~~