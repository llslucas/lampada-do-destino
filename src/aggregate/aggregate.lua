local Aggregate = Object:extend()

function Aggregate:new()
  self.objects = {}
end

function Aggregate:getItens()
  return ipairs(self.objects)
end

function Aggregate:clear()
  self.objects = {}
end

function Aggregate:add(object)
  table.insert(self.objects, object)
end

function Aggregate:remove(position)
  table.remove(self.objects, position)
end

function Aggregate:removeFirst()
  table.remove(self.objects)
end

function Aggregate:draw()
  for _, object in ipairs(self.objects) do
    object:draw()
    if DEBUG_MODE then 
      object:drawDebugInfo()
    end
  end
end

function Aggregate:update(dt)
  for _, object in ipairs(self.objects) do
    object:update(dt)
  end
end

return Aggregate