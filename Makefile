PROJECT_DIR 			:=  $(shell pwd)
BASE_IMAGE_VERSION		=0.0.11.RELEASE
BASE_IMAGE_NAME			=registry.dafengstudio.cn/vnc-chrome-remote:${BASE_IMAGE_VERSION}
DOCKER_CONTAINER_NAME	=chrome-remote

help:
	@echo "USAGE:\t"
	@awk -F ':|##' '/^[^\t].+?:.*?##/ {printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF}' Makefile

.DEFAULT_GOAL=help
.PHONY=help

build-image: ## build docker image --no-cache
	docker build  . -t ${BASE_IMAGE_NAME}

build-image-no-cache: ## build docker image --no-cache
	docker build --no-cache . -t ${BASE_IMAGE_NAME}

test-run: ## run local test
	docker stop ${DOCKER_CONTAINER_NAME}|true
	docker rm -f ${DOCKER_CONTAINER_NAME}|true
	docker run \
		-p 6900:5900 \
		-p 9222:9223 \
		-p 9224:2121 \
		--cpus=".8" \
		--memory="512g" \
		-e EXPOSE_PORT=9222 \
		-v ${PROJECT_DIR}/user-profile:/home/chrome/userData \
			-v ${PROJECT_DIR}/downloads:/home/chrome/Downloads  \
		--name ${DOCKER_CONTAINER_NAME} ${BASE_IMAGE_NAME}

shell: ## shell
	docker exec -it ${DOCKER_CONTAINER_NAME} /bin/bash

docker-push: ## publish docker image
	docker push ${BASE_IMAGE_NAME}

docker-clean: ## docker clean
	docker images|grep vnc-chrome-remote|grep -v ${BASE_IMAGE_VERSION}|awk '{print $$3}'|xargs docker rmi -f