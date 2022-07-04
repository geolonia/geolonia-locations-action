#!/bin/sh -l

set -eu

INPUT=$1
OUTPUT_DIR=$2
BASE_URL="https://kamataryo.github.io/vector-tile-action"

tippecanoe -zg -o out.mbtiles --drop-densest-as-needed -l out --no-tile-compression $INPUT

mb-util --image_format=pbf ./out.mbtiles $OUTPUT_DIR
find $OUTPUT_DIR -name "*.pbf" -exec bash -c 'mv "$1" "${1%.pbf}".mvt' - '{}' \;
cp ./assets/index.html $OUTPUT_DIR

cat $OUTPUT_DIR/metadata.json | \
  jq ".tiles |= [\"${BASE_URL}/{z}/{x}/{y}.mvt\"]" > \
  tiles.json
