# Geolonia Locations Action

[![.github/workflows/test.yml](https://github.com/geolonia/geolonia-locations-action/actions/workflows/test.yml/badge.svg)](https://github.com/geolonia/geolonia-locations-action/actions/workflows/test.yml)

A GitHub action for Geolonia Locations.

## Getting started

```yaml
name: Build and Deploy
on: [push]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    name: Generate vectior tiles and deploy GitHub Pages
    steps:
      - name: checkout
        uses: actions/checkout@v3

      # Generate tiles 🚀
      - name: 'Generate vector tiles as *.mvt'
        uses: geolonia/geolonia-locations-action@v0
        with:
          file: ./test/data.shp # [Required] Data source.
          out_dir: ./docs
```

## Development

```shell
$ docker build -t geolonia/geolonia-locations-action .
$ docker run --rm -v $(pwd)/test:/test -v $(pwd)/docs:/docs geolonia/geolonia-locations-action /test/data.geojson /docs
```