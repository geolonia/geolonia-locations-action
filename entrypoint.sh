#!/bin/sh -l

set -eu

GITHUB_USERNAME=$1
INPUT=$2
OUTPUT_DIR=$3

# $1: output.mbtiles
# $1: input files (shape, geojsons)
tippecanoe -zg -o out.mbtiles --drop-densest-as-needed -l out --no-tile-compression $INPUT


mb-util --image_format=pbf ./out.mbtiles $OUTPUT_DIR
find $OUTPUT_DIR -name "*.pbf" -exec bash -c 'mv "$1" "${1%.pbf}".mvt' - '{}' \;
cp ./assets/index.html $OUTPUT_DIR

echo $1

# cat $OUTPUT_DIR/metadata.json | \
#   jq ".tiles |= [\"https://${GITHUB_USERNAME}.github.io/${GITHUB_REPOSITORY}/{z}/{x}/{y}.mvt\"]" > \
#   tiles.json
