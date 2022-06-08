TARGETS=$(shell ls df/Dockerfile.* | sed "s|.*/Dockerfile\.||")
TAG=$(shell cat tag.txt)
.PHONY: $(TARGETS)

.SILENT: help
help:
	echo "Targets: $(TARGETS)"

clean:
	-rm Dockerfile tag.txt 2>/dev/null
	-rm -rf src/bin src/obj 2>/dev/null
	@bin/do docker images my-app | grep my-app | awk '{print $$1 ":" $$2}' | xargs -r docker rmi

all:
	echo -n $(TARGETS) | xargs -d' ' -I{} make {} docker
	make images

$(TARGETS):
	@echo $(notdir $@) >tag.txt
	@-rm Dockerfile 2>/dev/null
	@bin/do ln -s df/Dockerfile.$(notdir $@) Dockerfile

run-local:
	@bin/do dotnet run --project ./src

docker:
	@bin/do docker build -t my-app:$(TAG) .

images:
	@bin/do docker images my-app

run:
	@bin/do docker run --rm my-app:$(TAG)