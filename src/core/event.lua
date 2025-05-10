local Event = Object:extend()

function Event:new(callback)
  self.callback = callback
  self.running = false
  self.finished = false
end