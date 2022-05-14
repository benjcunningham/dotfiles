SYSTEM_TARGET := ubuntu-20.04

DOCKER_TARGET = install
DOCKER_IMAGE = benjcunningham/dotfiles/$(SYSTEM_TARGET)
DOCKER_TAG = latest
DOCKERFILE_PATH = docker/$(SYSTEM_TARGET)/Dockerfile

.PHONY: build
build:
	docker build \
		-f $(DOCKERFILE_PATH) \
		--target $(DOCKER_TARGET) \
		-t ${DOCKER_IMAGE}:${DOCKER_TAG} \
		.

.PHONY: test/lint
test/lint: DOCKER_TARGET = test
test/lint: DOCKER_TAG = test
test/lint: build
	docker run \
		-t \
		--rm \
		${DOCKER_IMAGE}:${DOCKER_TAG} \
		bash ./test.sh

.PHONY: test/install
test/install: build
	docker run \
		-t \
		--rm \
		-e DOTFILES_LOCAL=1 \
		-e DEBIAN_FRONTEND=noninteractive \
		${DOCKER_IMAGE}:${DOCKER_TAG} \
		bash ./install.sh
