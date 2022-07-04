#!/bin/bash

set -eu

INPUT=$1
OUTPUT_DIR=$2
SOURCE_LAYER_NAME=$3
BASE_URL="https://kamataryo.github.io/vector-tile-action"

tippecanoe -zg \
  -o ${SOURCE_LAYER_NAME}.mbtiles \
  --drop-densest-as-needed \
  -l $SOURCE_LAYER_NAME \
  --no-tile-compression \
  $INPUT

mb-util --image_format=pbf ./${SOURCE_LAYER_NAME}.mbtiles $OUTPUT_DIR
find $OUTPUT_DIR -name "*.pbf" -exec bash -c 'mv "$1" "${1%.pbf}".mvt' - '{}' \;

cat ./assets/index.html |  sed -e "s/%%source_layer_name%%/${SOURCE_LAYER_NAME}/g" > $OUTPUT_DIR/index.html
cat $OUTPUT_DIR/metadata.json | \
  jq ".tiles |= [\"${BASE_URL}/{z}/{x}/{y}.mvt\"]" > \
  $OUTPUT_DIR/tiles.json
