#!/usr/bin/env node
const fs = require('fs')
const path = require('path')
const filePath = process.argv[2]
const targetFile = path.join(__dirname, '../', 'temp.geojson')

const convertToNumber = (coordinates) => {
  if (Array.isArray(coordinates)) {
    return coordinates.map(x => convertToNumber(x))
  } else if (typeof coordinates === 'string') {
    return parseFloat(coordinates)
  } else {
    return coordinates
  }
}
const formatCoordinates = (filePath) => {
  // read geojson file
  const geojson = JSON.parse(fs.readFileSync(filePath, 'utf8'))

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

  fs.writeFileSync(targetFile , JSON.stringify(newGeojson))

  process.stdout.write(targetFile);
}

// pass first argument as file path
formatCoordinates(filePath)