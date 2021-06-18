require("prototypes.constants")
require("prototypes.functions")

--This exists to test the theory of whether you need 1 input per fluid box for max flow, or if you
-- can get away with one fluidbox that has multiple inputs. This function will be used if it can flow at max.
function createOilMultipleFluidboxConnections(entity, recipe_data, side_length)
	local side_length_y = side_length + 0.5
	local side_length_x = side_length - 0.5
	
	--Pipe layout for inputs: Extreme top and bottom edge.
	entity.fluid_boxes = nil
	entity.fluid_boxes = {
		{
			base_level = -1,
			pipe_connections = {
				{
					position = {side_length_x, side_length_y},
					type = "input"
				}
			},
			production_type = "input"
		},
		{
			base_level = -1,
			pipe_connections = {
				{
					position = {-1*side_length_x, side_length_y},
					type = "input"
				}
			},
			production_type = "input"
		},
		--outputs, ordered by the recipe; heavy->light->PG. Changing this order breaks stuff.
		{
			base_level = 1,
			pipe_connections = {
				{
					position = {side_length_x, -1*side_length_y},
					type = "output"
				}
			},
			production_type = "output"
		},
		{
			base_level = 1,
			pipe_connections = {
				{
					position = {-1*side_length_x, -1*side_length_y},
					type = "output"
				}
			},
			production_type = "output"
		},
		--Heavy and light might need cracking, but PG always gets exported, so it goes in the center.
		{
			base_level = 1,
			pipe_connections = {
				{
					position = {0, -1*side_length_y},
					type = "output"
				}
			},
			production_type = "output"
		},
	}
	
	--Now that we have the basics established, adding additional connections is easy.
	for i,data in pairs(recipe_data["inputs"]) do
		--entity.fluid_boxes[i].base_area = data["connections_needed"]*(MAX_FLUID_PER_INPUT_PER_SECOND/100)
		for pipe_idx = 2,data["connections_needed"],1 do
			local previous_x = entity.fluid_boxes[i].pipe_connections[pipe_idx - 1].position[1]
			local previous_y = entity.fluid_boxes[i].pipe_connections[pipe_idx - 1].position[2]
			
			if previous_x < 0 then
				previous_x = previous_x + 2
			else
				previous_x = previous_x - 2
			end
			table.insert(entity.fluid_boxes[i].pipe_connections, { position = {previous_x, previous_y}, type = "input" })
		end
	end
	
	--output is a bit more complex because there are 3 pipes, 2 on the edges, one in the center.
	local toggle = false
	for i,data in pairs(recipe_data["outputs"]) do
		for pipe_idx = 2,data["connections_needed"],1 do
			local previous_x = entity.fluid_boxes[i+2].pipe_connections[pipe_idx - 1].position[1]
			local previous_y = entity.fluid_boxes[i+2].pipe_connections[pipe_idx - 1].position[2]
			
			if i == 3 then
				if toggle then
					previous_x = previous_x + 2*(pipe_idx-1)
					toggle = not toggle
				else
					previous_x = previous_x - 2*(pipe_idx-1)
					toggle = not toggle
				end
			else
				if previous_x < 0 then
					previous_x = previous_x + 2
				else
					previous_x = previous_x - 2
				end
			end
			table.insert(entity.fluid_boxes[i+2].pipe_connections, { position = {previous_x, previous_y}, type = "output" })
		end
	end
end

function createChemMultipleFluidboxConnections(entity, recipe_data, side_length)
	local side_length_y = side_length + 0.5
	local side_length_x = side_length - 0.5
	
	--This makes it so we can directly attach cracking ASIFs to the refinery.
	if entity.name == "lc-asif"
	then
		side_length_x = -1 * side_length_x
	end
	
	--Pipe layout for inputs: Extreme top and bottom edge.
	entity.fluid_boxes = nil
	entity.fluid_boxes = {
		{
			base_level = -1,
			pipe_connections = {
				{
					position = {side_length_x, side_length_y},
					type = "input"
				}
			},
			production_type = "input"
		},
		{
			base_level = -1,
			pipe_connections = {
				{
					position = {-1*side_length_x, side_length_y},
					type = "input"
				}
			},
			production_type = "input"
		},
		--outputs, ordered by the recipe; heavy->light->PG. Changing this order breaks stuff.
		{
			base_level = 1,
			pipe_connections = {
				{
					position = {side_length_x, -1*side_length_y},
					type = "output"
				}
			},
			production_type = "output"
		},
		{
			base_level = 1,
			pipe_connections = {
				{
					position = {-1*side_length_x, -1*side_length_y},
					type = "output"
				}
			},
			production_type = "output"
		}
	}
	
	--Now that we have the basics established, adding additional connections is easy.
	for i,data in pairs(recipe_data["inputs"]) do
		for pipe_idx = 2,data["connections_needed"],1 do
			local previous_x = entity.fluid_boxes[i].pipe_connections[pipe_idx - 1].position[1]
			local previous_y = entity.fluid_boxes[i].pipe_connections[pipe_idx - 1].position[2]
			
			if previous_x < 0 then
				previous_x = previous_x + 2
			else
				previous_x = previous_x - 2
			end
			table.insert(entity.fluid_boxes[i].pipe_connections, { position = {previous_x, previous_y}, type = "input" })
		end
	end
	
	for i,data in pairs(recipe_data["outputs"]) do
		for pipe_idx = 2,data["connections_needed"],1 do
			local previous_x = entity.fluid_boxes[i+2].pipe_connections[pipe_idx - 1].position[1]
			local previous_y = entity.fluid_boxes[i+2].pipe_connections[pipe_idx - 1].position[2]
			
			if previous_x < 0 then
				previous_x = previous_x + 2
			else
				previous_x = previous_x - 2
			end
			table.insert(entity.fluid_boxes[i+2].pipe_connections, { position = {previous_x, previous_y}, type = "output" })
		end
	end
end

--Testing was done on whether to use one fluid box per type with many inputs,
-- or one fluidbox per input. The result was ???
function createOilMultipleOilFluidBoxes(entity, recipe_data, side_length)
	local side_length_y = side_length + 0.5
	local side_length_x = side_length - 0.5
	
	--Pipe layout for inputs: Extreme top and bottom edge.
	entity.fluid_boxes = nil
	entity.fluid_boxes = {
		{
			base_level = -1,
			pipe_connections = {
				{
					position = {side_length_x, side_length_y},
					type = "input"
				}
			},
			production_type = "input",
			--You cannot change the filters without also changing the order of recipe_data.
			filter = "water"
		},
		{
			base_level = -1,
			pipe_connections = {
				{
					position = {-1*side_length_x, side_length_y},
					type = "input"
				}
			},
			production_type = "input",
			filter = "crude-oil"
		},
		--outputs, ordered by the recipe; heavy->light->PG. Changing this order breaks stuff.
		{
			base_level = 1,
			pipe_connections = {
				{
					position = {0, -1*side_length_y},
					type = "output"
				}
			},
			production_type = "output",
			filter = "heavy-oil"
		},
		{
			base_level = 1,
			pipe_connections = {
				{
					position = {-1*side_length_x, -1*side_length_y},
					type = "output"
				}
			},
			production_type = "output",
			filter = "light-oil"
		},
		{
			base_level = 1,
			pipe_connections = {
				{
					position = {side_length_x, -1*side_length_y},
					type = "output"
				}
			},
			production_type = "output",
			filter = "petroleum-gas"
		},
	}
	
	--Now that we have the basics established, adding additional connections is easy.
	for i,data in pairs(recipe_data["inputs"]) do
		local previous_x = entity.fluid_boxes[i].pipe_connections[1].position[1]
		local previous_y = entity.fluid_boxes[i].pipe_connections[1].position[2]
		for pipe_idx = 2,data["connections_needed"],1 do
			if previous_x < 0 then
				previous_x = previous_x + 2
			else
				previous_x = previous_x - 2
			end
			table.insert(entity.fluid_boxes, 
				{
					base_level = -1,
					pipe_connections = {{ position = {previous_x, previous_y}, type = "input" }},
					production_type = "input",
					filter = data["name"]
				}
			)
		end
	end
	
	--output is a bit more complex because there are 3 pipes, 2 on the edges, one in the center.
	local toggle = false
	for i,data in pairs(recipe_data["outputs"]) do
		local previous_x = entity.fluid_boxes[i+2].pipe_connections[1].position[1]
		local previous_y = entity.fluid_boxes[i+2].pipe_connections[1].position[2]
		for pipe_idx = 2,data["connections_needed"],1 do	
			if i == 1 then
				if toggle then
					previous_x = previous_x + 2*(pipe_idx-1)
					toggle = not toggle
				else
					previous_x = previous_x - 2*(pipe_idx-1)
					toggle = not toggle
				end
			else
				if previous_x < 0 then
					previous_x = previous_x + 2
				else
					previous_x = previous_x - 2
				end
			end
			table.insert(entity.fluid_boxes, 
				{
					base_level = 1,
					pipe_connections = {{ position = {previous_x, previous_y}, type = "output" }},
					production_type = "output",
					filter = data["name"]
				}
			)
		end
	end
end

--We need to know how many pipe connections, we get that from the recipe the ASIF uses.
function createOilRefEntity(name, compression_ratio, recipe_data)
	--Pollution
	--modify here if you wish to create separate entities for normal/expensive mode.
	local total_pollution_value = oil_base_pollution * (oil_per_unit_pwr_drain_penalty * (prod_mod_pollution_penalty * oil_base_modules + 1)) * compression_ratio

	local new_entity = util.table.deepcopy(base_oil_entity)
	local draw, drain = ComputePowerDrainAndDraw(compression_ratio, oil_total_pwr_draw)
	
	new_entity.fixed_recipe = name .. "-recipe"
	new_entity.name = name
	new_entity.crafting_speed = 1
	new_entity.crafting_categories = { name }
	new_entity.energy_source.emissions_per_minute = total_pollution_value
	new_entity.energy_source.drain = drain .. "kW"
	new_entity.energy_usage = draw .. "kW"
	new_entity.allowed_effects = nil
	new_entity.module_specification.module_slots = 0
	new_entity.scale_entity_info_icon = true
	--new_entity.base_productivity = .1*oil_base_modules
	new_entity.fast_replaceable_group = name
	new_entity.minable.result = name
	
	--If you tuned a chem plant with a compression_ratio of 27, then enter '27' here.
	local TUNED_SCALE_FACTOR = 63
	TUNED_SCALE_FACTOR = TUNED_SCALE_FACTOR/2
	
	local new_drawing_box_size = 0
	if (5 * compression_ratio) % 2 == 0
	then
		new_drawing_box_size = (5 * compression_ratio + 1) / 2
	else
		new_drawing_box_size = (5 * compression_ratio) / 2
	end
	local new_collison_size = new_drawing_box_size - 0.3
	local scale_factor = compression_ratio / 2
	
	local override_size = settings.startup["max-bld-size"].value
	local edge_art = nil
	if override_size ~= 0
	then
		new_drawing_box_size = override_size / 2
		new_collison_size = new_drawing_box_size - 0.3
		--This is /3 instead of /5 because the max bld sizes are all multiples of 3, 3 and 5 are both prime.
		scale_factor = override_size / 4 / 2
		
		--We want this before the scale factor gets reduced below.
		edge_art = {
			filename = "__AssemblerUPSGrade__/graphics/entity/oil-border.png",
			frame_count = new_entity.animation["north"].layers[1].frame_count,
			height = 256,
			priority = "high",
			scale = scale_factor,
			width = 256,
		}
	else		
		--We want this before the scale factor gets reduced below.
		edge_art = {
			filename = "__AssemblerUPSGrade__/graphics/entity/oil-border.png",
			frame_count = new_entity.animation["north"].layers[1].frame_count,
			height = 256,
			priority = "high",
			scale = scale_factor * 1.25,
			width = 256,
		}
	end

	--Reduce scale factor since the original art is actually too large for the entity box.
	scale_factor = scale_factor - 1
	
	for i,_ in pairs(new_entity.working_visualisations) do
		--flame
		if new_entity.working_visualisations[i].animation then
			new_entity.working_visualisations[i].animation.scale = scale_factor
			new_entity.working_visualisations[i].animation.hr_version.scale = scale_factor
			new_entity.working_visualisations[i].animation.shift[1] = new_entity.working_visualisations[i].animation.shift[1] * scale_factor
			new_entity.working_visualisations[i].animation.shift[2] = new_entity.working_visualisations[i].animation.shift[2] * scale_factor
			new_entity.working_visualisations[i].animation.hr_version.shift[1] = new_entity.working_visualisations[i].animation.hr_version.shift[1] * scale_factor
			new_entity.working_visualisations[i].animation.hr_version.shift[2] = new_entity.working_visualisations[i].animation.hr_version.shift[2] * scale_factor
			
			--Water input bottom-right
			new_entity.working_visualisations[i]["north_position"][1] = (new_entity.working_visualisations[i]["north_position"][1] + 1) * scale_factor -- + is right, - is left
			new_entity.working_visualisations[i]["north_position"][2] = (new_entity.working_visualisations[i]["north_position"][2] - 2.5) * scale_factor --+ is down, - is up
			
			--Water input bottom-left
			new_entity.working_visualisations[i]["east_position"][1] = (new_entity.working_visualisations[i]["east_position"][1] - 1.5) * scale_factor
			new_entity.working_visualisations[i]["east_position"][2] = (new_entity.working_visualisations[i]["east_position"][2] - 2.05) * scale_factor
			
			--Water input top-right
			new_entity.working_visualisations[i]["west_position"][1] = (new_entity.working_visualisations[i]["west_position"][1] + 1.75) * scale_factor
			new_entity.working_visualisations[i]["west_position"][2] = (new_entity.working_visualisations[i]["west_position"][2] - 1.75) * scale_factor
			
			--Water input top-left
			new_entity.working_visualisations[i]["south_position"][1] = (new_entity.working_visualisations[i]["south_position"][1] - 1.75) * scale_factor
			new_entity.working_visualisations[i]["south_position"][2] = (new_entity.working_visualisations[i]["south_position"][2] - 2.75) * scale_factor
		else
			--Glow at base of flame
			for _, dir in pairs({"north_animation","east_animation","west_animation","south_animation"}) do
				new_entity.working_visualisations[i][dir].scale = scale_factor
				new_entity.working_visualisations[i][dir].hr_version.scale = scale_factor
				new_entity.working_visualisations[i][dir].shift[1] = (new_entity.working_visualisations[i][dir].shift[1] - .05) * scale_factor
				new_entity.working_visualisations[i][dir].shift[2] = (new_entity.working_visualisations[i][dir].shift[2] - 1.7) * scale_factor
				new_entity.working_visualisations[i][dir].hr_version.shift[1] = (new_entity.working_visualisations[i][dir].hr_version.shift[1] - .05) * scale_factor -- + is right, - is left
				new_entity.working_visualisations[i][dir].hr_version.shift[2] = (new_entity.working_visualisations[i][dir].hr_version.shift[2] - 1.7) * scale_factor --+ is down, - is up

				--And there's always one fucking snowflake
				if dir == "west_animation"
				then
					new_entity.working_visualisations[i][dir].shift[1] = new_entity.working_visualisations[i][dir].shift[1] * 0.99
					new_entity.working_visualisations[i][dir].hr_version.shift[1] = new_entity.working_visualisations[i][dir].hr_version.shift[1] * 0.99 -- + is right, - is left
				end
			end
		end
	end
	
	new_entity.alert_icon_scale = scale_factor
	
	--Refinery itself
	for _,dir in pairs({"north","east","south","west"}) do
		for i,_ in pairs(new_entity.animation[dir].layers) do
			-- new_entity.animation[dir].layers[i].shift[1] = new_entity.animation[dir].layers[i].shift[1] * scale_factor
			new_entity.animation[dir].layers[i].shift[2] = new_entity.animation[dir].layers[i].shift[2] + (-4.5*(scale_factor/TUNED_SCALE_FACTOR))
			-- new_entity.animation[dir].layers[i].hr_version.shift[1] = new_entity.animation[dir].layers[i].hr_version.shift[1] * scale_factor
			new_entity.animation[dir].layers[i].hr_version.shift[2] = new_entity.animation[dir].layers[i].hr_version.shift[2] + (-4.5*(scale_factor/TUNED_SCALE_FACTOR))
			new_entity.animation[dir].layers[i].scale = scale_factor
			new_entity.animation[dir].layers[i].hr_version.scale = scale_factor
		end
		table.insert(new_entity.animation[dir].layers, edge_art)
	end
	
	new_entity.collision_box = { {-1*new_collison_size, -1*new_collison_size}, {new_collison_size,new_collison_size} }
	new_entity.drawing_box = { {-1*new_drawing_box_size, -1*(new_drawing_box_size+.2)}, {new_drawing_box_size,new_drawing_box_size} }
	new_entity.selection_box = { {-1*new_drawing_box_size, -1*new_drawing_box_size}, {new_drawing_box_size,new_drawing_box_size} }
	
	new_entity.icon = "__AssemblerUPSGrade__/graphics/" .. GRAPHICS_MAP[name].icon
	new_entity.icon_size = 64
	
	--Now we create the fluid boxes
	createOilMultipleFluidboxConnections(new_entity, recipe_data, new_drawing_box_size)
	--Multiple fluid boxes don't render. Only the first fluid box for a given type (whether or not 'filter' is used) renders.
	--createOilMultipleOilFluidBoxes(new_entity, recipe_data, new_drawing_box_size)
	
	data:extend({new_entity})
end

function createCrackingChemPlantEntity(name, compression_ratio, recipe_data)
	--Pollution
	--modify here if you wish to create separate entities for normal/expensive mode.
	local total_pollution_value = chem_base_pollution * (chem_per_unit_pwr_drain_penalty * (prod_mod_pollution_penalty * chem_base_modules + 1)) * compression_ratio

	local new_entity = util.table.deepcopy(base_chem_entity)
	local draw, drain = ComputePowerDrainAndDraw(compression_ratio, chem_total_pwr_draw)
	
	new_entity.fixed_recipe = name .. "-recipe"
	new_entity.name = name
	new_entity.crafting_speed = 1
	new_entity.crafting_categories = { name }
	new_entity.energy_source.emissions_per_minute = total_pollution_value
	new_entity.energy_source.drain = drain .. "kW"
	new_entity.energy_usage = draw .. "kW"
	new_entity.allowed_effects = nil
	new_entity.module_specification.module_slots = 0
	new_entity.scale_entity_info_icon = true
	--new_entity.base_productivity = .1*chem_base_modules
	new_entity.fast_replaceable_group = name
	new_entity.minable.result = name
	
		
	--If you tuned a chem plant with a compression_ratio of 27, then enter '27' here.
	local TUNED_SCALE_FACTOR = 27
	TUNED_SCALE_FACTOR = TUNED_SCALE_FACTOR/2
	
	local new_drawing_box_size = 0
	if (3 * compression_ratio) % 2 == 0
	then
		new_drawing_box_size = (3 * compression_ratio + 1) / 2
	else
		new_drawing_box_size = (3 * compression_ratio) / 2
	end
	local new_collison_size = new_drawing_box_size - 0.3
	local scale_factor = compression_ratio / 2
	
	local override_size = settings.startup["max-bld-size"].value
	if override_size ~= 0
	then
		new_drawing_box_size = override_size / 2
		new_collison_size = new_drawing_box_size - 0.3
		scale_factor = override_size / 3 / 2
	end
	
	--We want this before the scale factor gets reduced below.
	local edge_art = {
		filename = "__AssemblerUPSGrade__/graphics/entity/chem-border.png",
		frame_count = new_entity.animation["north"].layers[1].frame_count,
		line_length = 6,
		height = 256,
		priority = "high",
		scale = scale_factor * .75,
		width = 256,
	}

	--This is the smokestack color and the window color bit being scaled to the correct size.
	for i,_ in pairs(new_entity.working_visualisations) do
		--smokestack
		if new_entity.working_visualisations[i].animation then
			new_entity.working_visualisations[i].animation.scale = scale_factor
			new_entity.working_visualisations[i].animation.hr_version.scale = scale_factor
			new_entity.working_visualisations[i].animation.shift[1] = (new_entity.working_visualisations[i].animation.shift[1] + .1) * scale_factor  -- + is right, - is left
			new_entity.working_visualisations[i].animation.shift[2] = (new_entity.working_visualisations[i].animation.shift[2] + .26) * scale_factor --+ is down, - is up
			new_entity.working_visualisations[i].animation.hr_version.shift[1] = (new_entity.working_visualisations[i].animation.hr_version.shift[1] + .1) * scale_factor
			new_entity.working_visualisations[i].animation.hr_version.shift[2] = (new_entity.working_visualisations[i].animation.hr_version.shift[2] + .26) * scale_factor
			
			for _, dir in pairs({"north_position","east_position","west_position","south_position"}) do
				new_entity.working_visualisations[i][dir][1] = new_entity.working_visualisations[i][dir][1] * scale_factor * 2 - 0.5
				--For reasons that are unclear to me, the outside smoke animation needs a little extra bump north for some reason.
				if i == 3 then
					new_entity.working_visualisations[i][dir][2] = new_entity.working_visualisations[i][dir][2] * scale_factor * 2.25 - 0.5
				else
					new_entity.working_visualisations[i][dir][2] = new_entity.working_visualisations[i][dir][2] * scale_factor * 2 - 0.5
				end
			end
		else
			--Mixing window
			for _, dir in pairs({"north_animation","east_animation","west_animation","south_animation"}) do
				new_entity.working_visualisations[i][dir].scale = scale_factor
				new_entity.working_visualisations[i][dir].hr_version.scale = scale_factor
				new_entity.working_visualisations[i][dir].shift[1] = (new_entity.working_visualisations[i][dir].shift[1] + .5) * scale_factor
				new_entity.working_visualisations[i][dir].shift[2] = (new_entity.working_visualisations[i][dir].shift[2] + .4) * scale_factor
				new_entity.working_visualisations[i][dir].hr_version.shift[1] = (new_entity.working_visualisations[i][dir].hr_version.shift[1] + .5) * scale_factor
				new_entity.working_visualisations[i][dir].hr_version.shift[2] = (new_entity.working_visualisations[i][dir].hr_version.shift[2] + .4) * scale_factor
			end
		end
	end
	
	scale_factor = scale_factor * .85

	new_entity.alert_icon_scale = scale_factor
	
	for _,dir in pairs({"north","east","south","west"})
	do
		for i,_ in pairs(new_entity.animation[dir].layers)
		do
			-- new_entity.animation[dir].layers[i].shift[1] = new_entity.animation[dir].layers[i].shift[1] * scale_factor
			 new_entity.animation[dir].layers[i].shift[2] = new_entity.animation[dir].layers[i].shift[2] - (1.5*(scale_factor/TUNED_SCALE_FACTOR))
			-- new_entity.animation[dir].layers[i].hr_version.shift[1] = new_entity.animation[dir].layers[i].hr_version.shift[1] * scale_factor
			 new_entity.animation[dir].layers[i].hr_version.shift[2] = new_entity.animation[dir].layers[i].hr_version.shift[2] - (1.5*(scale_factor/TUNED_SCALE_FACTOR))
			new_entity.animation[dir].layers[i].scale = scale_factor
			new_entity.animation[dir].layers[i].hr_version.scale = scale_factor
		end
		table.insert(new_entity.animation[dir].layers, edge_art)
	end
	
	new_entity.collision_box = { {-1*new_collison_size, -1*new_collison_size}, {new_collison_size,new_collison_size} }
	new_entity.drawing_box = { {-1*new_drawing_box_size, -1*(new_drawing_box_size+.2)}, {new_drawing_box_size,new_drawing_box_size} }
	new_entity.selection_box = { {-1*new_drawing_box_size, -1*new_drawing_box_size}, {new_drawing_box_size,new_drawing_box_size} }
	
	new_entity.icon = "__AssemblerUPSGrade__/graphics/" .. GRAPHICS_MAP[name].icon
	-- new_entity.icons = {
		-- {
			-- icon = "__AssemblerUPSGrade__/graphics/" .. GRAPHICS_MAP[name].icon,
			-- icon_size = 64,
			-- tint = GRAPHICS_MAP[name].tint
		-- }
	-- }
	new_entity.icon_size = 64
	
	createChemMultipleFluidboxConnections(new_entity, recipe_data, new_drawing_box_size)
	
	data:extend({new_entity})
end