builddir = builddir
container_tag = gnome-latam-workshop
# Using $(shell pwd) because $(PWD) is failing inside docker :/
prefix = $(shell pwd)/prefix

.PHONY: all configure compile install test

all: compile

test: compile

install: configure
	cd "$(builddir)" && meson install

compile: configure
	cd "$(builddir)" && meson compile

configure: $(builddir)/build.ninja
$(builddir)/build.ninja:
	rm -fr "$(builddir)"
	meson setup \
		--prefix "$(prefix)" \
		"$(builddir)"

container_install:
container_compile:
container_%: .container_built
	docker run \
		--rm \
		--user $(shell id -u):$(shell id -g) \
		--volume "$(PWD)":"/tmp/ws" \
		--workdir "/tmp/ws" \
		$(container_tag) \
		make $*

container_bash: .container_built
	docker run \
		--rm \
		-it \
		--user $(shell id -u):$(shell id -g) \
		--volume "$(PWD)":"/tmp/ws" \
		--workdir "/tmp/ws" \
		$(container_tag) \
		bash

.container_built: Dockerfile
	docker build ./ --tag "$(container_tag)" && touch "$@"

clean:
	-rm -fr "$(builddir)"
	-rm .container_built
	-rm -fr "$(prefix)"

mrproper: clean
	-docker image rm "$(container_tag)"
