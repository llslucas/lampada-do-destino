local Entity = require 'src.core.entity'
local Dialog = Entity:extend()

function Dialog:new(characterName, text)
  Dialog.super.new(self, LG.newImage('assets/img/graphics/dialog-box.png'), IMAGE_SCALING)
  characterName = characterName or 'unknown'
  self.character = Entity(LG.newImage('assets/img/dialog/' .. characterName .. '.png'), IMAGE_SCALING)

  self.textTable = type(text) == "table" and text or {text}
  self.currentText = ""
  self.currentIndex = 1
  self.textSpeed = WORD_RENDERING_SPEED
  self.textTimer = 0
  self.textFinished = false

  self:setCoordinates(1, 14)
  self.character:setAbsoluteCoordinates(self.x + BORDER_DISTANCE/2, self.y + BORDER_DISTANCE/2)
end

function Dialog:draw()
  Dialog.super.draw(self)
  self.character:draw()

  if self.currentText then
    LG.setColor(0,0,0)
    LG.print(self.currentText, self.x + self.character:getWidth() + BORDER_DISTANCE, self.y + BORDER_DISTANCE)
    LG.setColor(1,1,1)
  end

  if self.textFinished then
    self:drawArrow()
  end
end

function Dialog:update(dt)
  if not self.textFinished then
    self.textTimer = self.textTimer + dt

    if self.textTimer >= self.textSpeed then
      self.textTimer = 0
      local text = self.textTable[self.currentIndex]
      if text then
        local nextChar = text:sub(#self.currentText + 1, #self.currentText + 1)

        if nextChar ~= "" then
          if nextChar and nextChar:byte() >= 0xC0 then
            nextChar = text:sub(#self.currentText + 1, #self.currentText + 2)
          end
          self:addCharacter(nextChar)
        else
          self.textFinished = true
        end
      end
    end
  end
end

function Dialog:addCharacter(char)
  self.currentText = self.currentText .. char
  local maxWidth = self:getWidth() - self.character:getWidth() - 2 * BORDER_DISTANCE

  --Adiciona quebra de linha caso ultrapasse o tamanho maximo
  if LG.getFont():getWidth(self.currentText) > maxWidth then
    local lastSpace = self.currentText:find("%s[^%s]*$")
    if lastSpace then
      self.currentText = self.currentText:sub(1, lastSpace - 1) .. "\n" .. self.currentText:sub(lastSpace + 1)
    end
  end
end

function Dialog:drawArrow()
  local arrowSize = 10
  local arrowX = self.x + self:getWidth() - BORDER_DISTANCE
  local arrowY = self.y + self:getHeight() - BORDER_DISTANCE

  LG.setColor(0, 0, 0)
  LG.polygon("fill", arrowX, arrowY, arrowX + arrowSize, arrowY, arrowX + arrowSize / 2, arrowY + arrowSize)
  LG.setColor(1, 1, 1)
end

return Dialog