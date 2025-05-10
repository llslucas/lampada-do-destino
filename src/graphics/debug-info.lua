local DebugInfo = Object:extend()

function DebugInfo:draw()
  if DEBUG_MODE then
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
    local mem = collectgarbage("count")
    love.graphics.print(string.format("Memory: %.2f KB", mem), 10, 30)
  end
end

return DebugInfo