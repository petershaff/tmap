data(World, Europe, metro)
metro$growth <- (metro$pop2020 - metro$pop2010) / (metro$pop2010 * 10) * 100

tm_shape(World) +
    tm_fill("grey70") +
tm_shape(metro) +
    tm_bubbles("pop2010", col = "growth", 
        border.col = "black", border.alpha = .5, 
        style="fixed", breaks=c(-Inf, seq(0, 6, by=2), Inf),
        palette="-RdYlBu", contrast=1, 
        title.size="Metro population", 
        title.col="Growth rate (%)") + 
tm_format_World()

tm_shape(metro) +
	tm_symbols(size = "pop2010", col="pop2010", shape="pop2010") +
tm_layout(legend.outside = TRUE, legend.outside.position = "bottom", legend.stack = "horizontal")

\dontrun{
require(tmaptools)
x <- sample_dots(World, vars="gdp_md_est", convert2density = TRUE, w = 100000)
tm_shape(x) + 
	tm_dots() + 
tm_layout("World GDP (one dot is 100 billon dollars)", title.position = c("right", "bottom"))
}

qtm(Europe, bbox="Italy") +
tm_shape(metro) +
	tm_markers(text="name")


if (require(ggplot2) && require(dplyr) && require(tidyr) && require(tmaptools)) {
data(NLD_prov)

origin_data <- NLD_prov@data %>% 
mutate(FID= factor(1:n())) %>% 
select(FID, origin_native, origin_west, origin_non_west) %>% 
gather(key=origin, value=perc, origin_native, origin_west, origin_non_west, factor_key=TRUE)

origin_cols <- get_brewer_pal("Dark2", 3)

grobs <- lapply(split(origin_data, origin_data$FID), function(x) {
ggplotGrob(ggplot(x, aes(x="", y=-perc, fill=origin)) +
	geom_bar(width=1, stat="identity") +
	scale_y_continuous(expand=c(0,0)) +
	scale_fill_manual(values=origin_cols) +
	theme_ps(plot.axes = FALSE))
})

names(grobs) <- NLD_prov$name

tm_shape(NLD_prov) +
tm_polygons() +
tm_symbols(size="population", shape="name", 
	shapes=grobs, 
	sizes.legend=c(.5, 1,3)*1e6, 
	scale=1, 
	legend.shape.show = FALSE, 
	legend.size.is.portrait = TRUE, 
	shapes.legend = 22, 
	title.size = "Population",
	id = "name",
	popup.vars = c("population", "origin_native",
				   "origin_west", "origin_non_west")) +
tm_add_legend(type="fill", 
	col=origin_cols, 
	labels=c("Native", "Western", "Non-western"), 
	title="Origin") +
tm_format_NLD()	
}



# TIP: check out these examples in view mode, enabled with tmap_mode("view")

\dontrun{
if (require(rnaturalearth)) {

airports <- ne_download(scale=10, type="airports")
airplane <- tmap_icons(paste0("http://cdn.mysitemyway.com/etc-mysitemyway/icons/",
	"legacy-previews/icons-256/retro-green-floral-icons-transport-travel/",
	"040553-retro-green-floral-icon-transport-travel-transportation-airplane22.png"))

tmap_mode("view")
tm_shape(airports, bbox="Germany") +
	tm_symbols(shape=airplane, size="natlscale",
		legend.size.show = FALSE, scale=2, border.col = NULL, id="name", popup.vars = TRUE)
}
}

#####################################################################################

\dontrun{
# plot all available symbol shapes:
if (require(ggplot2)) {
	ggplot(data.frame(p=c(0:25,32:127))) +
	geom_point(aes(x=p%%16, y=-(p%/%16), shape=p), size=5, fill="red") +
	geom_text(mapping=aes(x=p%%16, y=-(p%/%16+0.25), label=p), size=3) +
	scale_shape_identity() +
	theme(axis.title=element_blank(),
		  axis.text=element_blank(),
		  axis.ticks=element_blank(),
		  panel.background=element_blank())
}
}
