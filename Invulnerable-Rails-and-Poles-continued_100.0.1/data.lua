
--[[data:extend({

  {
    type = "selection-tool",
    name = "deprotector",
    icon = "__Invulnerable-Rails-and-Poles__/blueprint.png",
    stack_size = 1,
    subgroup = "tool",
    order = "c[automated-construction]-d[upgrade-builder]",
    flags = {"goes-to-quickbar"},
    selection_color = {r = 0.2, g = 0.8, b = 0.2, a = 0.2},
    alt_selection_color = {r = 0.2, g = 0.2, b = 0.8, a = 0.2},
    selection_mode = {"buildable-type"},
    alt_selection_mode = {"buildable-type"},
    selection_cursor_box_type = "entity",
    alt_selection_cursor_box_type = "copy"
    
  },
  {
    type = "recipe",
    name = "deprotector",
    enabled = true,
    energy_required = 0.5,
    ingredients =
    {
    },
    result = "deprotector"
  },
})


]]--

















