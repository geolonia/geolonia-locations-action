// read ./docs/tiles/tiles.json file

const fs = require('fs');
const path = require('path');
const tilesjson = require('../docs/tiles/tiles.json');

test('tilesjson', () => {
  expect(tilesjson).not.toBe(null);
  expect(tilesjson).not.toBe(undefined);
  expect(tilesjson).not.toBe('');
})