PHP = docker compose exec php

up:
	docker compose up -d

down:
	docker compose down

build:
	docker compose up -d --build

init:
	docker compose up -d --build
	$(PHP) composer install
	$(PHP) php artisan key:generate
	$(PHP) php artisan migrate
	$(PHP) php artisan db:seed

clear:
	docker compose down -v --rmi all

reset:
	docker compose down -v --rmi all
	docker compose up -d --build

php:
	$(PHP) bash

artisan:
	$(PHP) php artisan $(filter-out $@,$(MAKECMDGOALS))

composer:
	$(PHP) composer $(filter-out $@,$(MAKECMDGOALS))

test:
	$(PHP) ./vendor/bin/pest --parallel

test-coverage:
	$(PHP) ./vendor/bin/pest --parallel --coverage

lint:
	$(PHP) ./vendor/bin/pint

analyse:
	$(PHP) ./vendor/bin/phpstan analyse --memory-limit=512M

check:
	$(PHP) ./vendor/bin/pint --test
	$(PHP) ./vendor/bin/phpstan analyse --memory-limit=512M

migrate-fresh:
	$(PHP) php artisan migrate:fresh --seed

logs:
	docker compose logs -f

logs-php:
	docker compose logs -f php

restart:
	docker compose restart

%:
	@:
