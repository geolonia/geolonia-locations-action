const fs = require('fs');
const path = require('path');
const tilesJson = fs.readFileSync(path.join(__dirname, '../', 'docs/tiles/tiles.json'))

test('is tiles.json exist', () => {
  expect(tilesJson).not.toBe(null);
  expect(tilesJson).not.toBe(undefined);
  expect(tilesJson).not.toBe('');
})

test('is tile url valid', () => {
  const tiles = JSON.parse(tilesJson);
  expect(tiles.tiles[0]).toBe('https://geolonia.github.io/geolonia-locations-action/tiles/tiles.json');
})
