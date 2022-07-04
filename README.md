# Vector tile action

A GitHub Action to generate vector tiles.

## sample

```yaml
- name: Generate vector tiles step
  uses: geolonia/generate-vector-tiles@v0
  with:
    sources: path/to/sources # shape, geojson, ndjgeojson and etc.

# You can host tiles with GitHub Pages easily.
- name: Deploy
  uses: JamesIves/github-pages-deploy-action@v4
  with:
    branch: 'gh-pages'
    folder: ./tiles
```
