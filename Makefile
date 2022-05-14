DOCKER_BASE := ubuntu:latest
DOCKER_IMAGE := dotfiles
DOCKER_TAG := latest
DOCKER_TARGET := install

.PHONY: docker/build
docker/build:
	docker build \
		--build-arg DOCKER_BASE=$(DOCKER_BASE) \
		--target $(DOCKER_TARGET) \
		-t ${DOCKER_IMAGE}:${DOCKER_TAG} \
		.

.PHONY: test/ci/lint
test/ci/lint:
	$(MAKE) docker/build DOCKER_TARGET=test
	docker run \
		-t \
		--rm \
		${DOCKER_IMAGE}:${DOCKER_TAG} \
		bash ./test.sh

.PHONY: test/ci/install
test/ci/install:
	$(MAKE) docker/build DOCKER_TARGET=install
	docker run \
		-t \
		--rm \
		${DOCKER_IMAGE}:${DOCKER_TAG} \
		bash ./install.sh
