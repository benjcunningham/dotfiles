SYSTEM_TARGET =

DOCKER_TARGET = install
DOCKER_IMAGE = benjcunningham/$(SYSTEM_TARGET)
DOCKER_TAG = latest
DOCKERFILE_PATH = docker/$(SYSTEM_TARGET)/Dockerfile

INSTALL_OPTS =

.PHONY: all
all: lint
	$(MAKE) docker/build SYSTEM_TARGET=ubuntu-20.04

.PHONY: lint
lint: SYSTEM_TARGET = ubuntu-20.04
lint: DOCKER_TARGET = test
lint: DOCKER_TAG = test
lint: docker/build
	docker run \
		-t \
		--rm \
		${DOCKER_IMAGE}:${DOCKER_TAG} \
		bash scripts/test.sh

.PHONY: docker/build
docker/build:
	docker build \
		-f $(DOCKERFILE_PATH) \
		--target $(DOCKER_TARGET) \
		-t ${DOCKER_IMAGE}:${DOCKER_TAG} \
		.
