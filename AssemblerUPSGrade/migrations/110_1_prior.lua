for index, force in pairs(game.forces) do
  local technologies = force.technologies
  local recipes = force.recipes

  recipes["asif-oil-block"].enabled = technologies["asif"].researched
end