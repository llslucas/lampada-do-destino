local Entity = require 'src.core.entity'
local Paper = Entity:extend()

function Paper:new(paperImg, x, y)
  paperImg = paperImg or 'paper'
  local img = LG.newImage('assets/img/graphics/' .. paperImg .. '.png')
  Paper.super.new(self, img, IMAGE_SCALING)

  self.x = x or 0
  self.y = y or 0

  self.interactiveTexts = {}
  self.hoveredText = nil
  self.selectedText = nil
end

function Paper:draw()
  Paper.super.draw(self)

  for _, text in ipairs(self.interactiveTexts) do
    text:draw()
  end
end

function Paper:addText(text)
  table.insert(self.interactiveTexts, text)
end

function Paper:select()
  self.selectedText = self.hoveredText
end

function Paper:unselect()
  self.selectedText = nil
end

function Paper:hoverNextText()
  if not self.hoveredText then
    self.hoveredText = 1
  else
    self.interactiveTexts[self.hoveredText]:unhover()
    self.hoveredText = (self.hoveredText % #self.interactiveTexts) + 1
  end
  self.interactiveTexts[self.hoveredText]:hover()
end

function Paper:hoverPreviousText()
  if not self.hoveredText then
    self.hoveredText = 1
  else
    self.interactiveTexts[self.hoveredText]:unhover()
    self.hoveredText = self.hoveredText - 1
    if self.hoveredText == 0 then
      self.hoveredText = #self.interactiveTexts
    end
  end

  self.interactiveTexts[self.hoveredText]:hover()
end

function Paper:unhover()
  self.interactiveTexts[self.hoveredText]:unhover()
end

function Paper:getSelectedText()
  if self.selectedText then
    return self.interactiveTexts[self.selectedText]:getText()
  else
    return nil
  end
end

function Paper:replaceSelectedText(text)
  if self.selectedText then
    self.interactiveTexts[self.selectedText]:setText(text)
  else
    return nil
  end
end

return Paper