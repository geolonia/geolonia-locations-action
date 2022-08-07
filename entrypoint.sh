#!/bin/bash

FILE=$1
OUT_DIR=$2
GEOLONIA_ACCESS_TOKEN=$3
TILES_OUT_DIR=$OUT_DIR/tiles
LAYER_NAME=data

if [[ ${FILE} == *.shp ]];
  ogr2ogr $FILE
fi



mkdir -p $TILES_OUT_DIR
rmdir $TILES_OUT_DIR

tippecanoe -zg \
  --output-to-directory $TILES_OUT_DIR \
  --layer $LAYER_NAME \
  --drop-densest-as-needed \
  --no-tile-compression \
  $FILE

find $TILES_OUT_DIR -name "*.pbf" -exec bash -c 'mv "$1" "${1%.pbf}".mvt' - '{}' \;
