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

      ## Prepare vector data. For example, Shape, GeoJSON, GeoJSON in ndjson format, etc.
      - name: Download Natural Earth data for test
         run: |
           curl -sL https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_0_countries.zip > ne_10m_admin_0_countries.zip
           unzip ne_10m_admin_0_countries.zip

      # Generate tiles 🚀
      - name: Generate vector tiles step
        uses: ./
        id: generate_vector_tiles
        with:
          sources: ./ne_10m_admin_0_countries.shp

      - name: test
        run: ls -la tiles

      # You can host vector tiles by deploying them directly to GitHub Pages.
      - name: Deploy
        uses: JamesIves/github-pages-deploy-action@v4
        with:
          branch: 'gh-pages'
          folder: ./tiles
```

## Configurations

|key|description|type|required|default|
|`sources`|Path to your vector data. |