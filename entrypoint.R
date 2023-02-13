#!/usr/local/bin/Rscript

dht::greeting()

## load libraries without messages or warnings
withr::with_message_sink("/dev/null", library(dplyr))
withr::with_message_sink("/dev/null", library(tidyr))
withr::with_message_sink("/dev/null", library(sf))

doc <- "
      Usage:
      entrypoint.R <filename> [<buffer_radius>]
      "

opt <- docopt::docopt(doc)

if (is.null(opt$buffer_radius)) {
  opt$buffer_radius <- 400
} else {
  opt$buffer_radius <- as.numeric(opt$buffer_radius)
}

## for interactive testing
## opt <- docopt::docopt(doc, args = 'test/my_address_file_geocoded.csv')
## opt <- docopt::docopt(doc, args = 'my_address_file_geocoded.csv')

message("reading input file...")
d <- dht::read_lat_lon_csv(opt$filename)

## add code here to calculate geomarkers
d <- addAadtData::add_aadt(d, opt$buffer_radius)

dht::write_geomarker_file(d = d,
                     filename = opt$filename,
                     argument = glue::glue('{opt$buffer_radius}m_buffer'))
