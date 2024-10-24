DOCKER_REPO := yaishenka/
TARGET := docker-codestyle-checker
DOCKER_TAG := $(shell date +%Y%m%d)
DOCKER_LOGIN := login
DOCKER_TOKEN := token

all: push

login:
	docker login -u ${DOCKER_LOGIN} -p ${DOCKER_TOKEN}

build:
	docker build \
		--build-arg DOCKER_TAG=${DOCKER_TAG} \
		-t ${DOCKER_REPO}${TARGET}:${DOCKER_TAG} \
		-t ${DOCKER_REPO}${TARGET}:latest \
		--network host \
		.

push: build
	docker push ${DOCKER_REPO}${TARGET}:${DOCKER_TAG}
	docker push ${DOCKER_REPO}${TARGET}:latest
