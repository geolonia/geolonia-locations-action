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
    name: Generate vector tiles and deploy GitHub Pages
    steps:
      - name: checkout
        uses: actions/checkout@v3

      # Generate tiles 🚀
      - name: 'Generate vector tiles as *.mvt'
        uses: geolonia/geolonia-locations-action@v0
        with:
          file: ./test/data.geojson           # [Required] Data source
          out_dir: ./docs                     # [Optional] Parent directory where tiles are generated as `<out_dir>/tiles`
          geolonia_access_token: 0a1b2c3d4e5f # [Optional] If specified, out_dir is ignored and Geolonia Locations is used. Otherwise, out_dir is respected and deployed to GitHub Pages
```

You can get Geolonia Access Token at https://app.geolonia.com/#/team/general.

## Development

```shell
$ docker build -t geolonia/geolonia-locations-action .
# Use GitHub Pages, simply
$ docker run --rm -v $(pwd)/__test__:/__test__ -v $(pwd)/docs:/docs geolonia/geolonia-locations-action /__test__/data.geojson
# Use Geolonia SaaS
$ docker run --rm -v $(pwd)/__test__:/__test__ -v $(pwd)/docs:/docs geolonia/geolonia-locations-action /__test__/data.geojson $GEOLONIA_ACCESS_TOKEN
```
