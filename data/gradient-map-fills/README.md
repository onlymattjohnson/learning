# Gradient Map Fills

An exercise to learn about fixing overplotted points in R. This exercise comes from [the blog of Andrew Heiss](https://www.andrewheiss.com/blog/2023/07/28/gradient-map-fills-r-sf/index.html)

# What is overplotting?

**Overplotting** is what happens when there are too many data ponts in one place. An example is this scatterplot of diamond carats and prices

> ![Overplotted scatterplot](img/fig0.png)

## Potential fixes

### Smaller points

> ![smaller points](img/fig1.png)

### Transparency

You can fix the overplotting with some transparency. **Alpha** ranges from 0 (completely transparent) to 1 (completely solid). This is with an alpha of 0.01

> ![smaller points](img/fig2.png)
