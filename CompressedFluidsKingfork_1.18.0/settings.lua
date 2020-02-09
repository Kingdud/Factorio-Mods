data:extend{
  {
    type = "bool-setting",
    name = "fluid-compression-singeEntity",
    setting_type = "startup",
    default_value = false,
    order = "a",
  },
  {
    type = "int-setting",
    name = "fluid-compression-rate",
    setting_type = "startup",
    minimum_value = 2,
    maximum_value = 1000,
    default_value = 100,
    order = "b",
  },
  {
    type = "int-setting",
    name = "fluid-compression-speed",
    setting_type = "startup",
    minimum_value = 1,
    maximum_value = 12000,
    default_value = 12000,
    order = "c",
  },
}
