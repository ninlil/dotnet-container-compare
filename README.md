# dotnet-container-compare

Short examples of different Dockerfiles and compare methods and images-sizes

| Target  | Description                                   |
| ------- | --------------------------------------------- |
| 1       | Run from sourcecode                           |
| 2       | Compile first                                 |
| 3       | 2-stage build                                 |
| self    | Self-contained app                            |
| trim    | Trimmed and self-contained app                |
| alpine  | Trimmed and self-contained app, target alpine |
| special | Specialized build (for comparison)            |
| go      | Static compile of Go example                  |

## Command-usage
```sh
# Select a specific target
make 1
```

```sh
# Build using the selected target
make docker
```

```sh
# Run the current image
make run
```

```sh
# List images and compare sizes
make images
```

```sh
# clean
make clean
```