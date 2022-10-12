#!/bin/sh
set -e

FILE=$1
GEOLONIA_ACCESS_TOKEN=$2
OUT_DIR=$3

GH_REPOSITORY_NAME=$(echo $GITHUB_REPOSITORY | cut -d'/' -f2)
TILES_OUT_DIR=$OUT_DIR/tiles
METADATA_JSON_DIR=$TILES_OUT_DIR/metadata.json
LAYER_NAME=data

mkdir -p $TILES_OUT_DIR

if [ $GEOLONIA_ACCESS_TOKEN ]; then
  GEOLONIA_ACCESS_TOKEN=$GEOLONIA_ACCESS_TOKEN geolonia locations upload $1
else
  tippecanoe -zg \
    --force \
    --output-to-directory $TILES_OUT_DIR \
    --layer $LAYER_NAME \
    --drop-densest-as-needed \
    --no-tile-compression \
    $FILE

  find $TILES_OUT_DIR -name "*.pbf" -exec sh -c 'mv "$1" "${1%.pbf}".mvt' - '{}' \;

  if [ -f $METADATA_JSON_DIR ]
  then
  
    cat $METADATA_JSON_DIR | jq '{
      name: .name,
      version: .version,
      description: .description,
      type: .type,
      format: .format,
      attribution: .attribution,
      minzoom: .minzoom,
      maxzoom: .maxzoom,
      center: .center,
      bounds: .bounds,
      "tiles": [
        "https://'${GITHUB_REPOSITORY_OWNER}'.github.io/'${GH_REPOSITORY_NAME}'/tiles/{z}/{x}/{y}.mvt"
      ]
    }' > $TILES_OUT_DIR/tiles.json

  fi

fi
