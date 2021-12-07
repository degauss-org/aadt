# aadt <a href='https://degauss.org'><img src='https://github.com/degauss-org/degauss_template/raw/master/DeGAUSS_hex.png' align='right' height='138.5' /></a>

> get average annual daily traffic (AADT) within a buffer radius of geocoded address

[![Docker Build Status](https://img.shields.io/docker/automated/degauss/aadt)](https://hub.docker.com/repository/docker/degauss/aadt/tags)
[![GitHub Latest Tag](https://img.shields.io/github/v/tag/degauss-org/aadt)](https://github.com/degauss-org/aadt/releases)

## DeGAUSS example call

If `my_address_file_geocoded.csv` is a file in the current working directory with coordinate columns named `lat` and `lon`, then

```sh
docker run --rm -v $PWD:/tmp /degauss/aadt:0.1.1 my_address_file_geocoded.csv
```

will produce `my_address_file_geocoded_aadt_v0.1.1_400m_buffer.csv` with an added columns `length_moving`,`length_stop_go`, `vehicle_meters_moving`, `vehicle_meters_stop_go`, `truck_meters_moving`, and `truck_meters_stop_go` which describe the AADT within a 400 m radius. To change the buffer radius, supply it (in meters) as an argument in your docker call: 

```sh
docker run --rm -v $PWD:/tmp /degauss/aadt:0.1.1 my_address_file_geocoded.csv 500
```

## geomarker methods

For more information, including AADT variable definitions, please reference our [`addAadt`](https://github.com/geomarker-io/addAadtData) R package repository.

## geomarker data

- AADT data was obtained from the U.S. Department of Transportation Federal Highway Administration. For more information, see [aadt_shp_to_qs](https://github.com/geomarker-io/aadt_shp_to_qs).
- AADT data is stored by state at [`s3://geomarker/aadt/aadt_by_state`](https://geomarker.s3.us-east-2.amazonaws.com/geomarker/aadt/aadt_by_state), but is also included in the Docker image.

## DeGAUSS details

For detailed documentation on DeGAUSS, including general usage and installation, please see the [DeGAUSS homepage](https://degauss.org).
