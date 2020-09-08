require("prototypes.constants")

local SCALE_FACTOR = 5.666
--local OFFSET_SCALING_FACTOR = 1.95

local newitem = util.table.deepcopy(data.raw["mining-drill"]["electric-mining-drill"]);
newitem.name = "tfx-emd";
newitem.minable.result = "tfx-emd"
newitem.icon = nil
newitem.icons = {
	{
		icon = "__base__/graphics/icons/electric-mining-drill.png",
		tint = newTint,
		icon_mipmaps = 4,
		icon_size = 64,
	}
}
newitem.module_specification.module_info_icon_scale = SCALE_FACTOR
newitem.energy_source.emissions_per_minute = replacement_pollution_value
newitem.energy_usage = tostring(replacement_miner_power) .. "kW"
newitem.mining_speed = replacement_miner_speed
newitem.collision_box = {{ -width, -length}, {width, length}}
newitem.selection_box = {{ -width, -length}, {width, length}}
--assumes item is square
local side_length = math.ceil(width)
newitem.input_fluid_box.pipe_connections =
	{
		{ position = { -side_length, 0 } },
		{ position = { side_length, 0 } },
		{ position = { 0, side_length } },
		--this is the output vector, can't be a pipe!
		--{ position = { 0, -side_length } },		
	}
newitem.resource_searching_radius = new_resource_searching_radius
newitem.vector_to_place_result = { 0, -side_length-.11 }

--//////////////////////////////////
--All of this, just for the new graphics. Geez.
--//////////////////////////////////

--And now the mountain of animation offsets and scales. Sigh.
--Correction, yay loops!
for _,thing in pairs(newitem.graphics_set.animation) do
	--north,east,south,west
	for _,layer in pairs(thing.layers) do
		-- tmp = split(layer.filename, "/")
		-- tmp[1] = "__MiningUPSGrade__"
		-- layer.filename = table.concat(tmp,"/")
		-- layer.width = NEW_GRAPHICS[tmp[5]][1]
		-- layer.height = NEW_GRAPHICS[tmp[5]][2]
		
		-- tmp[5] = "hr-"..tmp[5]
		-- layer.hr_version.filename = table.concat(tmp,"/")
		-- layer.hr_version.width = NEW_GRAPHICS[tmp[5]][1]
		-- layer.hr_version.height = NEW_GRAPHICS[tmp[5]][2]
		
		layer.scale = SCALE_FACTOR
		layer.hr_version.scale = layer.hr_version.scale * SCALE_FACTOR
		--value.shift[1] = value.shift[1] * OFFSET_SCALING_FACTOR * SCALE_FACTOR
		--value.shift[2] = value.shift[2] * OFFSET_SCALING_FACTOR * SCALE_FACTOR
		--value.hr_version.shift[1] = value.hr_version.shift[1] * OFFSET_SCALING_FACTOR * SCALE_FACTOR
		--value.hr_version.shift[2] = value.hr_version.shift[2] * OFFSET_SCALING_FACTOR * SCALE_FACTOR
	end
end

for _,thing in pairs(newitem.integration_patch) do
	thing.scale = SCALE_FACTOR
	thing.hr_version.scale = thing.hr_version.scale * SCALE_FACTOR
end

newitem.graphics_set.working_visualisations[1].animation.scale = SCALE_FACTOR
newitem.graphics_set.working_visualisations[1].animation.hr_version.scale = 
	newitem.graphics_set.working_visualisations[1].animation.hr_version.scale * SCALE_FACTOR
newitem.graphics_set.working_visualisations[2].north_animation.layers[1].scale = SCALE_FACTOR
newitem.graphics_set.working_visualisations[2].north_animation.layers[1].hr_version.scale = 
	newitem.graphics_set.working_visualisations[2].north_animation.layers[1].hr_version.scale * SCALE_FACTOR

for _,token in pairs({"east_animation","north_animation","south_animation","west_animation"}) do
	for _,layer in pairs(newitem.graphics_set.working_visualisations[3][token].layers) do
		layer.scale = SCALE_FACTOR
		layer.hr_version.scale = layer.hr_version.scale * SCALE_FACTOR
	end
end

newitem.graphics_set.working_visualisations[4].animation.scale = SCALE_FACTOR
newitem.graphics_set.working_visualisations[4].animation.hr_version.scale = 
	newitem.graphics_set.working_visualisations[4].animation.hr_version.scale * SCALE_FACTOR

for _,token in pairs({"east_animation","south_animation","west_animation"}) do
	for _,layer in pairs(newitem.graphics_set.working_visualisations[5][token].layers) do
		layer.scale = SCALE_FACTOR
		layer.hr_version.scale = layer.hr_version.scale * SCALE_FACTOR
	end
end

for _,token in pairs({"east_animation","west_animation"}) do
	newitem.graphics_set.working_visualisations[6][token].scale = SCALE_FACTOR
	newitem.graphics_set.working_visualisations[6][token].hr_version.scale = 
		newitem.graphics_set.working_visualisations[6][token].hr_version.scale * SCALE_FACTOR
end

for _,token in pairs({"east_animation","west_animation"}) do
	newitem.graphics_set.working_visualisations[7][token].scale = SCALE_FACTOR
	newitem.graphics_set.working_visualisations[7][token].shift = {
		newitem.graphics_set.working_visualisations[7][token].shift[1] * SCALE_FACTOR,
		newitem.graphics_set.working_visualisations[7][token].shift[2] * SCALE_FACTOR}
	newitem.graphics_set.working_visualisations[7][token].hr_version.scale = 
		newitem.graphics_set.working_visualisations[7][token].hr_version.scale * SCALE_FACTOR
	newitem.graphics_set.working_visualisations[7][token].hr_version.shift = {
		newitem.graphics_set.working_visualisations[7][token].hr_version.shift[1] * SCALE_FACTOR,
		newitem.graphics_set.working_visualisations[7][token].hr_version.shift[2] * SCALE_FACTOR}
end
for _,layer in pairs(newitem.graphics_set.working_visualisations[7].south_animation.layers) do
	layer.scale = SCALE_FACTOR
	layer.shift = {
		layer.shift[1] * SCALE_FACTOR,
		layer.shift[2] * SCALE_FACTOR}
	layer.hr_version.scale = layer.hr_version.scale * SCALE_FACTOR
	layer.hr_version.shift = {
		layer.hr_version.shift[1] * SCALE_FACTOR,
		layer.hr_version.shift[2] * SCALE_FACTOR}
end

for _,token in pairs({"east_animation","north_animation","south_animation","west_animation"}) do
	newitem.graphics_set.working_visualisations[8][token].scale = SCALE_FACTOR
	newitem.graphics_set.working_visualisations[8][token].hr_version.scale = 
		newitem.graphics_set.working_visualisations[8][token].hr_version.scale * SCALE_FACTOR
end

--//////////////////////////////////
--Oh, you thought we were done with graphics? That was just for the *dry* miner. Now we have the *wet* miner too!
--//////////////////////////////////

for _,direction in pairs(newitem.wet_mining_graphics_set.animation) do
	for _,layer in pairs(direction.layers) do
		layer.scale = SCALE_FACTOR
		layer.shift = {
				layer.shift[1] * SCALE_FACTOR,
				layer.shift[2] * SCALE_FACTOR}
		layer.hr_version.scale = layer.hr_version.scale * SCALE_FACTOR
		layer.hr_version.shift = {
				layer.hr_version.shift[1] * SCALE_FACTOR,
				layer.hr_version.shift[2] * SCALE_FACTOR}
	end
end

newitem.wet_mining_graphics_set.working_visualisations[1].animation.scale = SCALE_FACTOR
newitem.wet_mining_graphics_set.working_visualisations[1].animation.shift = {
	newitem.wet_mining_graphics_set.working_visualisations[1].animation.shift[1] * SCALE_FACTOR,
	newitem.wet_mining_graphics_set.working_visualisations[1].animation.shift[2] * SCALE_FACTOR}
newitem.wet_mining_graphics_set.working_visualisations[1].animation.hr_version.scale =
	newitem.wet_mining_graphics_set.working_visualisations[1].animation.hr_version.scale * SCALE_FACTOR
newitem.wet_mining_graphics_set.working_visualisations[1].animation.hr_version.shift = {
	newitem.wet_mining_graphics_set.working_visualisations[1].animation.hr_version.shift[1] * SCALE_FACTOR,
	newitem.wet_mining_graphics_set.working_visualisations[1].animation.hr_version.shift[2] * SCALE_FACTOR}

newitem.wet_mining_graphics_set.working_visualisations[2].north_animation.layers[1].scale = SCALE_FACTOR
newitem.wet_mining_graphics_set.working_visualisations[2].north_animation.layers[1].shift = {
	newitem.wet_mining_graphics_set.working_visualisations[2].north_animation.layers[1].shift[1] * SCALE_FACTOR,
	newitem.wet_mining_graphics_set.working_visualisations[2].north_animation.layers[1].shift[2] * SCALE_FACTOR}
newitem.wet_mining_graphics_set.working_visualisations[2].north_animation.layers[1].hr_version.scale = 
	newitem.wet_mining_graphics_set.working_visualisations[2].north_animation.layers[1].hr_version.scale * SCALE_FACTOR
newitem.wet_mining_graphics_set.working_visualisations[2].north_animation.layers[1].hr_version.shift = {
	newitem.wet_mining_graphics_set.working_visualisations[2].north_animation.layers[1].hr_version.shift[1] * SCALE_FACTOR,
	newitem.wet_mining_graphics_set.working_visualisations[2].north_animation.layers[1].hr_version.shift[2] * SCALE_FACTOR}

--3 handled below

newitem.wet_mining_graphics_set.working_visualisations[4].animation.scale = SCALE_FACTOR
newitem.wet_mining_graphics_set.working_visualisations[4].animation.shift = {
	newitem.wet_mining_graphics_set.working_visualisations[4].animation.shift[1] * SCALE_FACTOR,
	newitem.wet_mining_graphics_set.working_visualisations[4].animation.shift[2] * SCALE_FACTOR}
newitem.wet_mining_graphics_set.working_visualisations[4].animation.hr_version.scale = 
	newitem.wet_mining_graphics_set.working_visualisations[4].animation.hr_version.scale * SCALE_FACTOR
newitem.wet_mining_graphics_set.working_visualisations[4].animation.hr_version.shift = {
	newitem.wet_mining_graphics_set.working_visualisations[4].animation.hr_version.shift[1] * SCALE_FACTOR,
	newitem.wet_mining_graphics_set.working_visualisations[4].animation.hr_version.shift[2] * SCALE_FACTOR}

for _,idx in pairs({5,6,7,8}) do
	for _,token in pairs({"east_animation","south_animation","west_animation"}) do
		for _,layer in pairs(newitem.wet_mining_graphics_set.working_visualisations[idx][token].layers) do
			layer.scale = SCALE_FACTOR
			layer.shift = {
				layer.shift[1] * SCALE_FACTOR,
				layer.shift[2] * SCALE_FACTOR}
			layer.hr_version.scale = layer.hr_version.scale * SCALE_FACTOR
			layer.hr_version.shift = {
				layer.hr_version.shift[1] * SCALE_FACTOR,
				layer.hr_version.shift[2] * SCALE_FACTOR}
		end
	end
end

for _,token in pairs({"east_animation","west_animation"}) do
	newitem.wet_mining_graphics_set.working_visualisations[9][token].scale = SCALE_FACTOR
	newitem.wet_mining_graphics_set.working_visualisations[9][token].shift = {
		newitem.wet_mining_graphics_set.working_visualisations[9][token].shift[1] * SCALE_FACTOR,
		newitem.wet_mining_graphics_set.working_visualisations[9][token].shift[2] * SCALE_FACTOR}
	newitem.wet_mining_graphics_set.working_visualisations[9][token].hr_version.scale =
		newitem.wet_mining_graphics_set.working_visualisations[9][token].hr_version.scale * SCALE_FACTOR
	newitem.wet_mining_graphics_set.working_visualisations[9][token].hr_version.shift = {
		newitem.wet_mining_graphics_set.working_visualisations[9][token].hr_version.shift[1] * SCALE_FACTOR,
		newitem.wet_mining_graphics_set.working_visualisations[9][token].hr_version.shift[2] * SCALE_FACTOR}
end

for _,idx in pairs({3,10,11,12,13}) do
	for _,token in pairs({"east_animation","north_animation","south_animation","west_animation"}) do
		for _,layer in pairs(newitem.wet_mining_graphics_set.working_visualisations[idx][token].layers) do
			layer.scale = SCALE_FACTOR
			layer.shift = {
				layer.shift[1] * SCALE_FACTOR,
				layer.shift[2] * SCALE_FACTOR}
			layer.hr_version.scale = layer.hr_version.scale * SCALE_FACTOR
			layer.hr_version.shift = {
				layer.hr_version.shift[1] * SCALE_FACTOR,
				layer.hr_version.shift[2] * SCALE_FACTOR}
		end
	end
end

for _,idx in pairs({14}) do
	for _,direction in pairs({"east_animation","north_animation","south_animation","west_animation"}) do
		newitem.wet_mining_graphics_set.working_visualisations[idx][direction].scale = SCALE_FACTOR
		newitem.wet_mining_graphics_set.working_visualisations[idx][direction].shift = {
			newitem.wet_mining_graphics_set.working_visualisations[idx][direction].shift[1] * SCALE_FACTOR,
			newitem.wet_mining_graphics_set.working_visualisations[idx][direction].shift[2] * SCALE_FACTOR}
		newitem.wet_mining_graphics_set.working_visualisations[idx][direction].hr_version.scale = 
			newitem.wet_mining_graphics_set.working_visualisations[idx][direction].hr_version.scale * SCALE_FACTOR
		newitem.wet_mining_graphics_set.working_visualisations[idx][direction].hr_version.shift = {
			newitem.wet_mining_graphics_set.working_visualisations[idx][direction].hr_version.shift[1] * SCALE_FACTOR,
			newitem.wet_mining_graphics_set.working_visualisations[idx][direction].hr_version.shift[2] * SCALE_FACTOR}
	end
end

data:extend({newitem})