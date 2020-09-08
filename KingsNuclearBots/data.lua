require("prototypes.entity.construction-robot")
require("prototypes.entity.logistic-robot")
require("prototypes.technology.nuclear-robots")
require("prototypes.entity.death-explosion")

if settings.startup["bigger-nuclear-cell-stacks"].value == true then
	data.raw.item["uranium-fuel-cell"].stack_size = 200
end