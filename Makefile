SYSTEM_TARGET := ubuntu-20.04

DOCKER_TARGET = install
DOCKER_IMAGE = benjcunningham/dotfiles/$(SYSTEM_TARGET)
DOCKER_TAG = latest
DOCKERFILE_PATH = docker/$(SYSTEM_TARGET)/Dockerfile

.PHONY: docker/build
docker/build:
	docker build \
		-f $(DOCKERFILE_PATH) \
		--target $(DOCKER_TARGET) \
		-t ${DOCKER_IMAGE}:${DOCKER_TAG} \
		.

.PHONY: test/ci/lint
test/ci/lint: DOCKER_TARGET = test
test/ci/lint: DOCKER_TAG = test
test/ci/lint: docker/build
	docker run \
		-t \
		--rm \
		${DOCKER_IMAGE}:${DOCKER_TAG} \
		bash ./test.sh

.PHONY: test/ci/install
test/ci/install: DOCKER_TARGET = install
test/ci/install: docker/build
	docker run \
		-t \
		--rm \
		${DOCKER_IMAGE}:${DOCKER_TAG} \
		bash ./install.sh
