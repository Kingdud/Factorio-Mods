for _, force in pairs(game.forces) do
  local technologies = force.technologies
  local recipes = force.recipes

  recipes["p-flywheel-grid-battery"].enabled = technologies["flywheel-cell"].researched
end