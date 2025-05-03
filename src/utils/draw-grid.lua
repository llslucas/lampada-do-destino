local function drawGrid(gridSize)
  local width, height = LG.getDimensions()

  LG.setColor(0.8, 0.8, 0.8) -- Light gray color for the grid
  for x = 0, width, gridSize do
    LG.line(x, 0, x, height)
  end
  for y = 0, height, gridSize do
    LG.line(0, y, width, y)
  end
  LG.setColor(1, 1, 1) -- Reset color to white
end

return drawGrid