
local function serialize(t)
	local s = {}
	for k,v in pairs(t) do
		if type(v) == "table" then
			v = serialize(v)
		end
		s[#s+1] = tostring(k).." = "..tostring(v)
	end
	return "{ "..table.concat(s, ", ").." }"
end

local function queue()
	return {first = 0, last = -1}
end

local function qlen(list)
	return math.max(0, list.last - list.first + 1)
end

local function first(list)
	return list[list.first]
end

local function last(list)
	return list[list.last]
end

local function shove (list, value)
	local first = list.first - 1
	list.first = first
	list[first] = value
end

local function push (list, value)
	local last = list.last + 1
	list.last = last
	list[last] = value
end

local function shift (list)
	local first = list.first
	if first > list.last then return nil end
	local value = list[first]
	list[first] = nil
	list.first = first + 1
	return value
end

local function pop (list)
	local last = list.last
	if list.first > last then return nil end
	local value = list[last]
	list[last] = nil
	list.last = last - 1
	return value
end

local function prefixed(str, start)
	return str:sub(1, #start) == start
end

local function suffixed(str, ending)
	return ending == "" or str:sub(-#ending) == ending
end

local function distance(a, b)
	local x = b.x - a.x
	local y = b.y - a.y
	return math.sqrt(x*x + y*y)
end

local entity_component_counterparts = {
	["bulkteleport-energizer-send1"] = "bulkteleport-buffer-send1",
	["bulkteleport-energizer-recv1"] = "bulkteleport-buffer-recv1",
	["bulkteleport-energizer-send2"] = "bulkteleport-buffer-send2",
	["bulkteleport-energizer-recv2"] = "bulkteleport-buffer-recv2",
	["bulkteleport-energizer-send3"] = "bulkteleport-buffer-send3",
	["bulkteleport-energizer-recv3"] = "bulkteleport-buffer-recv3",
	["bulkteleport-energizer-send4"] = "bulkteleport-buffer-send4",
	["bulkteleport-energizer-recv4"] = "bulkteleport-buffer-recv4",
	["bulkteleport-buffer-send1"] = "bulkteleport-energizer-send1",
	["bulkteleport-buffer-recv1"] = "bulkteleport-energizer-recv1",
	["bulkteleport-buffer-send2"] = "bulkteleport-energizer-send2",
	["bulkteleport-buffer-recv2"] = "bulkteleport-energizer-recv2",
	["bulkteleport-buffer-send3"] = "bulkteleport-energizer-send3",
	["bulkteleport-buffer-recv3"] = "bulkteleport-energizer-recv3",
	["bulkteleport-buffer-send4"] = "bulkteleport-energizer-send4",
	["bulkteleport-buffer-recv4"] = "bulkteleport-energizer-recv4",
}

local function create_component_counterpart(entity)
	return entity.surface.create_entity({
		name = entity_component_counterparts[entity.name],
		position = entity.position,
		force = entity.force,
	})
end

local entity_components = {
	["bulkteleport-send1"] = {"bulkteleport-buffer-send1", "bulkteleport-energizer-send1"},
	["bulkteleport-recv1"] = {"bulkteleport-buffer-recv1", "bulkteleport-energizer-recv1"},
	["bulkteleport-send2"] = {"bulkteleport-buffer-send2", "bulkteleport-energizer-send2"},
	["bulkteleport-recv2"] = {"bulkteleport-buffer-recv2", "bulkteleport-energizer-recv2"},
	["bulkteleport-send3"] = {"bulkteleport-buffer-send3", "bulkteleport-energizer-send3"},
	["bulkteleport-recv3"] = {"bulkteleport-buffer-recv3", "bulkteleport-energizer-recv3"},
	["bulkteleport-send4"] = {"bulkteleport-buffer-send4", "bulkteleport-energizer-send4"},
	["bulkteleport-recv4"] = {"bulkteleport-buffer-recv4", "bulkteleport-energizer-recv4"},
}

local function create_components(entity)
	local energizer = nil
	local buffer = entity.surface.create_entity({
		name = entity_components[entity.name][1],
		position = entity.position,
		force = entity.force,
	})
	if buffer then
		energizer = entity.surface.create_entity({
			name = entity_components[entity.name][2],
			position = entity.position,
			force = entity.force,
		})
		if not energizer then
			buffer.destroy()
			buffer = nil
		end
	end
	return buffer, energizer
end

local function find_component_counterpart(en)
	local list = en.surface.find_entities_filtered({
		name = entity_component_counterparts[en.name],
		area = {
			{ en.position.x-1, en.position.y-1, },
			{ en.position.x+1, en.position.y+1, },
		},
	})
	return list and list[1]
end

local entity_names = {
	"bulkteleport-energizer-send1",
	"bulkteleport-energizer-recv1",
	"bulkteleport-energizer-send2",
	"bulkteleport-energizer-recv2",
	"bulkteleport-energizer-send3",
	"bulkteleport-energizer-recv3",
	"bulkteleport-energizer-send4",
	"bulkteleport-energizer-recv4",
	"bulkteleport-buffer-send1",
	"bulkteleport-buffer-recv1",
	"bulkteleport-buffer-send2",
	"bulkteleport-buffer-recv2",
	"bulkteleport-buffer-send3",
	"bulkteleport-buffer-recv3",
	"bulkteleport-buffer-send4",
	"bulkteleport-buffer-recv4",
}

local function teleporter_at(surface, position)
	return surface.count_entities_filtered({
		name = entity_names,
		area = {
			{ position.x-1, position.y-1, },
			{ position.x+1, position.y+1, },
		},
	}) > 0
end

local function teleporter_ghost_double_up(surface, position)
	return surface.count_entities_filtered({
		ghost_name = entity_names,
		area = {
			{ position.x-1, position.y-1, },
			{ position.x+1, position.y+1, },
		},
	}) > 2
end

local entity_energizer_names = {
	"bulkteleport-energizer-send1",
	"bulkteleport-energizer-recv1",
	"bulkteleport-energizer-send2",
	"bulkteleport-energizer-recv2",
	"bulkteleport-energizer-send3",
	"bulkteleport-energizer-recv3",
	"bulkteleport-energizer-send4",
	"bulkteleport-energizer-recv4",
}

local function teleporter_ghost_energizer_at(surface, position)
	return surface.count_entities_filtered({
		ghost_name = entity_energizer_names,
		area = {
			{ position.x-1, position.y-1, },
			{ position.x+1, position.y+1, },
		},
	}) > 0
end

local entity_buffer_names = {
	"bulkteleport-buffer-send1",
	"bulkteleport-buffer-recv1",
	"bulkteleport-buffer-send2",
	"bulkteleport-buffer-recv2",
	"bulkteleport-buffer-send3",
	"bulkteleport-buffer-recv3",
	"bulkteleport-buffer-send4",
	"bulkteleport-buffer-recv4",
}

local function teleporter_ghost_buffer_at(surface, position)
	return surface.count_entities_filtered({
		ghost_name = entity_buffer_names,
		area = {
			{ position.x-1, position.y-1, },
			{ position.x+1, position.y+1, },
		},
	}) > 0
end

local function chase_away_ghosts(surface, position)
	local ghosts = surface.find_entities_filtered({
		ghost_name = entity_names,
		area = {
			{ position.x-1, position.y-1, },
			{ position.x+1, position.y+1, },
		},
	})
	for _, ghost in ipairs(ghosts) do
		if ghost.valid then
			ghost.destroy()
		end
	end
end

local function purge_state(id)
	if id then
		local state = global.entities[id]
		if state then
			for _, net in ipairs(state.networks) do
				global.networks[net][id] = nil
			end
			global.entities[id] = nil
		end
	end
end

local function OnEntityCreated(event)
	local entity = event.created_entity

	if not entity or not entity.valid then
		return
	end

	-- Due to both energizers and buffers being included in blueprints, and energizers lacking
	-- a collision box, it's possible to overlay an energizer ghost onto an existing teleporter
	-- if placing a blueprint twice. Detect and fix it.
	if entity.name == "entity-ghost"
		and entity.ghost_name
		and prefixed(entity.ghost_name, "bulkteleport-")
	then

		if teleporter_at(entity.surface, entity.position) then
			chase_away_ghosts(entity.surface, entity.position)
			return
		end

		if teleporter_ghost_double_up(entity.surface, entity.position) then
			entity.destroy()
			return
		end

		local e = teleporter_ghost_energizer_at(entity.surface, entity.position)
		local b = teleporter_ghost_buffer_at(entity.surface, entity.position)

		if not (e and b) and not event.item then
			game.print("Broken teleporter blueprint! Include both materializer and buffer entities.")
			entity.destroy()
			return
		end
	end

	if not prefixed(entity.name, "bulkteleport-") then
		return
	end

	-- placed from item
	if prefixed(entity.name, "bulkteleport-send") or prefixed(entity.name, "bulkteleport-recv") then
		chase_away_ghosts(entity.surface, entity.position)

		local buffer, energizer = create_components(entity)

		if buffer and energizer then
			global.entities[buffer.unit_number] = {
				entity = buffer,
				energizer = energizer,
				networks = {},
			}
			push(global.queue, buffer.unit_number)
		else
			game.print("Placing a teleporter failed. Please report a bug if you can reproduce it!")
		end

		entity.destroy()
		return
	end

	-- placed from blueprint
	if prefixed(entity.name, "bulkteleport-buffer-send") or prefixed(entity.name, "bulkteleport-buffer-recv") then
		chase_away_ghosts(entity.surface, entity.position)

		local buffer = entity
		local energizer = create_component_counterpart(buffer)

		if energizer then
			global.entities[buffer.unit_number] = {
				entity = buffer,
				energizer = energizer,
				networks = {},
			}
			push(global.queue, buffer.unit_number)
		else
			buffer.destroy()
			game.print("Placing a teleporter from a blueprint failed. Please report a bug if you can reproduce it!")
		end
		return
	end
end

local function OnEntityRemoved(event)
	local entity = event.entity

	if not entity or not entity.valid then
		return
	end

	if prefixed(entity.name, "bulkteleport-") then
		purge_state(entity.unit_number)
		local counterpart = find_component_counterpart(entity)
		if entity.health >= 1 and counterpart and counterpart.valid then
			counterpart.destroy()
		end
		return
	end

	if entity.name == "entity-ghost"
		and entity.ghost_name
		and prefixed(entity.ghost_name, "bulkteleport-")
	then
		chase_away_ghosts(entity.surface, entity.position)
		return
	end
end

local function OnEntityDamaged(event)

	local entity = event.entity

	if not entity or not entity.valid then
		return
	end

	if prefixed(entity.name, "bulkteleport-") then
		local counterpart = find_component_counterpart(entity)
		if counterpart and counterpart.valid then
			if entity.health < 1 then
				entity.die(event.force)
				if counterpart.valid then -- required as above die() could destroy() in event handler
					counterpart.die(event.force)
				end
				return
			end
			local health = math.min(entity.health, counterpart.health)
			entity.health = health
			counterpart.health = health
		end
		return
	end
end

local signal_ops = {
	["signal-red"] = function(state, name, count)
		state.red = true
	end,
	["signal-green"] = function(state, name, count)
		state.green = true
	end,
	["signal-blue"] = function(state, name, count)
		state.priority = true
	end,
}

local signal_default = function(state, name, count)
	local id = state.entity.unit_number
	local gnets = global.networks
	local snets = state.networks

	local net = name.."-"..count
	snets[#snets+1] = net
	gnets[net] = gnets[net] or {}
	gnets[net][id] = true
end

local function check_networks(state)
	local id = state.entity.unit_number
	local gnets = global.networks
	local snets = state.networks

	for _, net in ipairs(snets) do
		gnets[net][id] = nil
	end

	for i = 1,#snets,1 do
		snets[i] = nil
	end

	state.green = nil
	state.red = nil
	state.priority = nil

	local signals = state.entity.get_merged_signals()
	if signals ~= nil then
		for _, v in ipairs(signals) do
			if v.signal.type == "virtual" and v.signal.name ~= nil then
				(signal_ops[v.signal.name] or signal_default)(state, v.signal.name, v.count)
			end
		end
	end
end

local fluidic_entity_names = {
	["bulkteleport-energizer-send3"] = true,
	["bulkteleport-energizer-recv3"] = true,
	["bulkteleport-energizer-send4"] = true,
	["bulkteleport-energizer-recv4"] = true,
	["bulkteleport-buffer-send3"] = true,
	["bulkteleport-buffer-recv3"] = true,
	["bulkteleport-buffer-send4"] = true,
	["bulkteleport-buffer-recv4"] = true,
}

local function is_fluidic(entity)
	return fluidic_entity_names[entity.name] or false
end

local function inventory_counts(inventory)
	local blocked_slots = #inventory - (inventory.get_bar() or #inventory)
	local free_slots = inventory.insert({ name = "bulkteleport-job-1-1", count = #inventory })

	if free_slots > 0 then
		inventory.remove({ name = "bulkteleport-job-1-1", count = free_slots })
	end

	return #inventory, blocked_slots, free_slots
end

local function free_space(entity)
	if is_fluidic(entity) then
		local capacity = entity.prototype.fluid_capacity
		return (capacity-entity.get_fluid_count()) / capacity
	end
	local total, blocked, free = inventory_counts(entity.get_inventory(defines.inventory.chest))
	return free / total
end

-- For fluid teleporters this is just 1-free_space()
-- But for item teleporters with optionally limited inventories (red bar)
-- the blocked-off slots need to be taken into account.
local function used_space(entity)
	if is_fluidic(entity) then
		local capacity = entity.prototype.fluid_capacity
		return entity.get_fluid_count() / capacity
	end
	local total, blocked, free = inventory_counts(entity.get_inventory(defines.inventory.chest))
	return (total - free - blocked - 1) / total
end

local function is_empty(entity)
	if is_fluidic(entity) then
		return entity.get_fluid_count() < 1
	end
	return entity.get_inventory(defines.inventory.chest).is_empty()
end

local function is_full(entity)
	if is_fluidic(entity) then
		local full = (settings.global["bulkteleport-fluid-full"].value or 0.999)
		return entity.get_fluid_count() >= (entity.prototype.fluid_capacity * full)
	end
	local inventory = entity.get_inventory(defines.inventory.chest)
	return not inventory.can_insert({ name = "bulkteleport-job-1-1", count = 1 })
end

local function find_target(state)

	local id = state.entity.unit_number
	local name = "bulkteleport-buffer-recv" .. state.entity.name:sub(-1)
	local ballpark = used_space(state.entity) * 0.75

	local selected = nil
	local priority = nil
	local found = 0
	local busy = 0

	local function emptiest(stateA, stateB)
		return free_space(stateA.entity) > free_space(stateB.entity) and stateA or stateB
	end

	for _, net in ipairs(state.networks) do
		for tid, _ in pairs(global.networks[net]) do

			local target = global.entities[tid]
			local tEntity = target.entity
			local tEnergizer = target.energizer

			if target and tEntity.valid
				and target.is_target
				and tEntity.name == name
				and tEntity.surface == state.entity.surface
				and not tEntity.to_be_deconstructed(tEntity.force)
			then
				found = found + 1

				if not tEnergizer.is_crafting()
					and tEnergizer.energy > 0
					and not target.shipment
					and not target.red
					and free_space(tEntity) >= ballpark
				then

					selected = selected and emptiest(target, selected) or target

					if target.priority then
						priority = priority and emptiest(target, priority) or target
					end

				else
					busy = busy + 1
				end
			end
		end
	end

	return priority or selected, found, busy
end

local function notify(state, msg)

	if state.notify_msg == msg
		and (state.notify_tick or 0) > game.tick - 60*5
	then
		return
	end

	if (state.notify_tick or 0) > game.tick - 60 then
		return
	end

	state.notify_msg = msg
	state.notify_tick = game.tick

	state.entity.surface.create_entity({
		name = "flying-text",
		position = state.entity.position,
		color = {r=1,g=1,b=1},
		text = msg,
	})
end

local function warning(state, msg)

	if state.warning_msg == msg
		and (state.warning_tick or 0) > game.tick - 60*5
	then
		return
	end

	if (state.warning_tick or 0) > game.tick - 60 then
		return
	end

	state.warning_msg = msg
	state.warning_tick = game.tick

	state.entity.surface.create_entity({
		name = "flying-text",
		position = state.entity.position,
		color = {r=1,g=0.6,b=0.6},
		text = msg,
	})
end

local function beam_color(surface)
	local d = surface.darkness/3
	local r = settings.global["bulkteleport-show-beam-r"].value
	local g = settings.global["bulkteleport-show-beam-g"].value
	local b = settings.global["bulkteleport-show-beam-b"].value
	return { r = math.min(1.0, math.max(0.0, r-d)), g = math.min(1.0, math.max(0.0, g-d)), b = math.min(1.0, math.max(0.0, b-d)) }
end

local function OnNthTick(event)

	local q = global.queue
	local qp = global.paused

	-- The paused queue does not really reduce mod load, it just makes the main
	-- queue shorter so that active teleporters are more responsive.
	if qlen(qp) > 0 and first(qp) < game.tick - 300 then
		shift(qp)
		push(q, shift(qp))
	end

	local id = shift(q)
	local state = global.entities[id]

	if id and state and state.entity.valid and state.energizer and state.energizer.valid then

		if not state.energizer.is_crafting() and state.energizer.energy > 0 and not state.entity.to_be_deconstructed(state.entity.force) then
			check_networks(state)

			if #state.networks == 0 then
				warning(state, "no network...")

			elseif state.is_source or prefixed(state.entity.name, "bulkteleport-buffer-send") then
				local source = state
				source.is_source = true

				local empty = is_empty(source.entity)
				local full = not empty and is_full(source.entity)
				local shipment = not source.red and not empty and (full or source.green)

				if shipment then
					local target, found, busy = find_target(source)

					if target then

						local range = distance(source.entity.position, target.entity.position)
						local cost = math.min(10, math.ceil(range/1000))

						-- in theory the same
						local s_recipe = "bulkteleport-job-"..cost.."-"..source.entity.name:sub(-1)
						local t_recipe = "bulkteleport-job-"..cost.."-"..target.entity.name:sub(-1)

						source.energizer.insert({ name = s_recipe })
						target.energizer.insert({ name = t_recipe })

						if settings.global["bulkteleport-show-beam"].value then

							local s_duration = game.recipe_prototypes[s_recipe].energy / source.energizer.crafting_speed
							local t_duration = game.recipe_prototypes[t_recipe].energy / target.energizer.crafting_speed
							local duration = math.min(s_duration, t_duration)

							local s_position = { source.energizer.position.x, source.energizer.position.y - 1 }
							local t_position = { target.energizer.position.x, target.energizer.position.y - 1 }

							if settings.global["bulkteleport-show-beam-pretty"].value then
								-- slower
								source.energizer.surface.create_entity({
									name = "electric-beam",
									position = s_position,
									source_position = s_position,
									target_position = t_position,
									duration = math.ceil(duration*60),
								})
							else
								-- faster
								rendering.draw_line({
									color = beam_color(source.energizer.surface),
									width = 2,
									gap_length = 0.5,
									dash_length = 0.5,
									from = s_position,
									to = t_position,
									surface = source.energizer.surface,
									forces = { source.energizer.force },
									time_to_live = math.ceil(duration*60),
								})
							end
						end

						if is_fluidic(source.entity) then
							target.shipment = source.entity.get_fluid_contents()
							target.temperature = source.entity.fluidbox[1].temperature
							source.entity.clear_fluid_inside()
						else
							local inventory = source.entity.get_inventory(defines.inventory.chest)
							target.shipment = inventory.get_contents()
							inventory.clear()
						end

						notify(source, string.format("%dm (%d)", range, cost))
						notify(target, string.format("%dm (%d)", range, cost))

					elseif found == 0 then
						warning(source, "no target...")
					end
				end

			elseif state.is_target or prefixed(state.entity.name, "bulkteleport-buffer-recv") then
				local target = state
				target.is_target = true

				local energizer = target.energizer

				-- shipment arrived; try to export
				if not energizer.is_crafting() and target.shipment then

					if is_fluidic(target.entity) then

						if is_empty(target.entity) then
							target.entity.clear_fluid_inside()
						end

						local overflow = {}
						local retry = false

						for name, count in pairs(target.shipment) do
							if game.fluid_prototypes[name] then
								local inserted = target.entity.insert_fluid({
									name = name,
									amount = count,
									temperature = target.temperature
								})
								if count-inserted > 1 then
									retry = true
									overflow[name] = count-inserted
								end
							end
						end
						if retry then
							target.shipment = overflow
						else
							target.shipment = nil
							target.temperature = nil
						end

					else

						local overflow = {}
						local retry = false
						local inventory = target.entity.get_inventory(defines.inventory.chest)

						for name, count in pairs(target.shipment) do
							if game.item_prototypes[name] then
								local inserted = inventory.insert({
									name = name,
									count = count
								})
								if inserted < count then
									retry = true
									overflow[name] = count-inserted
								end
							end
						end
						if retry then
							target.shipment = overflow
						else
							target.shipment = nil
						end
					end
				end
			end

			push(qp, game.tick)
			push(qp, id)

		else
			push(q, id)

		end

	else
		purge_state(id)
	end
end

local function check_state()
	global.queue = global.queue or queue()
	global.paused = global.paused or queue()
	global.entities = global.entities or {}
	global.networks = global.networks or {}
end

local function set_tick_handler()
	script.on_nth_tick(nil)
	script.on_nth_tick(math.ceil(60/math.min(60, settings.global["bulkteleport-checks-per-second"].value)), OnNthTick)
end

local function OnSettingChanged()
	check_state()
	set_tick_handler()
end

--local function OnGuiOpened(event)
--	if event.gui_type == defines.gui_type.entity
--		and event.entity and prefixed(event.entity.name, "bulkteleport-buffer-")
--	then
--		game.print(serialize(game.players[event.player_index].gui.center.children))
--	end
--end

script.on_configuration_changed(function(delta)
	check_state()
	set_tick_handler()
end)

script.on_init(function()
	check_state()
	set_tick_handler()
	script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity}, OnEntityCreated)
	script.on_event({defines.events.on_player_mined_entity, defines.events.on_robot_mined_entity, defines.events.on_entity_died}, OnEntityRemoved)
	script.on_event({defines.events.on_entity_damaged}, OnEntityDamaged)
	script.on_event({defines.events.on_runtime_mod_setting_changed}, OnSettingChanged)
--	script.on_event({defines.events.on_gui_opened}, OnGuiOpened)
end)

script.on_load(function()
	set_tick_handler()
	script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity}, OnEntityCreated)
	script.on_event({defines.events.on_player_mined_entity, defines.events.on_robot_mined_entity, defines.events.on_entity_died}, OnEntityRemoved)
	script.on_event({defines.events.on_entity_damaged}, OnEntityDamaged)
	script.on_event({defines.events.on_runtime_mod_setting_changed}, OnSettingChanged)
--	script.on_event({defines.events.on_gui_opened}, OnGuiOpened)
end)
