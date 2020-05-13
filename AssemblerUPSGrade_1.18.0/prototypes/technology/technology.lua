-- asif=Application Specific Integrated Factory (ASIF)
-- gc-asif=Green Circuit ASIF
-- rc-asif=Red Circuit ASIF
-- bc-asif=Blue Circuit ASIF
-- lds-asif=Low Density Structure ASIF
-- eng-asif=Engines ASIF
-- spd-3-asif=Speed Module 3 ASIF
-- prod-3-asif=Productivity Module 3 ASIF

--TODO: Graphics
data:extend(
{
	{
		type = "technology",
		name = "asif",
		icon = "__base__/graphics/technology/mining-productivity.png",
		-- icons = {
			-- {
				-- icon = "__base__/graphics/technology/mining-productivity.png",
				-- tint = newTint,
				-- icon_size = 128,
			-- }
		-- },
		icon_size = 32,
		effects =
		{
			--someone less lazy than me can convert this to a for-loop so it will support other mods like Bobs/angels
			{type = "unlock-recipe", recipe = "asif-assembler-block" },
			--{type = "unlock-recipe", recipe = "asif-chem-block" },
			{type = "unlock-recipe", recipe = "asif-logi-block" },
		},
		prerequisites = {"rocket-silo"},
		unit =
		{
			count = 2500,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},		
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1}	
			},
			time = 60
		},
		order = "a-b-c"
	},
	{
		type = "technology",
		name = "gc-asif",
		icon = "__base__/graphics/technology/mining-productivity.png",
		-- icons = {
			-- {
				-- icon = "__base__/graphics/technology/mining-productivity.png",
				-- tint = newTint,
				-- icon_size = 128,
			-- }
		-- },
		icon_size = 32,
		effects =
		{
			--someone less lazy than me can convert this to a for-loop so it will support other mods like Bobs/angels
			{type = "unlock-recipe", recipe = "gc-asif" },
		},
		prerequisites = {"asif"},
		unit =
		{
			count = 25000,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},		
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1}	
			},
			time = 60
		},
		order = "a-b-c"
	},
	{
		type = "technology",
		name = "rc-asif",
		icon = "__base__/graphics/technology/mining-productivity.png",
		-- icons = {
			-- {
				-- icon = "__base__/graphics/technology/mining-productivity.png",
				-- tint = newTint,
				-- icon_size = 128,
			-- }
		-- },
		icon_size = 32,
		effects =
		{
			--someone less lazy than me can convert this to a for-loop so it will support other mods like Bobs/angels
			{type = "unlock-recipe", recipe = "rc-asif" },
		},
		prerequisites = {"gc-asif"},
		unit =
		{
			count = 250000,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},		
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1}	
			},
			time = 60
		},
		order = "a-b-c"
	},
		{
		type = "technology",
		name = "bc-asif",
		icon = "__base__/graphics/technology/mining-productivity.png",
		-- icons = {
			-- {
				-- icon = "__base__/graphics/technology/mining-productivity.png",
				-- tint = newTint,
				-- icon_size = 128,
			-- }
		-- },
		icon_size = 32,
		effects =
		{
			--someone less lazy than me can convert this to a for-loop so it will support other mods like Bobs/angels
			{type = "unlock-recipe", recipe = "bc-asif" },
		},
		prerequisites = {"rc-asif"},
		unit =
		{
			count = 1000000,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},		
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1}	
			},
			time = 60
		},
		order = "a-b-c"
	},
		{
		type = "technology",
		name = "lds-asif",
		icon = "__base__/graphics/technology/mining-productivity.png",
		-- icons = {
			-- {
				-- icon = "__base__/graphics/technology/mining-productivity.png",
				-- tint = newTint,
				-- icon_size = 128,
			-- }
		-- },
		icon_size = 32,
		effects =
		{
			--someone less lazy than me can convert this to a for-loop so it will support other mods like Bobs/angels
			{type = "unlock-recipe", recipe = "lds-asif" },
		},
		prerequisites = {"asif"},
		unit =
		{
			count = 500000,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},		
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1}	
			},
			time = 60
		},
		order = "a-b-c"
	},
		{
		type = "technology",
		name = "eng-asif",
		icon = "__base__/graphics/technology/mining-productivity.png",
		-- icons = {
			-- {
				-- icon = "__base__/graphics/technology/mining-productivity.png",
				-- tint = newTint,
				-- icon_size = 128,
			-- }
		-- },
		icon_size = 32,
		effects =
		{
			--someone less lazy than me can convert this to a for-loop so it will support other mods like Bobs/angels
			{type = "unlock-recipe", recipe = "eng-asif" },
		},
		prerequisites = {"asif"},
		unit =
		{
			count = 500000,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},		
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1}	
			},
			time = 60
		},
		order = "a-b-c"
	},
})