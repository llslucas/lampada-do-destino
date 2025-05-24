local Character = require 'src.characters.character'
local Player = Character:extend()

local DavidLampada = require 'src.animations.david-lampada'
local DamageSound = require 'src.sounds.fx.damage-sound'

function Player:new()
  Player.super.new(self, LG.newImage("assets/img/characters/david-sprite.png"), IMAGE_SCALING)
  self:setId('player')
  self.animations = { DavidLampada() }
  self.showAnimation = false
  self.currentAnimation = 1
  self.sanity = 100
  self.damageSound = DamageSound()
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

  if not GAME.CUTSCENE and not GAME.DIALOG and not self.moving then
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
    self:setDamage(1)

    if self.sanity <= 0 then
      GAME.STATE = 'gameover'
    end
  end
end

function Player:keypressed(key)
  if not GAME.CUTSCENE and not GAME.DIALOG then
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
    if enemy:checkCollision(self) then 
      return true
    end
  end
  return false
end

function Player:playAnimation(animation)
  self.currentAnimation = animation
  self.animations[animation]:setCoordinates(self.x, self.y)
  self.showAnimation = true
end

function Player:stopAnimation()
  self.showAnimation = false
end

function Player:setDamage(damage)
  self.sanity = self.sanity - damage
  self.damageSound:play()
end

return Player
