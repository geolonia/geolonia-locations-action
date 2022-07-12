# Vector tiles action

[![.github/workflows/test.yml](https://github.com/geolonia/vector-tiles-action/actions/workflows/test.yml/badge.svg)](https://github.com/geolonia/vector-tiles-action/actions/workflows/test.yml)

A GitHub Action to generate vector tiles.

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
        uses: geolonia/vector-tiles-action@v1
        id: generate_vector_tiles
        with:
          file: ./test/data.geojson         # data souce
          output_to_directory: ./docs/tiles # [optional] tiles directory. default is `docs/tiles`.
          layer: data                       # [optional] layer name. default is `data`.

      - name: test
        run: ls -la docs/tiles

      # You can host vector tiles by deploying them directly to GitHub Pages.
      - name: Deploy
        uses: JamesIves/github-pages-deploy-action@v4
        with:
          branch: 'gh-pages'
          folder: ./docs
```
