# Makefile for managing Docker Compose commands

# Define the Docker Compose files
DEV_COMPOSE_FILE := docker-compose-dev.yml
PROD_COMPOSE_FILE := docker-compose-prod.yml

# Target to start the development application with optional .env and .env.local loading
up:
	@if [ -f .env ]; then \
		echo "Loading environment variables from .env"; \
		if [ -f .env.local ]; then \
			echo "Loading environment variables from .env.local"; \
			docker compose --env-file .env --env-file .env.local -f $(DEV_COMPOSE_FILE) up; \
		else \
			docker compose --env-file .env -f $(DEV_COMPOSE_FILE) up; \
		fi; \
	else \
		if [ -f .env.local ]; then \
			echo "Loading environment variables from .env.local"; \
			docker compose --env-file .env.local -f $(DEV_COMPOSE_FILE) up; \
		else \
			echo "No environment files found. Starting without them."; \
			docker compose -f $(DEV_COMPOSE_FILE) up; \
		fi; \
	fi

# Target to start the production application with optional .env and env.local loading
prod:
	@if [ -f .env ]; then \
		echo "Loading environment variables from .env"; \
		if [ -f .env.local ]; then \
			echo "Loading environment variables from .env.local"; \
			docker compose --env-file .env --env-file .env.local -f $(PROD_COMPOSE_FILE) up; \
		else \
			docker compose --env-file .env -f $(PROD_COMPOSE_FILE) up; \
		fi; \
	else \
		if [ -f .env.local ]; then \
			echo "Loading environment variables from .env.local"; \
			docker compose --env-file .env.local -f $(PROD_COMPOSE_FILE) up; \
		else \
			echo "No environment files found. Starting without them."; \
			docker compose -f $(PROD_COMPOSE_FILE) up; \
		fi; \
	fi