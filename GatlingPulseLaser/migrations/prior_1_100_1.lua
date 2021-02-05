for _, force in pairs(game.forces) do
  local technologies = force.technologies
  local recipes = force.recipes

  recipes["p-pulse-laser"].enabled = technologies["pulse-laser"].researched
end