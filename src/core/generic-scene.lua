-- Capítulo 1 - Abertura do jogo
local GenericScene = Object:extend()
local Dialogs = require 'src.aggregate.dialogs'
local SanityBar = require 'src.graphics.sanity-bar'

function GenericScene:new()
  self.map = nil
  self.dialogs = Dialogs()
  self.sanityBar = SanityBar()
  self.showSanityBar = false
  self.time = 0
  self.events = {}
  self.coroutine = nil
  self.waitingInput = false
  self.state = nil
  self.waitTime = 0
  self.overlay = nil
  self.showOverlay = false
end

function GenericScene:draw()
  self.map:draw()

  if self.showSanityBar then
    self.sanityBar:draw()
  end

  if self.overlay and self.showOverlay then
    self.overlay:draw()
  end

  self.dialogs:draw()
end

function GenericScene:update(dt)
  if GAME.STATE == 'running' then
    self.waitTime = math.max(0, self.waitTime - dt)
    self.map:update(dt)
    self.dialogs:update(dt)
    self:resumeCoroutine()
  else
    self.map.theme:stop()
  end
end

function GenericScene:keypressed(key)
  if GAME.STATE == 'running' then
    if self.watingInput and key == 'space' then
      self.watingInput = false
    else
      self.map:keypressed(key)
      self.dialogs:keypressed(key)
    end
  end
end

function GenericScene:keyreleased(key)
  if GAME.STATE == 'running' then
    self.map:keyreleased(key)
    self.dialogs:keyreleased(key)
  end
end

function GenericScene:addEvent(event)
  table.insert(self.events, event)
end

function GenericScene:clearEvents()
  self.events = {}
end

function GenericScene:makeCoroutine()
  self.coroutine = coroutine.create(
    function()
      for _, event in ipairs(self.events) do
        event()
        coroutine.yield()
      end
    end
  )
end

function GenericScene:resumeCoroutine()
  if self.coroutine and coroutine.status(self.coroutine) ~= "dead" then
    coroutine.resume(self.coroutine)
  end
end

function GenericScene:initSanityBar(player)
  self.sanityBar:setPlayer(player)
  self.showSanityBar = true
end

return GenericScene
