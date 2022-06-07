TARGETS=$(shell ls df/Dockerfile.* | sed "s|.*/Dockerfile\.||")
COPY=$(foreach X,$(TARGETS),copy/$(X))
TAG=$(shell cat tag.txt)

.SILENT: help
help:
	echo "Targets: $(TARGETS)"

clean:
	-rm Dockerfile tag.txt
	-rm -rf src/bin src/obj
	docker images my-app | grep my-app | awk '{print $$1 ":" $$2}' | xargs -r docker rmi

$(COPY):
	@echo $(notdir $@) >tag.txt
	cp df/Dockerfile.$(notdir $@) Dockerfile

run-local:
	dotnet run --project ./src

docker:
	docker build -t my-app:$(TAG) .

images:
	docker images my-app
#	docker images my-app --format 'table {{.Repository}}\t{{.Tag}}\t{{.Size}}'

run:
	docker run --rm my-app:$(TAG)