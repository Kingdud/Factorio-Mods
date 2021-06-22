data:extend{
  {
    type = "int-setting",
    name = "smelter-ratio",
    setting_type = "startup",
    minimum_value = 25,
    maximum_value = 2000,
    default_value = 405,
    order = "b",
  },
  {
    type = "int-setting",
    name = "centrifuge-ratio",
    setting_type = "startup",
    minimum_value = 25,
    maximum_value = 2000,
    default_value = 405,
    order = "b",
  },
  {
    type = "int-setting",
    name = "smelt-max-bld-size",
    setting_type = "startup",
	minimum_value = 0,
    maximum_value = 2000,
	default_value = 25,
    order = "z",
  },
}