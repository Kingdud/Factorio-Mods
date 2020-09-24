require("prototypes.constants")

local intermediate_beacon_cnt = math.ceil(BEACON_COUNT * .5)

data:extend{
	{type = "recipe-category", name = "bulksmelting"},
	{type = "recipe-category", name = "bulkcentrifuging"},
	{
		name = "smelter-block",
        energy_required = 10,
        ingredients = {
			{"beacon", intermediate_beacon_cnt},
			{"speed-module-3", intermediate_beacon_cnt * 2},
			{"productivity-module-3", 2},
			{"electric-furnace", 1},
			{"fast-inserter", 1},
			{"stack-inserter", 1}
        },
        result = "smelter-block",
		enabled = false,
        type = "recipe"
    },
	{
		name = "centrifuge-block",
        energy_required = 10,
        ingredients = {
			{"beacon", intermediate_beacon_cnt},
			{"speed-module-3", intermediate_beacon_cnt * 2},
			{"productivity-module-3", 2},
			{"centrifuge", 1},
			{"stack-inserter",2}
        },
        result = "centrifuge-block",
		enabled = false,
        type = "recipe"
    },
}

function create_entity_recipe(e_type)
	local recipe
	local r_icon
	local ratio
	local block_type
	
	if e_type == "smelter" then
		recipe = table.deepcopy(data.raw.recipe["electric-furnace"])
		r_icon = "__base__/graphics/icons/electric-furnace.png"
		ratio = settings.startup["smelter-ratio"].value
		block_type = "smelter-block"
	elseif e_type == "centrifuge" then
		recipe = table.deepcopy(data.raw.recipe["centrifuge"])
		r_icon = "__base__/graphics/icons/centrifuge.png"
		ratio = settings.startup["centrifuge-ratio"].value
		block_type = "centrifuge-block"
	end
	
	--Recipe definitions
	recipe.icon = nil
	recipe.icons = {
		{
			icon = r_icon,
			tint = building_tint,
			icon_mipmaps = 4,
			icon_size = 64,
		}
	}
	
	recipe.ingredients =
	{
		{block_type, ratio},
		{"beacon", BEACON_COUNT},
		{"speed-module-3", BEACON_COUNT * 2},
		{"logistic-chest-buffer", ratio},
		{"substation", math.ceil(ratio / 6)},
	}
	
	recipe.result = "bulk-" .. e_type
	recipe.name = "bulk-" .. e_type
	
	data:extend({recipe})
end

function create_smelter_recipe(name, ore)
	local recipe = table.deepcopy(data.raw.recipe[name])

	recipe.category = "bulksmelting"
	recipe.energy_required = recipe.energy_required * ore_batching_factor
	if ore == "stone" then
		recipe.ingredients = { {ore, r_ore_in * 2} }
	else
		recipe.ingredients = { {ore, r_ore_in} }
	end
	recipe.result_count = total_outputs_ore * MAX_OUTPUT_STACK_SIZE
	
	recipe.enabled = false
	recipe.name = "bulk-" .. name
	
	data:extend({recipe})
end

function create_steel_recipe(name)
	local recipe = table.deepcopy(data.raw.recipe[name])
	
	recipe.category = "bulksmelting"
	
	recipe.normal.energy_required = recipe.normal.energy_required * ore_batching_factor
	recipe.normal.ingredients = { {"iron-plate", r_ore_in * 5} }
	recipe.normal.result_count = total_outputs_ore * MAX_OUTPUT_STACK_SIZE
	
	recipe.expensive.energy_required = recipe.expensive.energy_required * ore_batching_factor
	recipe.expensive.ingredients = { {"iron-plate", r_ore_in * 5 * 2} }
	recipe.expensive.result_count = total_outputs_ore * MAX_OUTPUT_STACK_SIZE

	recipe.enabled = false
	recipe.name = "bulk-" .. name
	
	data:extend({recipe})
end

function create_uranium_recipe(name)
	local recipe = table.deepcopy(data.raw.recipe[name])

	recipe.category = "bulkcentrifuging"
	if name == "uranium-processing" then
		recipe.energy_required = recipe.energy_required * uranium_batching_factor
		recipe.ingredients = { {"uranium-ore",r_uranium_in} }
		recipe.results = {
			{ amount = r_total_uranium_output, name = "uranium-235", probability = 0.0070000000000000009 },
			{ amount = r_total_uranium_output, name = "uranium-238", probability = 0.99299999999999997	}
		}
	else
		recipe.energy_required = recipe.energy_required * kovarex_batching_factor
		recipe.ingredients = {
			{"uranium-235",r_u235_in},
			{"uranium-238",r_u238_in}
		}
		recipe.results = {
			--simple version, but it blocks output flow
			{amount = r_u235_total_output * MAX_OUTPUT_STACK_SIZE,name = "uranium-235"},
			{amount = r_u238_total_output * MAX_OUTPUT_STACK_SIZE,name = "uranium-238"}
			--Non-blocking version, requires 35 output slots.
		}
	end

	recipe.enabled = false
	recipe.name = "bulk-" .. name
	
	data:extend({recipe})
end

--Add above recipes to whitelist for productivity modules.
for recipe,ore in pairs({["iron-plate"]="iron-ore",["copper-plate"]="copper-ore",["stone-brick"]="stone"}) do
	table.insert(data.raw.module["productivity-module"].limitation,"bulk-"..recipe)
	table.insert(data.raw.module["productivity-module-2"].limitation,"bulk-"..recipe)
	table.insert(data.raw.module["productivity-module-3"].limitation,"bulk-"..recipe)
	create_smelter_recipe(recipe, ore)
end

table.insert(data.raw.module["productivity-module"].limitation,"bulk-steel-plate")
table.insert(data.raw.module["productivity-module-2"].limitation,"bulk-steel-plate")
table.insert(data.raw.module["productivity-module-3"].limitation,"bulk-steel-plate")
create_steel_recipe("steel-plate")

for _,recipe in pairs({"uranium-processing","kovarex-enrichment-process"}) do
	table.insert(data.raw.module["productivity-module"].limitation,"bulk-"..recipe)
	table.insert(data.raw.module["productivity-module-2"].limitation,"bulk-"..recipe)
	table.insert(data.raw.module["productivity-module-3"].limitation,"bulk-"..recipe)
	create_uranium_recipe(recipe, "centrifuging")
end