local Character = require 'src.characters.character'
local Player = Character:extend()

local DavidLampada = require 'src.animations.david-lampada'

function Player:new()
  Player.super.new(self, LG.newImage("assets/img/characters/david-sprite.png"), IMAGE_SCALING)
  self:setId('player')
  self.animations = { DavidLampada() }
  self.showAnimation = false
  self.currentAnimation = 1
  self.sanity = 100
end

function Player:draw()
  if self.showAnimation then
    self.animations[self.currentAnimation]:draw()
  else
    Player.super.draw(self)
  end
end

function Player:update(dt)
  if self.showAnimation then
    self.animations[self.currentAnimation]:update(dt)
    return
  end

  self.super.update(self, dt)

  if not GAME.CUTSCENE and not self.moving then
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

  -- Enemy collision check 
  if self:checkEnemyCollision() then
    print("Colisão com inimigo detectada")

    self.sanity = self.sanity - 1
  end
end

function Player:keypressed(key)
  if not GAME.CUTSCENE then
    if key == 'space' then
      self:interact()
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

function Player:checkGlobalCollision(destinationX, destinationY)
  for _, entity in WORLD.SCENE.map.entities:getItens() do
    if self.id ~= entity.id then
      local collision = self:checkFutureCollision(entity, destinationX, destinationY)
      if collision then
        entity:collisionCallback()
        return collision
      end
    end
  end

  return self:checkFutureBorderCollision(destinationX, destinationY)
end

function Player:checkEnemyCollision()
  for _, enemy in WORLD.SCENE.map.enemies:getItens() do
    return enemy:checkCollision(self)
  end
end

function Player:playAnimation(animation)
  self.currentAnimation = animation
  self.animations[animation]:setCoordinates(self.x, self.y)
  self.showAnimation = true
end

function Player:stopAnimation()
  self.showAnimation = false
end

return Player
