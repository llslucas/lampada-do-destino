local Image = require 'src.core.image'
local Character = Image:extend()

function Character:new(sprite, scale, quads)
  self.super.new(self, sprite, scale)
  self.quads = quads
end

function Character:draw()
  
end

function Character:update(dt)

end

function Character:turnUp()

end

function Character:turnDown()

end

function Character:turnLeft()

end

function Character:turnRight()

end

function Character:walkUp()

end

function Character:walkDown()

end

function Character:walkLeft()

end

function Character:walkRight()

end