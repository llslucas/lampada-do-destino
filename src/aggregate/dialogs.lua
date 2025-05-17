local Aggregate = require 'src.aggregate.aggregate'
local Dialogs = Aggregate:extend()
local Dialog = require 'src.graphics.dialog-box'
local ImageBox = require 'src.graphics.image-box'

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
  end
end

function Dialogs:keypressed(key)
  if self.show then
    if key == 'space' then
        if self.objects[self.currentDialog].textFinished or self.objects[self.currentDialog]:is(ImageBox) then
          self:next()
        else
          self.objects[self.currentDialog].textSpeed = 0
        end
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

function Dialogs:addImage(photoName)
  local imageBox = ImageBox(photoName)
  self:add(imageBox)
end

function Dialogs:next()
  self.currentDialog = self.currentDialog + 1

  if self.currentDialog > #self.objects then
    self:clear()
    self.currentDialog = 1
    self.show = false
    GAME.resume()
  end
end

return Dialogs
