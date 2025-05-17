local function createQuads(image, columns, rows, xmargin, ymargin)
  local quads = {}
  local imageWidth, imageHeight = image:getDimensions()

  imageWidth = imageWidth
  imageHeight = imageHeight

  local width = imageWidth / columns
  local height = imageHeight / rows

  xmargin = xmargin or 0
  ymargin = ymargin or 0

  for y = 1, rows do
    table.insert(quads, {})
    for x = 1, columns do
      local dx = x-1
      local dy = y-1

      table.insert(
        quads[y],
        LG.newQuad(
          (dx * width) + (dx == 0 and 0 or xmargin),
          (dy * height) + (dy == 0 and 0 or ymargin),
          width - (dx == 0 and 0 or xmargin),
          height - (dy == 0 and 0 or ymargin),
          imageWidth,
          imageHeight
        )
    )
    end
  end

  return quads
end

return createQuads