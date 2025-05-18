-- Capítulo 1 - Abertura do jogo
local GenericScene = Object:extend()
local Dialogs = require 'src.aggregate.dialogs'

function GenericScene:new()
  self.map = nil
  self.dialogs = Dialogs()
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
  self.dialogs:draw()
  if self.overlay and self.showOverlay then
    self.overlay:draw()
  end
end

function GenericScene:update(dt)
  self.waitTime = math.max(0, self.waitTime - dt)
  self.map:update(dt)
  self.dialogs:update(dt)
  self:resumeCoroutine()
end

function GenericScene:keypressed(key)
  if self.watingInput and key == 'space' then
    self.watingInput = false
  else
    self.map:keypressed(key)
    self.dialogs:keypressed(key)
  end
end

function GenericScene:keyreleased(key)
  self.map:keyreleased(key)
  self.dialogs:keyreleased(key)
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


return GenericScene
