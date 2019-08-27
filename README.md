# Docker Containers for Bridge Core

## Specification
python: 2.7  
gunicorn  
nginx  
mysql  
redis  
mongodb  

## How to use

1. Installation of dependency package

    ```
    sudo apt-get install libmysqlclient-dev
    ```

2. Build and Start Containers

    ```
    sudo docker-compose up
    ```

3. Initilize database

    ```
    sudo docker-compose exec application python manage.py migrate
    ```

4. Create django admin user

    ```
    sudo docker-compose exec -it application python manage.py createsuperuser
    ```

5. Collecting staticfiles

    ```
    sudo docker-compose run application python manage.py collectstatic --noinput
    ```

## Knowledge

```
services:
  application:
    restart: always
    build: ./bridge_core
    expose:
      - "8000"
    links:      # ここに記載したものはホストマシンのhostsへコンテナのIPとともに追加される
      - mysql   # djangoのconfig.iniにも使用可能
      - redis
      - mongodb
    command: gunicorn automated_response.wsgi -b 0.0.0.0:8000
    volumes:
      - ./bridge_core:/usr/src/app
      - ./bridge_core/static/:/usr/src/app/static
```
