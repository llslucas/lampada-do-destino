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
local Scene = require 'src.chapters.chapter-1.scene-1'

function love.load()
  math.randomseed(os.time())
  LG.setFont(FONTS.NORMAL)
  LG.setBackgroundColor(1,1,1)

  WORLD.SCENE = Scene()
end

function love.draw()
  WORLD.SCENE:draw()
  DebugInfo:draw()
end

function love.update(dt)
  WORLD.SCENE:update(dt)
end

function love.keypressed(key)
  if key == 'f9' then
    DEBUG_MODE = not DEBUG_MODE
  else
    WORLD.SCENE:keypressed(key)
  end
end