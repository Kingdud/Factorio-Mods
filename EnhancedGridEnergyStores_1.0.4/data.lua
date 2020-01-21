--entity
require("prototypes.entity.energy-stores")

--items
require("prototypes.item.energy-stores")
require("prototypes.item.newer-satellites")

--recipies
require("prototypes.recipe.energy-stores")
require("prototypes.recipe.newer-satellites")

--tech
require("prototypes.tech.energy-stores")

--debug, allow the electric-energy-interface to charge accumulators.
--data.raw["electric-energy-interface"]["electric-energy-interface"].energy_source.usage_priority = "primary-output"