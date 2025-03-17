FROM rocker/binder:4.4.2

RUN mkdir -p /home/rstudio/project && \ 
    chown -R rstudio:rstudio /home/rstudio/project
WORKDIR /home/rstudio/project

COPY --chown=rstudio:rstudio ../renv.lock renv.lock
RUN mkdir -p renv
COPY --chown=rstudio:rstudio ../.Rprofile .Rprofile
COPY --chown=rstudio:rstudio ../renv/activate.R renv/activate.R
COPY --chown=rstudio:rstudio ../renv/settings.json renv/settings.json

RUN R -e "renv::restore(library = '/usr/local/lib/R/site-library', repos = 'https://packagemanager.posit.co/cran/__linux__/noble/2024-02-28')"

RUN chmod -R u+w /home/rstudio/project && rm -rf /home/rstudio/project

COPY --chown=rstudio . /home/rstudio

RUN rm -rf /home/rstudio/renv \
           /home/rstudio/renv.lock \
           /home/rstudio/.Rprofile

EXPOSE 8888
CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--no-browser"]
