# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
# library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
  format = "qs"
)

# Run the R scripts in the R/ folder with your custom functions:
tar_source()
# tar_source("other_functions.R") # Source other scripts as needed.

list(
  # download files from zenodo
  tar_target(
    name = data_from_zenodo,
    command = download_files_from_zenodo(
      data_folder = "data"
    ),
    format = "file"
  ),

  # download data from Natural Earth
  tar_target(
    name = eura_sf,
    packages = c("rnaturalearth", "sf"),
    command = download_ne_data(
      crs = 3035,
      xmin = 25.0e+5,
      xmax = 75.0e+5,
      ymin = 13.5e+5,
      ymax = 54.5e+5
    )
  ),

  # Create a basemap
  tar_target(
    name = euro_basemap,
    packages = c("ggplot2"),
    command = create_european_backgroundmap(
      eura_sf = eura_sf
    )
  )
)
