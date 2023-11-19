.PHONY: build build-linux-amd64 build-linux-arm64 build-linux-armv7 build-macos-arm64 build-windows-amd64 build-macos-amd64 build-all clean clean-all push push-all

TARGETOS ?= linux
TARGETARCH ?= amd64
IMAGE_NAME ?= ghcr.io/vladagurets/go-telebot

build:
		@docker buildx build \
			--build-arg TARGETOS=$(TARGETOS) \
			--build-arg TARGETARCH=$(TARGETARCH) \
			-t $(IMAGE_NAME):$(TARGETOS)-$(TARGETARCH) \
			.

build-linux-amd64:
		@$(MAKE) build TARGETOS=linux TARGETARCH=amd64

build-linux-arm64:
		@$(MAKE) build TARGETOS=linux TARGETARCH=arm64

build-linux-armv7:
		@$(MAKE) build TARGETOS=linux TARGETARCH=armv7

build-windows-amd64:
		@$(MAKE) build TARGETOS=windows TARGETARCH=amd64

build-macos-amd64:
		@$(MAKE) build TARGETOS=darwin TARGETARCH=amd64

build-macos-arm64:
		@$(MAKE) build TARGETOS=darwin TARGETARCH=arm64

build-all:
		@$(MAKE) build-linux-amd64
		@$(MAKE) build-linux-arm64
		@$(MAKE) build-linux-armv7
		@$(MAKE) build-windows-amd64
		@$(MAKE) build-macos-amd64

push:
		@docker push $(IMAGE_NAME):$(TARGETOS)-$(TARGETARCH)

push-all:
		@$(MAKE) push TARGETOS=linux TARGETARCH=amd64
		@$(MAKE) push TARGETOS=linux TARGETARCH=arm64
		@$(MAKE) push TARGETOS=linux TARGETARCH=armv7
		@$(MAKE) push TARGETOS=windows TARGETARCH=amd64
		@$(MAKE) push TARGETOS=darwin TARGETARCH=amd64

clean:
		@docker rmi $(IMAGE_NAME):$(TARGETOS)-$(TARGETARCH) || true

clean-all:
		@$(MAKE) clean TARGETOS=linux TARGETARCH=amd64
		@$(MAKE) clean TARGETOS=linux TARGETARCH=arm64
		@$(MAKE) clean TARGETOS=linux TARGETARCH=armv7
		@$(MAKE) clean TARGETOS=windows TARGETARCH=amd64
		@$(MAKE) clean TARGETOS=darwin TARGETARCH=amd64
