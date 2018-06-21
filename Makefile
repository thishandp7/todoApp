#project variables
PROJECT_NAME ?= todobackend
ORG_NAME ?= thishandp7
REPO_NAME ?= todoApp

#file names with path
DEV_COMPOSE_FILE := docker/dev/docker-compose.yml
REL_COMPOSE_FILE := docker/release/docker-compose.yml

#docker compose project names
DEV_PROJECT := $(PROJECT_NAME)$(BUILD_ID)
REL_PROJECT := $(PROJECT_NAME)dev

.PHONY: test build release clean

test:
	${INFO} "Creating cache volume..."
	@ docker volume create --name=cache
	${INFO} "Building dev images..."
	@ docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) build --no-cache
	${INFO} "Ensuring database is ready..."
	@ docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) up agent
	${INFO} "Running tests..."
	@ docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) up dev
	${INFO} "Tests complete"

build:
	${INFO} "Building application artifacts..."
	@ docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) up builder
	${INFO} "Build complete"

release:
	${INFO} "Builing release images..."
	@ docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) build --no-cache
	${INFO} "Ensuring database is ready..."
	@ docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) up agent
	${INFO} "Collecting static files..."
	@ docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) run --rm app manage.py collectstatic --noinput
	${INFO} "Running database migrations..."
	@ docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) run --rm app manage.py migrate --noinput
	${INFO} "Running acceptance tests..."
	@ docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) up tests
	${INFO} "Acceptance testing complete"

clean:
	${INFO} "Destroying development environment...."
	@ docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) kill
	@ docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) rm -f -v
	${INFO} "Destroying release environment...."
	@ docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) kill
	@ docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) rm -f -v
	${INFO} "Removeing dangling images and volumes...."
	@ docker images -q -f dangling=true label=application$(REPO_NAME) | xargs -I ARGS docker rmi ARGS
	${INFO} "Clean up complete"

#colors
LIGHT_YELLOW := "\e[93m"
NO_COLOR := "\e[0m"

#Shell Functions
INFO := @bash -c '\
  printf $(LIGHT_YELLOW); \
	echo "=> $$1"; \
	printf $(NO_COLOR)' VALUE
