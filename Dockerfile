FROM rocker/r-ver:4.0.4

# DeGAUSS container metadata
ENV degauss_name="aadt"
ENV degauss_version="0.1.1"
ENV degauss_description="average annual daily traffic"
ENV degauss_argument="buffer radius in meters [default: 400]"

# add OCI labels based on environment variables too
LABEL "org.degauss.name"="${degauss_name}"
LABEL "org.degauss.version"="${degauss_version}"
LABEL "org.degauss.description"="${degauss_description}"
LABEL "org.degauss.argument"="${degauss_argument}"

RUN R --quiet -e "install.packages('remotes', repos = c(CRAN = 'https://packagemanager.rstudio.com/all/__linux__/focal/latest'))"
RUN R --quiet -e "remotes::install_github('rstudio/renv@0.14.0')"

WORKDIR /app

RUN apt-get update \
  && apt-get install -yqq --no-install-recommends \
  libgdal-dev \
  libgeos-dev \
  libudunits2-dev \
  libproj-dev \
  curl \
  && apt-get clean

COPY renv.lock .

RUN R --quiet -e "Sys.setenv(RENV_DOWNLOAD_METHOD = 'curl')"
RUN R --quiet -e "options(renv.config.connect.timeout = 300)"
RUN R --quiet -e "renv::restore(repos = c(CRAN = 'https://packagemanager.rstudio.com/all/__linux__/focal/latest'))"

COPY entrypoint.R .

WORKDIR /tmp

ENTRYPOINT ["/app/entrypoint.R"]
