-- Capítulo 1 - Abertura do jogo
local GenericScene = Object:extend()
local Dialogs = require 'src.aggregate.dialogs'

function GenericScene:new()
  self.map = nil
  self.dialogs = Dialogs()
  self.time = 0
  self.events = {}
  self.coroutine = nil
end

function GenericScene:draw()
  self.map:draw()
  self.dialogs:draw()
end

function GenericScene:update(dt)
  self.map:update(dt)
  self.dialogs:update(dt)
  self:resumeCoroutine()
end

function GenericScene:keypressed(key)
  self.map:keypressed(key)
end

function GenericScene:keyreleased(key)
  self.map:keyreleased(key)
end

function GenericScene:addEvent(event)
  table.insert(self.events, event)
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