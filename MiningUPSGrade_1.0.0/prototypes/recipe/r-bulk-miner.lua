require("prototypes.constants")

data:extend({
	{
		name = "tfx-emd",
        energy_required = 30,
        ingredients = {
			{"electric-mining-drill", miners_in_miner},
			{"beacon", r_beacons},
			{"speed-module-3", r_speed_mods},
			{"productivity-module-3", r_prod_mods},
			{"express-transport-belt", r_belts}
        },
        result = "tfx-emd",
		enabled = false,
        type = "recipe"
    }
})