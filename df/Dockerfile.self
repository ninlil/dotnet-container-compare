#  Builder
FROM mcr.microsoft.com/dotnet/sdk:6.0 as build-env
WORKDIR /app
COPY ./src ./
RUN dotnet publish            \
    -c Release                \
    --self-contained          \
    --runtime linux-x64       \
    -o out

# Target
FROM mcr.microsoft.com/dotnet/runtime-deps:6.0
WORKDIR /app
COPY --from=build-env /app/out .
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 \
    DOTNET_RUNNING_IN_CONTAINER=true
ENTRYPOINT ["./my-app"]