# Vector tile action

A GitHub Action to generate vector tiles.

## sample

```yaml
- name: Generate vector tile step
  uses: ./
  with:
    input_files: ./assets/test.geojsons
    output_dir: ./tiles
    source_layer_name: test

# Optional. You can host tiles with GitHub Pages easily.
- name: Deploy
  uses: JamesIves/github-pages-deploy-action@v4
  with:
    branch: 'gh-pages'
    folder: ./tiles
```
