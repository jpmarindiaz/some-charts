library(tidyverse)
library(geodata)
library(ggmagic)
library(magick)
library(paletero)

library(makeup)

# todos
# could not find function "makeup_format"
# format_cat when expecting format_dat... ojo, better defaults or error messages


paletas <- jsonlite::fromJSON("palettes.json",
                              simplifyDataFrame = FALSE)

# csse <- read_csv("https://data.datasketch.co/datasketch/coronavirus/data/world/csse/tidy-csse-es.csv")
# write_csv(csse, "data/csse.csv")
csse <- read_csv("data/csse.csv")

meta <- geodataMeta("world_countries")
regions <- meta$regions
latam_countries_iso <- regions %>%
  filter(region == "WB Latin America & Caribbean") %>%
  pull(id)
continents <- unique(regions$region)[1:8]
continents <- regions %>%
  filter(region %in% continents)

csse_cont <- csse %>% left_join(continents, c("iso_alpha3" = "id"))

imgs <- list.files("imgs", full.names = TRUE, pattern = "\\.jpg$")



########
caption <- "Más datos abiertos en coronavirus.datasketch.co"
branding_text <- "Corte a 12 de abril de 2020\n<br>Fuente: Johns Hopkins University, CSSE."



########

## 1

# Casos por continentes

d <- csse_cont %>%
  group_by(region, country) %>%
  slice(n()) %>%
  group_by(region) %>%
  summarise(total = sum(confirmed)) %>%
  filter(!is.na(region)) %>%
  filter(!grepl("Seven",region)) %>%
  ungroup()
d$region
regiones <- tibble(
  x = c("South America", "Oceania", "North America",
        "Europe", "Asia", "Africa"),
  y = c("Sur América", "Oceanía", "Norte América",
        "Europa", "Asia", "África"))
d$region <- mop::match_replace(d$region, regiones)

img_number <- 1
imgs[[img_number]] %>% image_read() %>% image_resize("250")
pal <- lighter_scale(rev(paletas[[img_number]]$pal), 1)
preview_colors(pal)
opts <- list(
  title = "Casos de coronavirus por continente",
  subtitle = "Para 178 países con contagios reportados",
  ver_title = " ",
  hor_title = " ",
  orientation = "hor",
  format_cat_sample = "Title Case",
  text_size = 12,
  palette_colors = pal,
  background_color = paletas[[img_number]]$bg,
  color_by = names(d)[1],
  text_color = "#dddddd",
  line_color = "#dddd99",
  grid_color = "#999999",
  branding_include = TRUE,
  caption = caption,
  branding_text = branding_text
)
plot <- gg_bar_CatNum(d, opts = opts)
plot
ggsave(paste0("charts/",img_number,".png"), plot, width = 12, height = 12, units = "cm")

# Países de américa latina con más casos

latam_countries <- c("Brasil", "Perú", "Ecuador", "Chile", "México", "Panamá",
  "República Dominicana", "Colombia", "Argentina", "Cuba",
  "Costa Rica", "Uruguay", "Honduras", "Bolivia", "Venezuela",
  "Guatemala", "Paraguay", "El Salvador",
  # "Trinidad y Tobago", "Barbados", "Jamaica", "Bahamas",
  # "Guyana", "Haití", "Antigua y Barbuda", "Dominica",
  # "Santa Lucía", "Belice", "Granada", "San Cristóbal y Nieves",
  # "San Vicente y las Granadinas", "Surinam",
  "Nicaragua")

d_latam <- csse %>%
  filter(iso_alpha3 %in% latam_countries_iso) %>%
  filter(country %in% latam_countries) %>%
  group_by(country) %>%
  slice(n()) %>%
  arrange(desc(confirmed))
d_latam$country[d_latam$country == "República Dominicana"] <- "Rep Dominicana"

d <- d_latam %>% select(country, confirmed)

img_number <- 2
imgs[[img_number]] %>% image_read() %>% image_resize("250")
pal <- paletas[[img_number]]$pal
preview_colors(pal)
pal <- c(pal, lighter_scale(pal, n = 2))
preview_colors(pal)

opts <- list(
  title = "Número de contagios reportados",
  subtitle = "COVID-19 en América Latina",
  ver_title = " ",
  hor_title = " ",
  orientation = "hor",
  format_cat_sample = "Title",
  text_size = 12,
  palette_colors = pal,
  background_color = paletas[[img_number]]$bg,
  color_by = names(d)[1],
  text_color = "#dddddd",
  line_color = "#dddddd",
  grid_color = "#999999",
  branding_include = TRUE,
  caption = caption,
  branding_text = branding_text
)
plot <- gg_bar_CatNum(d, opts = opts)
plot
ggsave(paste0("charts/",img_number,".png"), plot, width = 12, height = 12, units = "cm")


## 3
d <- d_latam %>% select(country, death)

img_number <- 3
imgs[[img_number]] %>% image_read() %>% image_resize("250")
pal <- paletas[[img_number]]$pal
preview_colors(pal)
pal <- c(pal, darker_scale(pal, n = 4))
preview_colors(pal)
bg <- paletas[[img_number]]$bg
# bg <- lighter_scale(bg,1, step = 1, factor = 0.5)
preview_colors(bg)
opts <- list(
  title = "Número de muertes reportadas",
  subtitle = "COVID-19 en América Latina",
  ver_title = " ",
  hor_title = " ",
  orientation = "hor",
  format_cat_sample = "Title",
  text_size = 12,
  palette_colors = pal,
  background_color = bg,
  color_by = names(d)[1],
  text_color = "#444444",
  line_color = "#444444",
  grid_color = "#dbc7bc",
  branding_include = TRUE,
  caption = caption,
  branding_text = branding_text
)
plot <- gg_bar_CatNum(d, opts = opts)
plot
ggsave(paste0("charts/",img_number,".png"), plot, width = 12, height = 12, units = "cm")


## 4
d <- d_latam %>%
  select(country, confirmed, death) %>%
  mutate(death_conf = death/confirmed) %>%
  select(country, death_conf)

img_number <- 4
imgs[[img_number]] %>% image_read() %>% image_resize("250")
pal <- paletas[[img_number]]$pal
preview_colors(pal)
pal <- c(pal, lighter_scale(pal, n = 3))
preview_colors(pal)
bg <- paletas[[img_number]]$bg
# bg <- lighter_scale(bg,1, step = 1, factor = 0.5)
preview_colors(bg)
opts <- list(
  title = "Proporción de muertes sobre casos",
  subtitle = "COVID-19 en América Latina",
  ver_title = " ",
  hor_title = " ",
  orientation = "hor",
  format_cat_sample = "Title",
  format_num_sample = "10%",
  text_size = 12,
  palette_colors = pal,
  background_color = bg,
  color_by = names(d)[1],
  text_color = "#999999",
  line_color = "#999999",
  grid_color = "#444444",
  branding_include = TRUE,
  caption = caption,
  branding_text = branding_text
)
plot <- gg_bar_CatNum(d, opts = opts)
plot
ggsave(paste0("charts/",img_number,".png"), plot, width = 12, height = 12, units = "cm")


## 5
d <- d_latam %>%
  select(country, recovered)

img_number <- 5
imgs[[img_number]] %>% image_read() %>% image_resize("250")
pal <- paletas[[img_number]]$pal
preview_colors(pal)
pal <- c(lighter_scale(pal, n = 4))
preview_colors(pal)
bg <- paletas[[img_number]]$bg
# bg <- lighter_scale(bg,1, step = 1, factor = 0.5)
preview_colors(bg)
opts <- list(
  title = "Número de personas recuperadas",
  subtitle = "COVID-19 en América Latina",
  ver_title = " ",
  hor_title = " ",
  orientation = "hor",
  format_cat_sample = "Title",
  text_size = 12,
  palette_colors = pal,
  background_color = bg,
  color_by = names(d)[1],
  text_color = "#dddddd",
  line_color = "#dddddd",
  grid_color = "#e07686",
  branding_include = TRUE,
  caption = caption,
  branding_text = branding_text
)
plot <- gg_bar_CatNum(d, opts = opts)
plot
ggsave(paste0("charts/",img_number,".png"), plot, width = 12, height = 12, units = "cm")


## 6
d <- d_latam %>%
  select(country, days_1st_case)

img_number <- 6
imgs[[img_number]] %>% image_read() %>% image_resize("250")
pal <- paletas[[img_number]]$pal
preview_colors(pal)
pal <- c(darker_scale(pal, n = 4))
preview_colors(pal)
bg <- paletas[[img_number]]$bg
# bg <- darker_scale(bg,1, step = 1, factor = 0.5)
preview_colors(bg)
opts <- list(
  title = "Número de días desde el primer caso",
  subtitle = "COVID-19 en América Latina",
  ver_title = " ",
  hor_title = " ",
  orientation = "hor",
  format_cat_sample = "Title",
  text_size = 12,
  palette_colors = pal,
  background_color = bg,
  color_by = names(d)[1],
  text_color = "#222222",
  line_color = "#666666",
  grid_color = "#f4e397",
  branding_include = TRUE,
  caption = caption,
  branding_text = branding_text
)
plot <- gg_bar_CatNum(d, opts = opts)
plot
ggsave(paste0("charts/",img_number,".png"), plot, width = 12, height = 12, units = "cm")


## Latam time

d_latam_time <- csse %>%
  filter(iso_alpha3 %in% latam_countries_iso) %>%
  filter(country %in% latam_countries)
d_latam$country[d_latam$country == "República Dominicana"] <- "Rep Dominicana"

## 7

d <- d_latam_time %>%
  filter(country == "Colombia") %>%
  select(date, confirmed)

img_number <- 7
imgs[[img_number]] %>% image_read() %>% image_resize("250")
pal <- paletas[[img_number]]$pal
preview_colors(pal)
pal <- c(darker_scale(pal, n = 4))
preview_colors(pal)
bg <- paletas[[img_number]]$bg
# bg <- darker_scale(bg,1, step = 1, factor = 0.5)
pal <- c("#ffffff")
preview_colors(bg)
opts <- list(
  title = "Número de contagios ",
  subtitle = "Casos COVID-19 reportados en Colombia",
  ver_title = " ",
  hor_title = " ",
  orientation = "hor",
  format_dat_sample = "Ene 20",
  format_num_sample = "1,234.56",
  locale = "es-CO",
  text_size = 12,
  palette_colors = pal,
  background_color = bg,
  # color_by = names(d)[1],
  text_color = "#222222",
  line_color = "#f90240",
  grid_color = "#fce26c",
  branding_include = TRUE,
  caption = caption,
  branding_text = branding_text
)
plot <- gg_bar_DatNum(d, opts = opts)
plot
ggsave(paste0("charts/",img_number,".png"), plot, width = 12, height = 12, units = "cm")

## 8
d <- d_latam_time %>%
  filter(country == "México") %>%
  select(date, confirmed)

img_number <- 8
imgs[[img_number]] %>% image_read() %>% image_resize("250")
pal <- paletas[[img_number]]$pal
preview_colors(pal)
pal <- c(darker_scale(pal, n = 4))
pal <- c("#222222")
preview_colors(pal)
bg <- paletas[[img_number]]$bg
bg <- lighter_scale(bg,1, step = 1, factor = 0.5)
preview_colors(bg)
opts <- list(
  title = "Número de contagios ",
  subtitle = "Casos COVID-19 reportados en México",
  ver_title = " ",
  hor_title = " ",
  orientation = "hor",
  format_dat_sample = "Ene 20",
  format_num_sample = "1,234.56",
  locale = "es-CO",
  text_size = 12,
  palette_colors = pal,
  background_color = bg,
  # color_by = names(d)[1],
  text_color = "#444444",
  line_color = "#ffffff",
  grid_color = "#dae0ea",
  branding_include = TRUE,
  caption = caption,
  branding_text = branding_text
)
plot <- gg_bar_DatNum(d, opts = opts)
plot
ggsave(paste0("charts/",img_number,".png"), plot, width = 12, height = 12, units = "cm")


## 9
d <- d_latam_time %>%
  filter(country == "Argentina") %>%
  select(date, confirmed)

img_number <- 9
imgs[[img_number]] %>% image_read() %>% image_resize("250")
pal <- paletas[[img_number]]$pal
preview_colors(pal)
#pal <- c(darker_scale(pal, n = 4))
pal <- c("#c92a28")
preview_colors(pal)
bg <- paletas[[img_number]]$bg
bg <- lighter_scale(bg,1, step = 1, factor = 0.5)
preview_colors(bg)
opts <- list(
  title = "Número de contagios ",
  subtitle = "Casos COVID-19 reportados en Argentina",
  ver_title = " ",
  hor_title = " ",
  orientation = "hor",
  format_dat_sample = "Ene 20",
  format_num_sample = "1,234.56",
  locale = "es-CO",
  text_size = 12,
  palette_colors = pal,
  background_color = bg,
  # color_by = names(d)[1],
  text_color = "#ffffff",
  line_color = "#c6b7ad",
  grid_color = "#915c37",
  branding_include = TRUE,
  caption = caption,
  branding_text = branding_text
)
plot <- gg_bar_DatNum(d, opts = opts)
plot
ggsave(paste0("charts/",img_number,".png"), plot, width = 12, height = 12, units = "cm")

# 10
d <- d_latam_time %>%
  filter(country == "Perú") %>%
  select(date, confirmed)

img_number <- 10
imgs[[img_number]] %>% image_read() %>% image_resize("250")
pal <- paletas[[img_number]]$pal
preview_colors(pal)
#pal <- c(darker_scale(pal, n = 4))
bg <- paletas[[img_number]]$bg
#bg <- lighter_scale(bg,1, step = 1, factor = 0.5)
preview_colors(bg)
opts <- list(
  title = "Número de contagios ",
  subtitle = "Casos COVID-19 reportados en Perú",
  ver_title = " ",
  hor_title = " ",
  orientation = "hor",
  format_dat_sample = "Ene 20",
  format_num_sample = "1,234.56",
  locale = "es-CO",
  text_size = 12,
  palette_colors = pal[2],
  background_color = bg,
  # color_by = names(d)[1],
  text_color = pal[1],
  line_color = pal[3],
  grid_color = pal[4],
  branding_include = TRUE,
  caption = caption,
  branding_text = branding_text
)
plot <- gg_bar_DatNum(d, opts = opts)
plot
ggsave(paste0("charts/",img_number,".png"), plot, width = 12, height = 12, units = "cm")

# 11
d <- d_latam_time %>%
  filter(country == "Ecuador") %>%
  select(date, confirmed)

img_number <- 11
imgs[[img_number]] %>% image_read() %>% image_resize("250")
pal <- paletas[[img_number]]$pal
preview_colors(pal)
#pal <- c(darker_scale(pal, n = 4))
bg <- paletas[[img_number]]$bg
#bg <- lighter_scale(bg,1, step = 1, factor = 0.5)
preview_colors(bg)
opts <- list(
  title = "Número de contagios ",
  subtitle = "Casos COVID-19 reportados en Ecuador",
  ver_title = " ",
  hor_title = " ",
  orientation = "hor",
  format_dat_sample = "Ene 20",
  format_num_sample = "1,234.56",
  locale = "es-CO",
  text_size = 12,
  palette_colors = pal[5],
  background_color = bg,
  # color_by = names(d)[1],
  text_color = "#334422",
  line_color = "#000000",
  grid_color = "#ffffff",
  branding_include = TRUE,
  caption = caption,
  branding_text = branding_text
)
plot <- gg_bar_DatNum(d, opts = opts)
plot
ggsave(paste0("charts/",img_number,".png"), plot, width = 12, height = 12, units = "cm")


# 12
d <- d_latam_time %>%
  filter(country == "Chile") %>%
  select(date, confirmed)

img_number <- 12
imgs[[img_number]] %>% image_read() %>% image_resize("250")
pal <- paletas[[img_number]]$pal
preview_colors(pal)
#pal <- c(darker_scale(pal, n = 4))
bg <- paletas[[img_number]]$bg
#bg <- lighter_scale(bg,1, step = 1, factor = 0.5)
preview_colors(bg)
opts <- list(
  title = "Número de contagios ",
  subtitle = "Casos COVID-19 reportados en Chile",
  ver_title = " ",
  hor_title = " ",
  orientation = "hor",
  format_dat_sample = "Ene 20",
  format_num_sample = "1,234.56",
  locale = "es-CO",
  text_size = 12,
  palette_colors = pal[3],
  background_color = bg,
  # color_by = names(d)[1],
  text_color = pal[1],
  line_color = "#ffffff",
  grid_color = pal[4],
  branding_include = TRUE,
  caption = caption,
  branding_text = branding_text
)
plot <- gg_bar_DatNum(d, opts = opts)
plot
ggsave(paste0("charts/",img_number,".png"), plot, width = 12, height = 12, units = "cm")






####

# d_america <- csse_cont %>%
#   filter(region %in% c("South America", "North America")) %>%
#   group_by(region, country) %>%
#   slice(n()) %>%
#   arrange(desc(confirmed))




# Países con mayor crecimiento promedio en casos los últimos 7 días


# Países con mayor crecimiento promedio en casos los últimos 7 días


# Porcentaje de crecimiento en casos países latam


# Cuánto tiempo desde el primer caso hasta la primera muerta
# Días desde el primer caso hasta los primeras 10 casos
# Días desde la primera muerte hasta las primeras 10
# Países con mayor número de recuperados/confirmados
# Países con mayor número de muertes/confirmados
# Totales de casos por continente



# Top 10 de países con más casos
# Los países donde hasta ahora está empezando
# América Latina: casos por 1M de habitantes acumulados
# América Latina: muertes por 1M de habitantes
# Número de días en que se duplicaron los casos a hoy



# Porcentaje de crecimiento muertes (desde muerte 10)
# Top 10
# csse_growth <- csse %>%
#   filter(death > 9) %>%
#   group_by(country, iso_alpha3) %>%
#   filter(n() > 10) %>%
#   mutate(death_gw = (death - lag(death))/lag(death)) %>%
#   mutate(ave_death_gw = mean(death_gw, na.rm = TRUE)) %>%
#   ungroup()
# top_gw_countries <- csse_growth %>%
#   select(country, iso_alpha3, ave_death_gw) %>%
#   distinct() %>%
#   top_n(10) %>%
#   pull(country)
# d <- csse_growth %>%
#   filter(country %in% top_gw_countries, !is.na(death_gw)) %>%
#   select(country, date, death_gw)
#
#
# gg_line_CatCatNum(d)











