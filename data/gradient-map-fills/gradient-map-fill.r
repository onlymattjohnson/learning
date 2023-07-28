library(tidyverse)
library(sf)
library(spatstat)
library(tigris)
library(rnaturalearth)
library(patchwork)

# Set theme
theme_set(
  # Theme Void is an empty theme, base_family is the base font family
  theme_void(base_family = "Roboto Slab") + 
    theme(plot.title = element_text(face = "bold", hjust = 0.5))
)

# Overplotting
# fig0.png: This happens when th ere are too many data points in one place
ggplot(diamonds, aes(x = carat, y = price)) + 
  geom_point() + 
  theme_minimal()

# Fixes
## fig1.png: Smaller points
ggplot(diamonds, aes(x = carat, y = price)) + 
  geom_point(size = 0.2) + 
  theme_minimal()

## fig2.png: semi-transparent points
ggplot(diamonds, aes(x = carat, y = price)) + 
  geom_point(alpha = 0.01) + 
  theme_minimal()


## fig3.png: binned points
ggplot(diamonds, aes(x = carat, y = price)) + 
  stat_bin2d() + 
  scale_fill_viridis_c() +
  theme_minimal()

## fig4.png: hex binned
ggplot(diamonds, aes(x = carat, y = price)) + 
  stat_binhex() + 
  scale_fill_viridis_c() +
  theme_minimal()

## fig5.png: density contour
withr::with_seed(4393, {
  dsmall <- diamonds[sample(nrow(diamonds), 1000),]
})

ggplot(dsmall, aes(x=carat, y=price)) +
  geom_density2d_filled() +
  theme_minimal()

###################
# Georgia Mapping #
###################

# We can make shapefiles using ESRI:102118 Georgia
ga_crs <- st_crs("ESRI:102118")

# Geographic data from State of Georgia
ga_cultural <- read_sf("data/shapefiles/cultural.shp") %>%
  st_set_crs(st_crs("EPSG:4326"))

ga_campgrounds <- ga_cultural %>%
  filter(DESCRIPTOR == "CAMP/CAMPGROUND") %>%
  st_transform(ga_crs)

# Bring in state map of georgia and counties
options(tigris_use_cache = TRUE)
Sys.setenv(TIGRIS_CACHE_DIR = "maps")

ga_state <- states(cb = TRUE, resolution = "500k", year = 2022) %>%
  filter(STUSPS == "GA") %>%
  st_transform(ga_crs)

ga_counties <- counties(state = "13", cb = TRUE, resolution = "500k", year = 2022) %>%
  st_transform(ga_crs)

# Let's also add rivers and lakes to make it more clear that this isn't just
# an xy axes

ne_shapes_to_get <- c(
  "rivers_lake_centerlines", "rivers_north_america",
  "lakes","lakes_north_america"
)

if (!file.exists("maps/ne_10_m_lakes.shp")) {
  ne_shapes_to_get %>%
    walk(~ ne_download(
      scale = 10, type = .x, category = "physical",
      destdir = "maps", load = FALSE
    ))
}

# Load the downloaded shapefiles and store in a list
ne_data_list <- ne_shapes_to_get %>%
  map(~ {
    ne_load(
      scale = 10, type = .x, category = "physical",
      destdir="maps", returnclass = "sf"
    ) %>%
      st_transform(ga_crs)
  }) %>%
  set_names(ne_shapes_to_get)

# Load data sets to the global environment
list2env(ne_data_list, envir = .GlobalEnv)

# Limit everything to just Georgia
rivers_global_ga <- st_intersection(ga_state, rivers_lake_centerlines)
rivers_na_ga <- st_intersection(ga_state, rivers_north_america)
lakes_global_ga <- st_intersection(ga_state, lakes)
lakes_na_ga <- st_intersection(ga_state, lakes_north_america)

# let's see the initial map
plot_initial <- ggplot() +
  geom_sf(data = ga_state, fill = "grey20") + 
  geom_sf(data = rivers_global_ga, linewidth = 0.3, color = "white") + 
  geom_sf(data = rivers_na_ga, linewidth  = 0.1, color = "white") + 
  geom_sf(data = lakes_global_ga, fill = "white", color = NA) + 
  geom_sf(data = lakes_na_ga, fill = "white", color = NA) + 
  geom_sf(data = ga_campgrounds, size = 0.5, color = "grey50") + 
  coord_sf(crs = ga_crs)

plot_initial
