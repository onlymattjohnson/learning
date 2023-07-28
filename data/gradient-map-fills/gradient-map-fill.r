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


