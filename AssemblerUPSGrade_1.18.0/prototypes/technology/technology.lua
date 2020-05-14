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
		icon = "__AssemblerUPSGrade__/graphics/ASIF.png",
		icon_size = 64,
		effects =
		{
			{type = "unlock-recipe", recipe = "asif-assembler-block" },
			--{type = "unlock-recipe", recipe = "asif-chem-block" },
			{type = "unlock-recipe", recipe = "asif-logi-block" },
		},
		prerequisites = {"rocket-silo"},
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
	}
})

function addTechnology(name)
	data:extend(
	{
		{
			type = "technology",
			name = name,
			icon = "__AssemblerUPSGrade__/graphics/" .. GRAPHICS_MAP[name].icon,
			icon_size = 64,
			effects =
			{
				{type = "unlock-recipe", recipe = name },
				{type = "unlock-recipe", recipe = name .. "-recipe" },
			},
			prerequisites = TECH_DETAILS[name].prereqs,
			unit =
			{
				count = TECH_DETAILS[name].cost,
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
		}
	})
end