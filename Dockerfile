FROM rocker/r-ver:4.0.4

RUN R --quiet -e "install.packages('remotes', repos = c(CRAN = 'https://packagemanager.rstudio.com/all/__linux__/focal/latest'))"
RUN R --quiet -e "remotes::install_github('rstudio/renv@0.14.0')"

WORKDIR /app

RUN apt-get update \
  && apt-get install -yqq --no-install-recommends \
  libgdal-dev \
  libgeos-dev \
  libudunits2-dev \
  libproj-dev \
  && apt-get clean

COPY renv.lock .

RUN R --quiet -e "renv::restore(repos = c(CRAN = 'https://packagemanager.rstudio.com/all/__linux__/focal/latest'))"

COPY s3_downloads/ .
COPY entrypoint.R .

WORKDIR /tmp

ENTRYPOINT ["/app/entrypoint.R"]
