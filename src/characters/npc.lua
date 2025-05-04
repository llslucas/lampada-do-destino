local Character = require 'src.characters.character'
local Npc = Character:extend()

local Dialog = require 'src.graphics.dialog'

function Npc:new(spriteName, walkInterval)
  Npc.super.new(self, LG.newImage('assets/img/characters/npc/' .. spriteName .. '.png'), IMAGE_SCALING)
  self.walkInterval = walkInterval or 4
  self.walkTime = 0
  self.dialogs = {}
  self.currentDialog = 0
end

function Npc:update(dt)
  Npc.super.update(self, dt)

  self.walkTime = self.walkTime + dt
  if self.walkTime > self.walkInterval then
    self:walkStrategy()
    self.walkTime = 0
  end
end

function Npc:walkStrategy()
  --Estratégia padrão: andar aleatoriamente
  local direction = math.random(4)
  local distance = math.random(3)

  if direction == 1 then
    self:walkUp(distance)
  elseif direction == 2 then
    self:walkLeft(distance)
  elseif direction == 3 then
    self:walkDown(distance)
  elseif direction == 4 then
    self:walkRight(distance)
  end
end

function Npc:interact(direction)
  if not self.moving then
    self:turn(direction)
    self:listenDialog()
  end
end

function Npc:addDialog(text)
  table.insert(self.dialogs, Dialog('david', text))
end

function Npc:setDialogs(dialogs)
  self.dialogs = dialogs
end

function Npc:listenDialog()
  if #self.dialogs >= 1 then
    WORLD.DIALOGS:add(table.remove(self.dialogs))
    print(WORLD.DIALOGS[1])
  end
end

return Npc