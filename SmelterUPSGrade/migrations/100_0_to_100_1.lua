for _, force in pairs(game.forces) do
  local technologies = force.technologies
  local recipes = force.recipes

  recipes["centrifuge-block"].enabled = technologies["bulk-smelters"].researched
  recipes["smelter-block"].enabled = technologies["bulk-smelters"].researched
end