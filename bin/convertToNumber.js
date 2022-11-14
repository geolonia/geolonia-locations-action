// read geojson file
const geojson = JSON.parse(fs.readFileSync('data/geojson.json', 'utf8'))

function convertToNumber(coordinates) {
  if (Array.isArray(coordinates)) {
    return coordinates.map(x => convertToNumber(x))
  } else if (typeof coordinates === 'string') {
    return parseFloat(coordinates)
  } else {
    return coordinates
  }
}

// loop through features
const features = geojson.features.map(feature => {
  feature.geometry.coordinates = convertToNumber(feature.geometry.coordinates)
  return feature
})

// create new geojson file
const newGeojson = {
  type: 'FeatureCollection',
  features: features
}

fs.writeFileSync('data/geojson.json', JSON.stringify(newGeojson))