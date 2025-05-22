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
local GameOver = require 'src.screens.game-over'

local menu, gameOver

function love.load()
  math.randomseed(os.time())
  LG.setFont(FONTS.NORMAL)
  LG.setBackgroundColor(1,1,1)

  menu = MainMenu()
  gameOver = GameOver()
end

function love.draw()
  if not WORLD.STORYMANAGER then
    menu:draw()
  end

  if WORLD.SCENE and GAME.STATE ~= 'gameover' then
    WORLD.SCENE:draw()
  end

  if GAME.STATE == 'gameover' then
    gameOver:draw()
  end

  DebugInfo:draw()
end

function love.update(dt)
  if not WORLD.STORYMANAGER then
    menu:update(dt)
  end

  if WORLD.SCENE and GAME.STATE ~= 'gameover' then
    WORLD.SCENE:update(dt)
  end

  if GAME.STATE == 'gameover' then
    gameOver:update(dt)
  end
end

function love.keypressed(key)
  if not WORLD.STORYMANAGER then
    menu:keypressed(key)
  end

  if GAME.STATE == 'gameover' then
    gameOver:keypressed(key)
  end

  if key == 'f9' then
    DEBUG_MODE = not DEBUG_MODE
  else
    if WORLD.SCENE and GAME.STATE ~= 'gameover' then
      WORLD.SCENE:keypressed(key)
    end
  end
end