#!/bin/bash

set -eu

FILE=$1
OUTPUT_TO_DIRECTORY=$2
LAYER=$3
TIPPEACANOE_OPTIONS=$4

if [ "$TIPPEACANOE_OPTIONS" == "" ]; then
  mkdir -p $OUTPUT_TO_DIRECTORY
  rmdir $OUTPUT_TO_DIRECTORY

  tippecanoe -zg \
    --output-to-directory $OUTPUT_TO_DIRECTORY \
    --layer $LAYER \
    --drop-densest-as-needed \
    --no-tile-compression \
    $FILE

  find $OUTPUT_TO_DIRECTORY -name "*.pbf" -exec bash -c 'mv "$1" "${1%.pbf}".mvt' - '{}' \;
else
  tippecanoe $TIPPEACANOE_OPTIONS
fi
