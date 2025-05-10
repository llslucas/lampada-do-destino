local Aggregate = require 'src.aggregate.aggregate'
local Dialogs = Aggregate:extend()
local Dialog = require 'src.graphics.dialog'

function Dialogs:new()
  Dialogs.super.new(self)
  self.currentDialog = 1
  self.show = false
end

function Dialogs:draw()
  if self.show and self.objects[self.currentDialog] then
    self.objects[self.currentDialog]:draw()
  end
end

function Dialogs:update(dt)
  if self.show and self.objects[self.currentDialog] then
    self.objects[self.currentDialog]:update(dt)
    if love.keyboard.isDown('space') then
      self:next()
    end
  end
end

function Dialogs:add(object)
  Dialogs.super.add(self, object)
  self.show = true
  GAME.pause()
end

function Dialogs:addDialog(character, text)
  local dialog = Dialog(character, text)
  self:add(dialog)
end

function Dialogs:next()
  if self.objects[self.currentDialog].textFinished then
    self.currentDialog = self.currentDialog + 1

    if self.currentDialog > #self.objects then
      self:clear()
      self.currentDialog = 1
      self.show = false
      GAME.resume()
    end
  end
end

return Dialogs
