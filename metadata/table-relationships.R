library(DBI)
library(RSQLite)
library(soilDB)
library(igraph)
library(data.tree)


# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')


# # consider using indexes
# index.data <- dbGetQuery(db, "select tbl_name, sql
# FROM sqlite_master
# WHERE type='index'")

# list tables
tbl <- dbListTables(db)

# field names by table
fields <- lapply(tbl, dbListFields, conn = db)
names(fields) <- tbl

# all pair-wise intersecting field names
res <- list()
s <- seq_along(fields)

for(i in s) {
  
  all.other.tbls <- fields[s[-i]]
  this.tbl.fields <- fields[[i]]
  this.tbl <- names(fields[i])
  
  x <- lapply(all.other.tbls, intersect, this.tbl.fields)
  
  idx <- which(sapply(x, length) > 0)
  matching.tbls <- names(idx)
  matching.fields <- sapply(x[idx], function(j) paste(j, collapse='|'))
  
  
  d <- data.frame(
    source=this.tbl, 
    target=matching.tbls, 
    fields=matching.fields,
    stringsAsFactors = FALSE
    )
  
  res[[this.tbl]] <- d
  
}

# flatten
z <- do.call('rbind', res)
row.names(z) <- as.character(1:nrow(z))


## not working
# include links
# z$name <- sprintf("%s->%s", z$source, z$target)
# g <- graph_from_data_frame(z, directed=FALSE, vertices = z[, c('name', 'fields')])

# convert to graph, all additional attributes are preserved as edge attrs
g <- graph_from_data_frame(z, directed=FALSE)

# flatten linkages to unique combinations
# keep the first attribute (field names) in the result
g <- simplify(g, edge.attr.comb = 'first')

par(mar=c(0,0,0,0))

set.seed(101010)
plot(g, vertex.label.family='sans', vertex.label.cex=0.66, vertex.color='grey', vertex.label.color='black', vertex.size=sqrt(degree(g)) * 5)

plot(g, vertex.label.family='sans', vertex.label.cex=0.85, vertex.color='grey', vertex.label.color='black', vertex.size=sqrt(degree(g)) * 5, edge.label=z$fields, edge.label.cex=0.5, edge.label.family='sans', edge.label.color='royalblue')




## convert simplified edgelist back to matrix
df <- as_data_frame(g)
# kableExtra::kable_styling(knitr::kable(df[1:5, ]))

# save and manually edit, re-name
write.csv(df, file='table-links-to-edit.csv', row.names = FALSE)


# done
dbDisconnect(db)


x <- read.csv('table-links-fixed.csv', stringsAsFactors = FALSE)
g <- graph_from_data_frame(x, directed=FALSE)

# identify clusters of sub-graphs
sg <- clusters(g)

# community membership
cl <- cluster_walktrap(g)

par(mar=c(0,0,0,0))

set.seed(101010)
plot(g, vertex.label.family='sans', vertex.label.cex=0.66, vertex.color='grey', vertex.label.color='black', vertex.size=sqrt(degree(g)) * 5)

plot(g, vertex.label.family='sans', edge.color = '#4169E166', vertex.label.cex=0.85, vertex.color=grey(0.85), vertex.label.color='black', vertex.size=sqrt(degree(g)) * 5, edge.label=x$fields, edge.label.cex=0.5, edge.label.family='sans', edge.label.color='black', layout = layout_as_star)

plot(g, vertex.label.family='sans', edge.color = 'grey', vertex.label.cex=0.85, vertex.color=membership(cl), vertex.label.color='black', vertex.size=sqrt(degree(g)) * 5, edge.label=x$fields, edge.label.cex=0.5, edge.label.family='sans', edge.label.color='black', layout = layout_as_star)





svg(filename='relationships-coded.svg', width = 12, height = 12, pointsize = 14, family = 'sans')
par(mar=c(0,0,0,0))

plot(g, vertex.label.family='sans', edge.color = 'grey', vertex.label.cex=0.85, vertex.color=membership(cl), vertex.label.color='black', vertex.size=sqrt(degree(g)) * 10, edge.label=x$fields, edge.label.cex=0.5, edge.label.family='sans', edge.label.color='black', layout = layout_as_star)

dev.off()


svg(filename='relationships.svg', width = 12, height = 12, pointsize = 14, family = 'sans')
par(mar=c(0,0,0,0))

plot(g, vertex.label.family='sans', edge.color = '#4169E166', vertex.label.cex=0.85, vertex.color=grey(0.85), vertex.label.color='black', vertex.size=sqrt(degree(g)) * 10, edge.label=x$fields, edge.label.cex=0.65, edge.label.family='sans', edge.label.color='black', layout = layout_as_star)

dev.off()


## explore simple D3 representation... not all that useful.

library(networkD3)

simpleNetwork(x, fontSize = 10, zoom=TRUE)


plot(cl, g)


ll <- igraph_to_networkD3(g, group = membership(cl))

forceNetwork(Links = ll$links, Nodes = ll$nodes, Source = 'source',
             Target = 'target', NodeID = 'name', Group = 'group',
             zoom = TRUE, linkDistance = 200, legend = TRUE,
             opacity = 0.85, opacityNoHover = TRUE, fontSize = 10)


radialNetwork(ll)


## ??
# plot(asPhylo(cl))

