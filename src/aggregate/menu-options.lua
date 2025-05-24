local Aggregate = require 'src.aggregate.aggregate'
local MenuOptions = Aggregate:extend()

function MenuOptions:new()
  MenuOptions.super.new(self)
  self.activeItem = 1
end

function MenuOptions:keypressed(key)
  if key == 'down' then
    self:selectNext()
  elseif key == 'up' then
    self:selectPrevious()
  end

  self.objects[self.activeItem]:keypressed(key)
end

function MenuOptions:selectNext()
  self.objects[self.activeItem]:unhover()
  self.activeItem = (self.activeItem % #self.objects) + 1
  self.objects[self.activeItem]:hover()
end

function MenuOptions:selectPrevious()
  self.objects[self.activeItem]:unhover()
  self.activeItem = self.activeItem - 1
  self.activeItem = self.activeItem > 0 and self.activeItem or #self.objects
  self.objects[self.activeItem]:hover()
end

function MenuOptions:activate()
  self.objects[self.activeItem]:hover()
end

return MenuOptions