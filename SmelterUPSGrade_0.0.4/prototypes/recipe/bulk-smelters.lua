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
		tint = {r= 1, g = .647, b = 0, a = 1},
		icon_size = 32
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
		tint = {r= 1, g = .647, b = 0, a = 1},
		icon_size = 32
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
		icon_size = 32,
		category = "bulksmelting",
		energy_required = 3.5,
		enabled = false,
		ingredients = 
		{
			{"iron-ore", 405}
		},
		name = "bulk-iron-plate",
		--result = "iron-plate",
		--result_count = 405,
		results = {
			{type="item", name="iron-plate", amount=45},
			{type="item", name="iron-plate", amount=45},
			{type="item", name="iron-plate", amount=45},
			{type="item", name="iron-plate", amount=45},
			{type="item", name="iron-plate", amount=45},
			{type="item", name="iron-plate", amount=45},
			{type="item", name="iron-plate", amount=45},
			{type="item", name="iron-plate", amount=45},
			{type="item", name="iron-plate", amount=45}
		},
		subgroup = "raw-material"
	},
	{
		type = "recipe",
		icon = "__base__/graphics/icons/copper-plate.png",
		icon_size = 32,
		category = "bulksmelting",
		energy_required = 3.5,
		enabled = false,
		ingredients = 
		{
			{"copper-ore", 405}
		},
		name = "bulk-copper-plate",
		--result = "copper-plate",
		--result_count = 405,
		results = {
			{type="item", name="copper-plate", amount=45},
			{type="item", name="copper-plate", amount=45},
			{type="item", name="copper-plate", amount=45},
			{type="item", name="copper-plate", amount=45},
			{type="item", name="copper-plate", amount=45},
			{type="item", name="copper-plate", amount=45},
			{type="item", name="copper-plate", amount=45},
			{type="item", name="copper-plate", amount=45},
			{type="item", name="copper-plate", amount=45}
		},
		subgroup = "raw-material"
	},
	{
		type = "recipe",
		icon = "__base__/graphics/icons/stone-brick.png",
		icon_size = 32,
		category = "bulksmelting",
		energy_required = 3.5,
		enabled = false,
		ingredients = 
		{
			{"stone", 405}
		},
		name = "bulk-stone-brick",
		--result = "stone-brick",
		--result_count = 405,
		results = {
			{type="item", name="stone-brick", amount=45},
			{type="item", name="stone-brick", amount=45},
			{type="item", name="stone-brick", amount=45},
			{type="item", name="stone-brick", amount=45},
			{type="item", name="stone-brick", amount=45},
			{type="item", name="stone-brick", amount=45},
			{type="item", name="stone-brick", amount=45},
			{type="item", name="stone-brick", amount=45},
			{type="item", name="stone-brick", amount=45}
		},
		subgroup = "raw-material"
	},
	{
		type = "recipe",
		icon = "__base__/graphics/icons/steel-plate.png",
		icon_size = 32,
		category = "bulksmelting",
		enabled = false,
		energy_required = 17.5,
		ingredients = 
		{
			{"iron-plate", 2025}
		},
		name = "bulk-steel",
		--result = "steel-plate",
		--result_count = 405,
		results = {
			{type="item", name="steel-plate", amount=45},
			{type="item", name="steel-plate", amount=45},
			{type="item", name="steel-plate", amount=45},
			{type="item", name="steel-plate", amount=45},
			{type="item", name="steel-plate", amount=45},
			{type="item", name="steel-plate", amount=45},
			{type="item", name="steel-plate", amount=45},
			{type="item", name="steel-plate", amount=45},
			{type="item", name="steel-plate", amount=45}
		},
		subgroup = "raw-material"
	},
	--Centrifuging
	{
		type = "recipe",
		category = "bulkcentrifuging",
		enabled = false,
		energy_required = 10,
		icon = "__base__/graphics/icons/uranium-processing.png",
		icon_size = 32,
		ingredients = {
			{"uranium-ore",4050}
		},
		name = "bulk-uranium-processing",
		order = "k[uranium-processing]",
		results = {
			{
			  amount = 405,
			  name = "uranium-235",
			  probability = 0.0070000000000000009
			},
			{
			  amount = 405,
			  name = "uranium-238",
			  probability = 0.99299999999999997
			}
		},
		subgroup = "raw-material",
	},
	{
		type = "recipe",
		allow_decomposition = false,
		category = "bulkcentrifuging",
		enabled = false,
		energy_required = 50,
		icon = "__base__/graphics/icons/kovarex-enrichment-process.png",
		icon_size = 32,
		ingredients = {
			{"uranium-235",16200},
			{"uranium-238",2025}
		},
		main_product = "",
		name = "bulk-kovarex",
		order = "r[uranium-processing]-c[kovarex-enrichment-process]",
		results = {
			--simple version, but it blocks output flow
			--{amount = 16605,name = "uranium-235"},
			--{amount = 810,name = "uranium-238"}
			--Non-blocking version, requires 35 output slots.
			{amount = 5,name = "uranium-235"},
			{amount = 10,name = "uranium-238"},
		},
		subgroup = "intermediate-product",
	},
}

--We create stacks of 25 because a prod-module trigger creates stacks of 50, and we want the machine to keep working with 100% uptime
-- not block because it doesn't have enough output space for another stack of outputs. 32 would work, but math for 25 makes my brain
-- hurt less.
local divisor = 25

for i=1, (16600/divisor) do
	table.insert(data.raw.recipe["bulk-kovarex"].results,{amount = divisor,name = "uranium-235"})
end
for i=1, (800/divisor) do
	table.insert(data.raw.recipe["bulk-kovarex"].results,{amount = divisor,name = "uranium-238"})
end

--Add above recipes to whitelist for productivity modules.
for _,recipe in pairs({"bulk-iron-plate","bulk-copper-plate","bulk-stone-brick","bulk-steel","bulk-uranium-processing","bulk-kovarex"}) do
	table.insert(data.raw.module["productivity-module"].limitation,recipe)
	table.insert(data.raw.module["productivity-module-2"].limitation,recipe)
	table.insert(data.raw.module["productivity-module-3"].limitation,recipe)
end