
IMAGE_NAME := dist.spotahome.net:5000/spotahome/brigade-git-sidecar
VERSION = $(shell git describe --tags --always 2>/dev/null)

default: build-image

.PHONY: build-image
build-image:
	docker build \
	--tag ${IMAGE_NAME}:${VERSION} .