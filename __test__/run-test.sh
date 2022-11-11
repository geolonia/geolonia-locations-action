docker build -t geolonia/geolonia-locations-action .
docker run --rm -v $(pwd)/__test__:/__test__ -v $(pwd)/docs:/docs geolonia/geolonia-locations-action /__test__/data-string.geojson "" ./docs g-simplestyle-v1
