# aadt <a href='https://degauss.org'><img src='https://github.com/degauss-org/degauss_hex_logo/raw/main/PNG/degauss_hex.png' align='right' height='138.5' /></a>

[![](https://img.shields.io/github/v/release/degauss-org/aadt?color=469FC2&label=version&sort=semver)](https://github.com/degauss-org/aadt/releases)
[![container build status](https://github.com/degauss-org/aadt/workflows/build-deploy-release/badge.svg)](https://github.com/degauss-org/aadt/actions/workflows/build-deploy-release.yaml)

## Using

If `my_address_file_geocoded.csv` is a file in the current working directory with coordinate columns named `lat` and `lon`, then the [DeGAUSS command](https://degauss.org/using_degauss.html#DeGAUSS_Commands):

```sh
docker run --rm -v $PWD:/tmp ghcr.io/degauss-org/aadt:0.2.2 my_address_file_geocoded.csv
```

will produce `my_address_file_geocoded_aadt_0.2.2_400m_buffer.csv` with added columns describing the average annual daily traffic within a 400 meter buffer radius of each point:

- **`length_moving`**: total length of interstates, expressways, and freeways (meters)
- **`length_stop_go`**: total length of arterial roads (meters)
- **`vehicle_meters_moving`**: average daily number of vehicles multiplied by the length of interstates, expressways, and freeways (vehicle-meters)
- **`vehicle_meters_stop_go`**: average daily number of vehicles multiplied by the length of arterial roads (vehicle-meters)
- **`truck_meters_moving`**: average daily number of trucks multiplied by the length of interstates, expressways, and freeways (truck-meters)
- **`truck_meters_stop_go`**: average daily number of trucks multiplied by the length of arterial roads (truck-meters)

### Optional Argument

The default buffer radius is 400 meters, but can be changed by supplying an optional argument to the degauss command. For example,

```
docker run --rm -v $PWD:/tmp ghcr.io/degauss-org/aadt:0.2.2 my_address_file_geocoded.csv 800
```

will produce `my_address_file_geocoded_aadt_0.2.2_800m_buffer.csv`, and all output will be values within an 800 m buffer.

## Geomarker Methods

This container was built using the [addAadtData](https://github.com/geomarker-io/addAadtData) package.

## Geomarker Data

- AADT data was obtained from the U.S. Department of Transportation Federal Highway Administration. For more information, see [aadt_shp_to_qs](https://github.com/geomarker-io/aadt_shp_to_qs).
- AADT data is stored by state at [`s3://geomarker/aadt/aadt_by_state`](https://geomarker.s3.us-east-2.amazonaws.com/geomarker/aadt/aadt_by_state), but is also included in the Docker image.

## DeGAUSS Details

For detailed documentation on DeGAUSS, including general usage and installation, please see the [DeGAUSS homepage](https://degauss.org).
