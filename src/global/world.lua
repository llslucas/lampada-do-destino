WORLD = {}
WORLD.ENTITIES = {}

function WORLD.clearEntities()
  WORLD.ENTITIES = {}
end

function WORLD.addEntity(entity)
  table.insert(WORLD.ENTITIES, entity)
end

function WORLD.drawEntities()
  for _, entity in ipairs(WORLD.ENTITIES) do
    entity:draw()
  end
end

function WORLD.updateEntities(dt)
  for _, entity in ipairs(WORLD.ENTITIES) do
    entity:update(dt)
  end
end