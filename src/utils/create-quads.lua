local function createQuads(image, columns, rows, xmargin, ymargin)
  local quads = {}
  local imageWidth, imageHeight = image:getDimensions()

  imageWidth = imageWidth
  imageHeight = imageHeight

  local width = imageWidth / columns
  local height = imageHeight / rows

  xmargin = xmargin or 0
  ymargin = ymargin or 0

  for y = 0, rows - 1 do
    for x = 0, columns - 1 do
      table.insert(
        quads,
        LG.newQuad(
          (x * width) + (x == 0 and 0 or xmargin),
          (y * height) + (y == 0 and 0 or ymargin),
          width - (x == 0 and 0 or xmargin),
          height - (y == 0 and 0 or ymargin),
          imageWidth,
          imageHeight
        )
    )
    end
  end

  return quads
end

return createQuads