# Build
FROM golang:1.18-alpine AS build-env
WORKDIR /app
COPY ./go ./
RUN go mod download
RUN CGO_ENABLED=0 go build -ldflags="-extldflags=-static" -o app .

# Target
FROM scratch
WORKDIR /app
COPY --from=build-env /app/app .
ENTRYPOINT ["./app"]