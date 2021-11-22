#!/usr/local/bin/Rscript

dht::greeting(geomarker_name = "aadt", version = "0.1.0", description = "returns average annual daily traffic within a buffer radius of geocoded address")

dht::qlibrary(dplyr)
dht::qlibrary(tidyr)
dht::qlibrary(sf)

doc <- "
      Usage:
      entrypoint.R <filename> [<buffer_radius>]
      "

opt <- docopt::docopt(doc)

if (is.null(opt$buffer_radius)) {
  opt$buffer_radius <- 400
}

## for interactive testing
## opt <- docopt::docopt(doc, args = 'test/my_address_file_geocoded.csv')
## opt <- docopt::docopt(doc, args = 'my_address_file_geocoded.csv')

raw_data <- readr::read_csv(opt$filename)

d <- addAadtData::add_aadt(raw_data)

dht::write_geomarker_file(d = d,
                     filename = opt$filename,
                     geomarker_name = "aadt",
                     version = glue::glue("0.1.0_{opt$buffer_radius}m_buffer"))
