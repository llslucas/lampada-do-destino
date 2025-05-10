local Aggregate = require 'src.aggregate.aggregate'
local Dialogs = Aggregate:extend()

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
      WORLD.DIALOGS:next()
    end
  end
end

function Dialogs:add(object)
  Dialogs.super.add(self, object)
  self.show = true
end

function Dialogs:next()
  if self.objects[self.currentDialog].textFinished then
    self.currentDialog = self.currentDialog + 1

    if self.currentDialog > #self.objects then
      self:clear()
      self.currentDialog = 1
      self.show = false
    end
  end
end

return Dialogs
