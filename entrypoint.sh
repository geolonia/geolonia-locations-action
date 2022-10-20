#!/bin/sh
set -e

FILE=$1
EXT=${FILE##*.}
FILE_WITHOUT_EXT=${FILE%.*}
LOWER_EXT=`echo $EXT | tr '[:upper:]' '[:lower:]'`

GEOLONIA_ACCESS_TOKEN=$2
OUT_DIR=$3
LAYER_NAME=$4

BASE_URL=""
if [ $GITHUB_REPOSITORY ]; then
  GH_REPOSITORY_NAME=$(echo $GITHUB_REPOSITORY | cut -d'/' -f2)
  BASE_URL="https://'${GITHUB_REPOSITORY_OWNER}'.github.io/'${GH_REPOSITORY_NAME}'"
  else
  BASE_URL="http://localhost:8080"
fi

TILES_OUT_DIR=$OUT_DIR/tiles
METADATA_JSON=$TILES_OUT_DIR/metadata.json

mkdir -p $TILES_OUT_DIR

if [ "$LOWER_EXT" = "csv" ]; then
  echo "Converting CSV to GeoJSON..."
  csv2geojson --lat 緯度 --lon 経度 $FILE > $FILE_WITHOUT_EXT.geojson
  FILE=$FILE_WITHOUT_EXT.geojson
fi

if [ $GEOLONIA_ACCESS_TOKEN ]; then
  GEOLONIA_ACCESS_TOKEN=$GEOLONIA_ACCESS_TOKEN geolonia upload-locations $1
else

  TILE_MAXZOOM_OPTION=""

  # if geojson has one feature and geometry type is Point, set maxzoom to 14

  if [ $(cat $FILE | jq '.features | length') -eq 1 ]; then
    if [ $(cat $FILE | jq '.features[0].geometry.type') = '"Point"' ]; then
      TILE_MAXZOOM_OPTION="-z14"
      else
      TILE_MAXZOOM_OPTION="-zg"
    fi
  fi

  tippecanoe $TILE_MAXZOOM_OPTION \
    --force \
    --output-to-directory $TILES_OUT_DIR \
    --layer $LAYER_NAME \
    --drop-densest-as-needed \
    --no-tile-compression \
    $FILE

  find $TILES_OUT_DIR -name "*.pbf" -exec sh -c 'mv "$1" "${1%.pbf}".mvt' - '{}' \;

  if [ -f $METADATA_JSON ]
  then

    cat $METADATA_JSON | jq '{
      "tilejson": "3.0.0",
      name: .name,
      version: .version,
      description: .description,
      type: .type,
      format: "mvt",
      attribution: .attribution,
      minzoom: .minzoom | tonumber,
      maxzoom: .maxzoom | tonumber,
      center: .center | split(",") | map(tonumber),
      bounds: .bounds | split(",") | map(tonumber),
      "tiles": [
        "'${BASE_URL}'/tiles/{z}/{x}/{y}.mvt"
      ]
    }' > $TILES_OUT_DIR/tiles.json

  fi

fi
