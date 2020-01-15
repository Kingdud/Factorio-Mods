building_tint = {r= 1, g = .647, b = 0, a = 1}

BUILDING_SCALE = 8.33
MAX_OUTPUT_STACK_SIZE = 33

--Ore->Plate/brick section
ore_batching_factor = 1
local ore_in = 405
local plate_out = 405

r_ore_in = ore_in * ore_batching_factor
total_outputs_ore = (plate_out * ore_batching_factor) / MAX_OUTPUT_STACK_SIZE
r_output_windows_needed = math.ceil(total_outputs_ore)

--Uranium Ore section
uranium_batching_factor = 1

local ore_in = 10 * 405
local uranium_out = 405

r_uranium_in = ore_in * uranium_batching_factor
r_total_uranium_output = uranium_out * uranium_batching_factor

--Kovarex section

kovarex_batching_factor = 1

local u235_in = 40 * 405
local u238_in = 5 * 405
local u235_out = 41 * 405
local u238_out = 2 * 405

r_u235_in = u235_in * kovarex_batching_factor
r_u238_in = u238_in * kovarex_batching_factor

r_u235_total_output = (u235_out * kovarex_batching_factor) / MAX_OUTPUT_STACK_SIZE
r_u238_total_output = (u238_out * kovarex_batching_factor) / MAX_OUTPUT_STACK_SIZE