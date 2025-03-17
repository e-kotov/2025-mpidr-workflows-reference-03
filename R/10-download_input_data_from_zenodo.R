# Download analysis input data from Zenodo
download_files_from_zenodo <- function(
  data_folder = "data"
) {
  # make sure the data folder exists
  if (!dir.exists(data_folder)) {
    dir.create(data_folder, recursive = TRUE)
  }

  # download the files
  download.file(
    url = 'https://zenodo.org/records/15033155/files/10-euro_education.csv?download=1',
    destfile = paste0(data_folder, "/10-euro_education.csv")
  )

  download.file(
    url = 'https://zenodo.org/records/15033155/files/10-euro_sectors.csv?download=1',
    destfile = paste0(data_folder, "/10-euro_sectors.csv")
  )

  download.file(
    url = 'https://zenodo.org/records/15033155/files/10-euro_geo_nuts2.rds?download=1',
    destfile = paste0(data_folder, "/10-euro_geo_nuts2.rds")
  )

  # find the downloaded files
  data_from_zenodo <- list.files("data", full.names = TRUE)

  # return the list of files
  return(data_from_zenodo)
}
