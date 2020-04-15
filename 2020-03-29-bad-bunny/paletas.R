library(paletero)
library(magick)

imgs <- list.files("imgs", full.names = TRUE, pattern = "\\.jpg$")

pals <- list()

# 1
img <- imgs[[1]]
fuzz <- 20
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 8, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mode")
preview_colors(bg)

pals[[1]] <- list(pal = pal, bg = bg)

# 2
img <- imgs[[2]]
fuzz <- 50
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz/2)
pal <- img_palette(img, n = 8, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mode")
preview_colors(bg)
pals[[2]] <- list(pal = pal, bg = bg)


# 3
img <- imgs[[3]]
fuzz <- 12
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 4, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mode")
preview_colors(bg)
pals[[3]] <- list(pal = pal, bg = bg)


# 4
img <- imgs[[4]]
fuzz <- 12
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 6, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mode")
preview_colors(bg)
pals[[4]] <- list(pal = pal, bg = bg)


# 5
img <- imgs[[5]]
fuzz <- 12
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 4, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mode")
preview_colors(bg)
pals[[5]] <- list(pal = pal, bg = bg)


# 6
img <- imgs[[6]]
fuzz <- 20
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 4, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mode")
preview_colors(bg)
pals[[6]] <- list(pal = pal, bg = bg)


# 7
img <- imgs[[7]]
fuzz <- 12
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 6, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mode")
preview_colors(bg)
pals[[7]] <- list(pal = pal, bg = bg)


# 8
img <- imgs[[8]]
fuzz <- 5
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 6, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mean")
preview_colors(bg)

pals[[8]] <- list(pal = pal, bg = bg)

# 9
img <- imgs[[9]]
magick::image_read(img)
fuzz <- 12
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 6, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mode")
preview_colors(bg)

pals[[9]] <- list(pal = pal, bg = bg)

# 10
img <- imgs[[10]]
magick::image_read(img)
fuzz <- 12
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 5, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mode")
preview_colors(bg)

pals[[10]] <- list(pal = pal, bg = bg)

# 11
img <- imgs[[11]]
magick::image_read(img) %>% magick::image_resize("300")
fuzz <- 12
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 5, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mode")
preview_colors(bg)

pals[[11]] <- list(pal = pal, bg = bg)

# 12
img <- imgs[[12]]
magick::image_read(img) %>% magick::image_resize("300")
fuzz <- 12
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 5, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mode")
preview_colors(bg)

pals[[12]] <- list(pal = pal, bg = bg)

# 13
img <- imgs[[13]]
magick::image_read(img) %>% magick::image_resize("300")
fuzz <- 12
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 20, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mode")
preview_colors(bg)

pals[[13]] <- list(pal = pal, bg = bg)

# 14
img <- imgs[[14]]
magick::image_read(img) %>% magick::image_resize("300")
fuzz <- 8
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 10, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mean")
preview_colors(bg)

pals[[14]] <- list(pal = pal, bg = bg)

# 15
img <- imgs[[15]]
magick::image_read(img) %>% magick::image_resize("300")
fuzz <- 8
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 10, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mode")
preview_colors(bg)

pals[[15]] <- list(pal = pal, bg = bg)

# 16
img <- imgs[[16]]
magick::image_read(img) %>% magick::image_resize("300")
fuzz <- 8
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 10, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mode")
preview_colors(bg)

pals[[16]] <- list(pal = pal, bg = bg)

# 17
img <- imgs[[17]]
magick::image_read(img) %>% magick::image_resize("300")
fuzz <- 12
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 9, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mode")
preview_colors(bg)

pals[[17]] <- list(pal = pal, bg = bg)

# 18
img <- imgs[[18]]
magick::image_read(img) %>% magick::image_resize("300")
fuzz <- 12
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 9, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mean")
preview_colors(bg)

pals[[18]] <- list(pal = pal, bg = bg)

# 19
img <- imgs[[19]]
magick::image_read(img) %>% magick::image_resize("300")
fuzz <- 12
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 9, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mean")
preview_colors(bg)

pals[[19]] <- list(pal = pal, bg = bg)

# 20
img <- imgs[[20]]
magick::image_read(img) %>% magick::image_resize("300")
fuzz <- 20
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 9, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mode")
preview_colors(bg)

pals[[20]] <- list(pal = pal, bg = bg)

# 21
img <- imgs[[21]]
magick::image_read(img) %>% magick::image_resize("300")
fuzz <- 20
img_foreground(img, fuzz = fuzz)
img_background(img, fuzz = fuzz)
pal <- img_palette(img, n = 7, fuzz = fuzz)
preview_colors(pal)
bg <- img_background_color(img, fuzz = fuzz, method = "mode")
preview_colors(bg)

pals[[21]] <- list(pal = pal, bg = bg)

jsonlite::write_json(pals, "palettes.json", pretty = TRUE)

