local Aggregate = Object:extend()

function Aggregate:new()
  self.objects = {}
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

function Aggregate:keypressed(key)
  for _, object in ipairs(self.objects) do
    object:keypressed(key)
  end
end

function Aggregate:getItens()
  return ipairs(self.objects)
end

function Aggregate:getItemById(id)
  for _, object in ipairs(self.objects) do
    if object.id == id then
      return object
    end
  end
  return nil
end

function Aggregate:getAllItensById(id)
  local itens = {}
  for _, object in ipairs(self.objects) do
    if object.id == id then
      table.insert(itens, object)
    end
  end
  return itens
end

function Aggregate:clear()
  self.objects = {}
end

function Aggregate:add(...)
  for _, object in ipairs({...}) do
    table.insert(self.objects, object)
  end
end

function Aggregate:remove(entity)
  for i, object in ipairs(self.objects) do
    if object.id == entity.id then
      table.remove(self.objects, i)
      return
    end
  end
end

function Aggregate:removeFirst()
  table.remove(self.objects)
end

return Aggregate