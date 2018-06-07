#!/usr/bin/make -f

NAME=jamesbrink/wine
TEMPLATE=Dockerfile.template
DOCKER_COMPOSE_TEMPLATE=docker-compose.template
.PHONY: test all clean latest
.DEFAULT_GOAL := latest

all: latest

latest:
	mkdir -p $(@)
	cp -rp docker-assets $(@)
	cp -rp hooks $(@)
	cp Dockerfile.template $(@)/Dockerfile
	cp .dockerignore $(@)/.dockerignore
	sed -i -r 's/ARG TEMPLATE_VERSION.*/ARG TEMPLATE_VERSION="3.0"/g' $(@)/Dockerfile
	cd $(@) && TEMPLATE_VERSION="0.1.0" IMAGE_NAME=$(NAME):$(@) ./hooks/build


test: test-latest

test-latest:
	if [ "`docker run jamesbrink/wine cat /etc/debian_version`" != "buster/sid" ]; then exit 1;fi
	if [ "`docker run jamesbrink/wine cat /wine/version.txt`" != "3.0" ]; then exit 1;fi

clean:
	rm -rf latest
