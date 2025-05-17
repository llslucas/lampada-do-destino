local DebugInfo = Object:extend()
local drawGrid = require 'src.utils.draw-grid'

function DebugInfo:draw()
  if DEBUG_MODE then
    drawGrid(32)
    local mem = collectgarbage("count")
    love.graphics.print("FPS: " .. love.timer.getFPS() .. string.format(" - Memory: %.2f KB", mem), 10, 10)
  end
end

return DebugInfo