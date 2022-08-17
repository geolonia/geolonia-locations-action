#!/bin/sh
set -e

FILE=$1
OUT_DIR=$2
GEOLONIA_ACCESS_TOKEN=$3

TILES_OUT_DIR=$OUT_DIR/tiles
LAYER_NAME=data

mkdir -p $TILES_OUT_DIR

if [ $GEOLONIA_ACCESS_TOKEN ]; then
  echo 'geolonia locations upload "@$1"'
else
  tippecanoe -zg \
    --force \
    --output-to-directory $TILES_OUT_DIR \
    --layer $LAYER_NAME \
    --drop-densest-as-needed \
    --no-tile-compression \
    $FILE

  find $TILES_OUT_DIR -name "*.pbf" -exec sh -c 'mv "$1" "${1%.pbf}".mvt' - '{}' \;
fi
