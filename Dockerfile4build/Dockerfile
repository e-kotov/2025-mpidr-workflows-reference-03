FROM rocker/geospatial:4.4.3

RUN mkdir -p /home/rstudio/project && \ 
    chown -R rstudio:rstudio /home/rstudio/project
WORKDIR /home/rstudio/project

COPY --chown=rstudio:rstudio ../renv.lock renv.lock
RUN mkdir -p renv
COPY --chown=rstudio:rstudio ../.Rprofile .Rprofile
COPY --chown=rstudio:rstudio ../renv/activate.R renv/activate.R
COPY --chown=rstudio:rstudio ../renv/settings.json renv/settings.json

RUN R -e "renv::restore(library = '/usr/local/lib/R/site-library')"

RUN chmod -R u+w /home/rstudio/project && rm -rf /home/rstudio/project
