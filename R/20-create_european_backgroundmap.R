# Download Eurasian geodata ---------------------------------------
download_ne_data <- function(
  crs,
  xmin,
  xmax,
  ymin,
  ymax
) {
  eura_sf <-
    # download geospatial data for European, Asian and African countries
    rnaturalearth::ne_countries(
      continent = c('europe', 'asia', 'africa'),
      returnclass = 'sf',
      scale = 10
    ) |>
    # project to crs suitable for Europe
    sf::st_transform(crs = crs) |>
    # merge into single polygon
    sf::st_union(by_feature = FALSE) |>
    # crop to Europe
    sf::st_crop(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax)

  return(eura_sf)
}

# Draw a basemap of Europe ----------------------------------------
create_european_backgroundmap <- function(
  eura_sf
) {
  # eura_sf <- targets::tar_read(eura_sf) # for debug

  euro_basemap <-
    ggplot2::ggplot(eura_sf) +
    ggplot2::geom_sf(
      aes(geometry = geometry),
      color = NA,
      fill = 'grey90'
    ) +
    ggplot2::coord_sf(expand = FALSE, datum = NA) +
    ggplot2::theme_void()

  return(euro_basemap)
}
