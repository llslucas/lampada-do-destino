local Character = require 'src.characters.character'
local Player = Character:extend()

function Player:new()
  Player.super.new(self, LG.newImage("assets/img/characters/david-sprite.png"), IMAGE_SCALING)
  self:setId('player')
end

function Player:update(dt)
  self.super.update(self, dt)
  
  if not GAME.CUTSCENE then
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
  end
end

function Player:interact()
  for _, entity in WORLD.SCENE.map.entities:getItens() do
    local collision, direction = self:checkCollision(entity)
    if collision and self.id ~= entity.id then
      entity:interact(direction)
    end
  end
end

function Player:keypressed(key)
  if not GAME.CUTSCENE then
    if key == 'space' then
      self:interact()
    end
  end
end

return Player