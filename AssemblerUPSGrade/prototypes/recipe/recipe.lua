require("prototypes.constants")
require("prototypes.functions")

local intermediate_beacon_cnt = math.ceil(beacon_count * .5)

data:extend({
	{
		name = "asif-assembler-block",
        energy_required = 10,
        ingredients = {
			{"beacon", intermediate_beacon_cnt},
			{"speed-module-3", intermediate_beacon_cnt * 2},
			{"productivity-module-3", assembler_base_modules},
			{"assembling-machine-3", 1},
			{"stack-inserter",2}
        },
        result = "asif-assembler-block",
		enabled = false,
        type = "recipe"
    },
	{
		name = "asif-chem-block",
        energy_required = 10,
        ingredients = {
			{"beacon", intermediate_beacon_cnt},
			{"speed-module-3", intermediate_beacon_cnt * 2},
			{"productivity-module-3", chem_base_modules},
			{"chemical-plant", 1},
			{"pipe",8},
			{"stack-inserter",2}
        },
        result = "asif-chem-block",
		enabled = false,
        type = "recipe"
    },
	{
		name = "asif-oil-block",
        energy_required = 10,
        ingredients = {
			{"beacon", 8},
			{"speed-module-3", 16},
			{"productivity-module-3", oil_base_modules},
			{"oil-refinery", 1},
			{"pipe",9},
			{"pipe-to-ground",10}
        },
        result = "asif-oil-block",
		enabled = false,
        type = "recipe"
    },
	{
		name = "asif-logi-block",
        energy_required = 1,
        ingredients = {
			{"logistic-chest-requester",1},
			{"logistic-chest-passive-provider",1}
        },
        result = "asif-logi-block",
		enabled = false,
        type = "recipe"
    },
})