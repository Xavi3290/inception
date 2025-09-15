COMPOSE := docker compose -f srcs/docker-compose.yml

.PHONY: all build up down ps logs fclean re restart prepare nginx-test

all: build up

build:
	$(COMPOSE) build

up:	prepare
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

ps:
	$(COMPOSE) ps

logs:
	$(COMPOSE) logs -f

fclean:
	$(COMPOSE) down -v

re:
	$(COMPOSE) build --no-cache
	$(COMPOSE) up -d

restart:
	$(COMPOSE) restart

prepare:
	mkdir -p /home/xroca-pe/data/mariadb \
	         /home/xroca-pe/data/wordpress \
	         /home/xroca-pe/data/redis \
	         /home/xroca-pe/data/backups \
                 /home/xroca-pe/data/ftp \
		 /home/xroca-pe/data/nginx/certs \
	         /home/xroca-pe/data/nginx/private

nginx-test:
	docker exec -it $$(docker ps -q -f name=nginx) nginx -t

backup-run:
	docker exec -it $$(docker ps -q -f name=backup) /usr/local/bin/backup.sh

backup-list:
	ls -lh /home/xroca-pe/data/backups/sql
	ls -lh /home/xroca-pe/data/backups/files
