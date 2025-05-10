local Character = require 'src.characters.character'
local Player = Character:extend()

function Player:new()
  Player.super.new(self, LG.newImage("assets/img/characters/david-sprite.png"), IMAGE_SCALING)
  self:setId('player')
end

function Player:update(dt)
  self.super.update(self, dt)

  if love.keyboard.isDown('up') then
    self:walkUp()
  elseif love.keyboard.isDown('down') then
    self:walkDown()
  end

  if love.keyboard.isDown('left') then
    self:walkLeft()
  elseif love.keyboard.isDown('right') then
    self:walkRight()
  end

  if love.keyboard.isDown('space') then
    self:interact()
  end
end

function Player:interact()
  for _, entity in WORLD.MAP.entities:getItens() do
    local collision, direction = self:checkCollision(entity)
    if collision and self.id ~= entity.id then
      entity:interact(direction)
    end
  end
end

return Player