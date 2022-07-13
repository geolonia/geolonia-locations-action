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
        uses: geolonia/vector-tiles-action@v0
        id: generate_vector_tiles
        with:
          file: ./test/data.geojson         # [Required] Data source.
          output_to_directory: ./docs/tiles # [Optional] Tiles directory. The default is `docs/tiles`.
          layer: data                       # [Optional] Layer name. The default is `data`.

      - name: test
        run: ls -la docs/tiles

      # You can host vector tiles by deploying them directly to GitHub Pages 🌏
      - name: Deploy
        uses: JamesIves/github-pages-deploy-action@v4
        with:
          branch: 'gh-pages'
          folder: ./docs
```
