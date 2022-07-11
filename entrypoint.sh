#!/bin/bash

set -eu

FILE=$1
OUTPUT_TO_DIRECTORY=$2
TIPPEACANOE_OPTIONS=$3

if [ "$TIPPEACANOE_OPTIONS" == "" ]; then
  mkdir -p $OUTPUT_TO_DIRECTORY
  rmdir $OUTPUT_TO_DIRECTORY

  tippecanoe -zg \
    -output $OUTPUT_TO_DIRECTORY \
    --drop-densest-as-needed \
    --no-tile-compression \
    $FILE

  find $OUTPUT_TO_DIRECTORY -name "*.pbf" -exec bash -c 'mv "$1" "${1%.pbf}".mvt' - '{}' \;
else
  tippecanoe $TIPPEACANOE_OPTIONS
fi
