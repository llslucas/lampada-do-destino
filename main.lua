-- Dependências globais
LG = love.graphics
Object = require 'lib.classic'

-- Variáveis globais
require 'src.global.fonts'
require 'src.global.game'
require 'src.global.parameters'
require 'src.global.functions'
require 'src.global.world'

-- Dependências locais
local DebugInfo = require 'src.graphics.debug-info'
local StoryManager = require 'src.chapters.storymanager'

function love.load()
  math.randomseed(os.time())
  LG.setFont(FONTS.NORMAL)
  LG.setBackgroundColor(1,1,1)

  WORLD.STORYMANAGER = StoryManager()
end

function love.draw()
  if WORLD.SCENE then
    WORLD.SCENE:draw()
  end
  DebugInfo:draw()
end

function love.update(dt)
  if WORLD.SCENE then
    WORLD.SCENE:update(dt)
  end
end

function love.keypressed(key)
  if key == 'f9' then
    DEBUG_MODE = not DEBUG_MODE
  else
    if WORLD.SCENE then
      WORLD.SCENE:keypressed(key)
    end
  end
end