data:extend({
  {
    type = "int-setting",
    name = "bulkteleport-seconds-between-checks",
    order = "aa",
    setting_type = "runtime-global",
    default_value = 1,
    minimum_value = 1,
    maximum_value = 60,
  },
  {
    type = "bool-setting",
    name = "bulkteleport-show-beam",
    order = "ab",
    setting_type = "runtime-global",
    default_value = true,
  },
  {
    type = "double-setting",
    name = "bulkteleport-show-beam-r",
    order = "aba",
    setting_type = "runtime-global",
    minimum_value = 0.0,
    maximum_value = 1.0,
    default_value = 0.6,
  },
  {
    type = "double-setting",
    name = "bulkteleport-show-beam-g",
    order = "abb",
    setting_type = "runtime-global",
    minimum_value = 0.0,
    maximum_value = 1.0,
    default_value = 0.6,
  },
  {
    type = "double-setting",
    name = "bulkteleport-show-beam-b",
    order = "abc",
    setting_type = "runtime-global",
    minimum_value = 0.0,
    maximum_value = 1.0,
    default_value = 0.6,
  },
  {
    type = "bool-setting",
    name = "bulkteleport-show-beam-pretty",
    order = "ac",
    setting_type = "runtime-global",
    default_value = false,
  },
  {
    type = "double-setting",
    name = "bulkteleport-fluid-full",
    order = "ad",
    setting_type = "runtime-global",
    default_value = 0.99,
    minimum_value = 0.1,
    maximum_value = 1.0,
  },
  {
    type = "int-setting",
    name = "bulkteleport-smalltp-energy-need",
    order = "ad",
    setting_type = "runtime-global",
    default_value = 1000,
    minimum_value = 30,
    maximum_value = 50000,
  },
  {
    type = "int-setting",
    name = "bulkteleport-bigtp-energy-need",
    order = "ad",
    setting_type = "runtime-global",
    default_value = 4000,
    minimum_value = 45,
    maximum_value = 200000,
  },
})