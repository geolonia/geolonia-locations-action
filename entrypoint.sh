#!/bin/bash

set -eu

FILE=$1
NO_TILE_COMPRESSION=$2
$OUTPUT=$3
OUTPUT_TO_DIRECTORY=$4
TIPPEACANOE_OPTIONS=$5

echo $1
echo $2
echo $3
echo $4
echo $5


if [ $TIPPEACANOE_OPTIONS != "" ];
  tippecanoe $FILE
fi

NO_TILE_COMPRESSION_OPTION=""
if [ $NO_TILE_COMPRESSION == 'true' ];
  NO_TILE_COMPRESSION_OPTION="-no-tile-compression"
fi

mkdir -p $OUTPUT_TO_DIRECTORY
rmdir $OUTPUT_TO_DIRECTORY

tippecanoe -zg \
  -output $OUTPUT_TO_DIRECTORY \
  --drop-densest-as-needed \
  --layer $LAYER \
  ${NO_TILE_COMPRESSION_OPTION} \
  $FILE

find $OUTPUT_TO_DIRECTORY -name "*.pbf" -exec bash -c 'mv "$1" "${1%.pbf}".mvt' - '{}' \;
