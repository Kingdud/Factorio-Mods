require("prototypes.constants")

data:extend{
  {type = "recipe-category", name = "bulksmelting"},
}
data:extend{
  {type = "recipe-category", name = "bulkcentrifuging"},
}

--Recipe definitions
local recipe_smelter = table.deepcopy(data.raw.recipe["electric-furnace"])
recipe_smelter.icon = nil
recipe_smelter.icons = {
	{
		icon = "__base__/graphics/icons/electric-furnace.png",
		tint = building_tint,
		icon_mipmaps = 4,
		icon_size = 64,
	}
}
recipe_smelter.ingredients =
{
	--Calculated to be the same ingredients you'd need to deploy 405 smelters in a factorissimo setup. Mostly.
    {"electric-furnace", 405},
    {"speed-module-3", 3856},
	{"productivity-module-3", 808},
	{"fast-inserter", 257},
	{"stack-inserter", 257},
    {"logistic-chest-buffer", 340}
}
recipe_smelter.result = "bulk-smelter"
recipe_smelter.name = "bulk-smelter"


local recipe_centrifuge = table.deepcopy(data.raw.recipe["centrifuge"])
recipe_centrifuge.icon = nil
recipe_centrifuge.icons = {
	{
		icon = "__base__/graphics/icons/centrifuge.png",
		tint = building_tint,
		icon_mipmaps = 4,
		icon_size = 64,
	}
}
recipe_centrifuge.ingredients =
{
	--Calculated to be the same ingredients you'd need to deploy 405 centrifuges in a factorissimo setup. Mostly.
    {"centrifuge", 405},
    {"speed-module-3", 3856},
	{"productivity-module-3", 808},
	{"stack-inserter", 514},
    {"logistic-chest-buffer", 340}
}
recipe_centrifuge.result = "bulk-centrifuge"
recipe_centrifuge.name = "bulk-centrifuge"

data:extend({recipe_smelter})
data:extend({recipe_centrifuge})

--Bulk recipes, these must be added after the above stuff.
data:extend{
	--Smelting
	{
		type = "recipe",
		icon = "__base__/graphics/icons/iron-plate.png",
		icon_mipmaps = 4,
		icon_size = 64,
		category = "bulksmelting",
		energy_required = 3.5 * ore_batching_factor,
		enabled = false,
		hide_from_player_crafting = true,
		ingredients = 
		{
			{"iron-ore", r_ore_in}
		},
		name = "bulk-iron-plate",
		--result = "iron-plate",
		--result_count = total_outputs_ore * MAX_OUTPUT_STACK_SIZE,
		results = {
			--results get filled in later
		},
		subgroup = "raw-material"
	},
	{
		type = "recipe",
		icon = "__base__/graphics/icons/copper-plate.png",
		icon_mipmaps = 4,
		icon_size = 64,
		category = "bulksmelting",
		energy_required = 3.5 * ore_batching_factor,
		enabled = false,
		ingredients = 
		{
			{"copper-ore", r_ore_in}
		},
		name = "bulk-copper-plate",
		--result = "copper-plate",
		--result_count = total_outputs_ore * MAX_OUTPUT_STACK_SIZE,
		results = {
			--results get filled in later
		},
		subgroup = "raw-material"
	},
	{
		type = "recipe",
		icon = "__base__/graphics/icons/stone-brick.png",
		icon_mipmaps = 4,
		icon_size = 64,
		category = "bulksmelting",
		energy_required = 3.5 * ore_batching_factor,
		enabled = false,
		ingredients = 
		{
			{"stone", r_ore_in}
		},
		name = "bulk-stone-brick",
		--result = "stone-brick",
		--result_count = total_outputs_ore * MAX_OUTPUT_STACK_SIZE,
		results = {
			--results get filled in later
		},
		subgroup = "raw-material"
	},
	{
		type = "recipe",
		icon = "__base__/graphics/icons/steel-plate.png",
		icon_mipmaps = 4,
		icon_size = 64,
		category = "bulksmelting",
		enabled = false,
		energy_required = 17.5 * ore_batching_factor,
		ingredients = 
		{
			{"iron-plate", r_ore_in*5}
		},
		name = "bulk-steel",
		--result = "steel-plate",
		--result_count = total_outputs_ore * MAX_OUTPUT_STACK_SIZE,
		results = {
			--results get filled in later
		},
		subgroup = "raw-material"
	},
	--Centrifuging
	{
		type = "recipe",
		category = "bulkcentrifuging",
		enabled = false,
		hide_from_player_crafting = true,
		energy_required = 10 * uranium_batching_factor,
		icon = "__base__/graphics/icons/uranium-processing.png",
		icon_mipmaps = 4,
		icon_size = 64,
		ingredients = {
			{"uranium-ore",r_uranium_in}
		},
		name = "bulk-uranium-processing",
		order = "k[uranium-processing]",
		results = {
			{ amount = r_total_uranium_output, name = "uranium-235", probability = 0.0070000000000000009 },
			{ amount = r_total_uranium_output, name = "uranium-238", probability = 0.99299999999999997	}
		},
		subgroup = "raw-material",
	},
	{
		type = "recipe",
		allow_decomposition = false,
		category = "bulkcentrifuging",
		enabled = false,
		hide_from_player_crafting = true,
		energy_required = 50 * kovarex_batching_factor,
		icon = "__base__/graphics/icons/kovarex-enrichment-process.png",
		icon_mipmaps = 4,
		icon_size = 64,
		ingredients = {
			{"uranium-235",r_u235_in},
			{"uranium-238",r_u238_in}
		},
		main_product = "",
		name = "bulk-kovarex",
		order = "r[uranium-processing]-c[kovarex-enrichment-process]",
		results = {
			--simple version, but it blocks output flow
			--{amount = r_u235_total_output * MAX_OUTPUT_STACK_SIZE,name = "uranium-235"},
			--{amount = r_u238_total_output * MAX_OUTPUT_STACK_SIZE,name = "uranium-238"}
			--Non-blocking version, requires 35 output slots.
		},
		subgroup = "intermediate-product",
	},
}

--Populate ore recipe results
local remainder = 0
for key,value in pairs({
	["bulk-iron-plate"]="iron-plate",
	["bulk-copper-plate"]="copper-plate",
	["bulk-stone-brick"]="stone-brick",
	["bulk-steel"]="steel-plate"}) do
		for i=1,math.floor(total_outputs_ore),1 do
			table.insert(data.raw.recipe[key].results,{amount = MAX_OUTPUT_STACK_SIZE,name = value})
		end
		
		remainder = (total_outputs_ore - math.floor(total_outputs_ore)) * MAX_OUTPUT_STACK_SIZE
		--this is needed to convert to an int
		remainder = math.floor(remainder)
		table.insert(data.raw.recipe[key].results,{amount = remainder,name = value})
end

--populate kovarex results
for i=1,math.floor(r_u235_total_output),1 do
	table.insert(data.raw.recipe["bulk-kovarex"].results,{amount = MAX_OUTPUT_STACK_SIZE,name = "uranium-235"})
end
remainder = (r_u235_total_output - math.floor(r_u235_total_output)) * MAX_OUTPUT_STACK_SIZE
--this is needed to convert to an int
remainder = math.floor(remainder)
table.insert(data.raw.recipe["bulk-kovarex"].results,{amount = remainder,name = "uranium-235"})

for i=1,math.floor(r_u238_total_output),1 do
	table.insert(data.raw.recipe["bulk-kovarex"].results,{amount = MAX_OUTPUT_STACK_SIZE,name = "uranium-238"})
end
remainder = (r_u238_total_output - math.floor(r_u238_total_output)) * MAX_OUTPUT_STACK_SIZE
--this is needed to convert to an int
remainder = math.floor(remainder)
table.insert(data.raw.recipe["bulk-kovarex"].results,{amount = remainder,name = "uranium-238"})

--Add above recipes to whitelist for productivity modules.
for _,recipe in pairs({"bulk-iron-plate","bulk-copper-plate","bulk-stone-brick","bulk-steel","bulk-uranium-processing","bulk-kovarex"}) do
	table.insert(data.raw.module["productivity-module"].limitation,recipe)
	table.insert(data.raw.module["productivity-module-2"].limitation,recipe)
	table.insert(data.raw.module["productivity-module-3"].limitation,recipe)
end