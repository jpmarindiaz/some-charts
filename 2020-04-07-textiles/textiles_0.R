
library(igraph)
library(tidyverse)


textile_size <- c(8,8)
code_cols <- sample(c(1,0), textile_size[1] - 1, replace = TRUE)
code_rows <- sample(c(1,0), textile_size[2] - 1, replace = TRUE)

g <- graph.lattice(textile_size)
# plot(g)

edges <- get.data.frame(g, "edges") %>%
  mutate(row_or_col = ifelse(to - from == 1, "row","col"),
         row_or_col_n = ifelse(row_or_col == "row",
                               from %/% textile_size[1] + 1,
                               ifelse(to %% textile_size[2] == 0, textile_size[2],
                                      to %% textile_size[2])))

# Create xy positions for nodes
nodes <- V(g)
pos <- matrix(V(g), nrow=textile_size[1], ncol = textile_size[2], byrow = TRUE,
              dimnames = list(1:textile_size[1], 1:textile_size[2]))
pos <- as_tibble(pos) %>% rownames_to_column(var = "x")
nodes <- pos %>%  pivot_longer(-x, names_to = "y", values_to = "name") %>%
  select(name, x, y) %>%
  map_df(as.numeric)

g <- graph.data.frame(edges, vertices = as.data.frame(nodes), directed = FALSE)
layout <- as.matrix(nodes[,c("x","y")]) %*% matrix(c(0,1,-1,0), nrow = 2)

# layout: need to rotate the layout matrix, igraph.plot uses bottom-whatever indexing
plot(g, layout = layout)

edges_code <- get.data.frame(g, "edges") %>%
  group_by(row_or_col, row_or_col_n) %>%
  mutate(odd_row_col = row_or_col_n %% 2) %>%
  mutate(code_original = ifelse(row_or_col == "col", code_rows,code_cols)) %>%
  mutate(code = ifelse(!odd_row_col,  # negate alternatively
                       code_original,
                       (code_original + 1) %% 2)) %>%
  arrange(row_or_col, row_or_col_n)
edges_filtered <- edges_code %>%
  filter(code == 1)

textile_g <- graph.data.frame(edges_filtered, vertices = as.data.frame(nodes), directed = FALSE)
layout <- as.matrix(nodes[,c("x","y")]) %*% matrix(c(0,1,-1,0), nrow = 2)

# layout: need to rotate the layout matrix, igraph.plot uses bottom-whatever indexing
plot(textile_g, layout = layout)





library(tidygraph)
library(ggraph)

tg <- as_tbl_graph(textile_g)

tg2 <- tg %>%
  mutate(components = group_components()) %>%
  activate(nodes)

n_componencts <- max(nd$components)
n_componencts

nd <- as_tibble(tg2)

library(grid)

gg <- ggplot(nd, aes(-x,-y, fill = as.factor(components))) +
  geom_raster() +
  coord_equal() + guides(fill = FALSE) +
  theme_void()
print(gg, vp=viewport(angle=90))

# graph <- tg2 %>%
#   ggraph(x = -x, y = y) +
#   # ggraph() +
#   geom_edge_link(aes(alpha = ..index..), show.legend = FALSE) +
#   geom_node_point(aes(colour = as.factor(components)), size = 7) +
#   theme_graph() + guides(colour = FALSE) +
#   coord_equal() +
#   scale_y_reverse()
# # print(graph)
# print(graph, vp=viewport(angle=90))







