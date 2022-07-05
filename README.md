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
      - name: Generate vector tiles step
        uses: ./
        id: generate_vector_tiles
        with:
          file: path to your geometries

      - name: test
        run: ls -la tiles

      # You can host vector tiles by deploying them directly to GitHub Pages.
      - name: Deploy
        uses: JamesIves/github-pages-deploy-action@v4
        with:
          branch: 'gh-pages'
          folder: ./tiles
```
