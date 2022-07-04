#!/bin/bash

set -eu

INPUT=$1
OUT_DIR=$2
SOURCE_LAYER_NAME=$3
BASE_URL="https://kamataryo.github.io/vector-tiles-action"

tippecanoe -zg \
  -o ${SOURCE_LAYER_NAME}.mbtiles \
  --drop-densest-as-needed \
  -l $SOURCE_LAYER_NAME \
  --no-tile-compression \
  $INPUT

mkdir -p $OUT_DIR
rmdir $OUT_DIR
mb-util --image_format=pbf ./${SOURCE_LAYER_NAME}.mbtiles $OUT_DIR
find $OUT_DIR -name "*.pbf" -exec bash -c 'mv "$1" "${1%.pbf}".mvt' - '{}' \;

cat ./assets/index.html |  sed -e "s/%%layer_name%%/${SOURCE_LAYER_NAME}/g" > $OUT_DIR/index.html
cat $OUT_DIR/metadata.json | \
  jq ".tiles |= [\"${BASE_URL}/{z}/{x}/{y}.mvt\"]" > \
  $OUT_DIR/tiles.json
