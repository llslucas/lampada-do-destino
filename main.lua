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
local MainMenu = require 'src.screens.main-menu'

local menu

function love.load()
  math.randomseed(os.time())
  LG.setFont(FONTS.NORMAL)
  LG.setBackgroundColor(1,1,1)

  menu = MainMenu()
end

function love.draw()
  if not WORLD.STORYMANAGER then
    menu:draw()
  end

  if WORLD.SCENE then
    WORLD.SCENE:draw()
  end
  DebugInfo:draw()
end

function love.update(dt)
  if not WORLD.STORYMANAGER then
    menu:update(dt)
  end

  if WORLD.SCENE then
    WORLD.SCENE:update(dt)
  end
end

function love.keypressed(key)
  if not WORLD.STORYMANAGER then
    menu:keypressed(key)
  end

  if key == 'f9' then
    DEBUG_MODE = not DEBUG_MODE
  else
    if WORLD.SCENE then
      WORLD.SCENE:keypressed(key)
    end
  end
end