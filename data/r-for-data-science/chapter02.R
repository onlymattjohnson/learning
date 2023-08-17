library(tidyverse)
library(palmerpenguins)
library(ggthemes)

# Do penguins with longer flippers weigh more 
# or less than penguins with shorter flippers?

# Is there a relationship between flipper length
# and body mass?

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) + 
  geom_point(mapping = aes(color = species, shape = species)) + 
  geom_smooth(method = "lm") + 
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper lenght (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) + 
  scale_color_colorblind()

# How many rows?
nrow(penguins)

# How many columns?
ncol(penguins)

# Make a scatterplot of bill_depth_mm vs. bill_length_mm. 
# That is, make a scatterplot with bill_depth_mm on 
# the y-axis and bill_length_mm on the x-axis. 
# Describe the relationship between these two variables.

ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm, color = species)
) + 
  geom_point()


# What happens with scatterplot of species vs bill depth?
ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)
) + 
  geom_boxplot()

# You get a weird vertical chart. Better option would be boxplot

# Recreate a particular visual

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm,  y = body_mass_g, color = bill_depth_mm)
) + 
  geom_point() + 
  geom_smooth()

## Distributions

ggplot(penguins, aes(x = species)) + 
  geom_bar()

ggplot(penguins, aes(x = fct_infreq(species))) + 
  geom_bar()

### Continuous variables
# Histograms
ggplot(penguins, aes(x = body_mass_g)) + 
  geom_histogram(binwidth = 200)

# Density plots
ggplot(penguins, aes(x = body_mass_g)) + 
  geom_density()

### Exercises

ggplot(penguins, aes(y = species)) + 
  geom_bar()

ggplot(diamonds, aes(x = carat)) + 
  geom_histogram(binwidth = 0.25)

# Box plots to compare categorical and numeric variables
ggplot(penguins, aes(x = species, y = body_mass_g)) + 
  geom_boxplot()

# Comparing two categorical variables

## Stacked bar plot
ggplot(penguins, aes(x = island, fill = species)) + 
  geom_bar()

## Relative frequency
ggplot(penguins, aes(x = island, fill = species)) + 
  geom_bar(position = "fill")

# Comparing 3+ variables

## Facets
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point(aes(color = species, shape = species)) + 
  facet_wrap(~island)

# Saving plots
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()
ggsave(filename = "penguin-plot.png")
