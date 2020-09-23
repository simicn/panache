build-web:
	flutter build web

build-image:
	docker build --no-cache --rm=true -f Dockerfile -t panache:latest .

run-web: build-web build-image
	docker-compose up -d --force-recreate
