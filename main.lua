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
local PauseScreen = require 'src.screens.pause-screen'
local GameOver = require 'src.screens.game-over'
local MainTheme = require 'src.sounds.bgm.main-theme'

local canvas, scale, offsetX, offsetY
local menu, gameOver, mainTheme, pauseScreen

function love.load()
  love.window.setMode(0, 0, {fullscreen = true})

  local screenWidth, screenHeight = LG.getDimensions()
  canvas = LG.newCanvas(640, 640)
  scale = math.min(screenWidth / 640, screenHeight / 640)
  offsetX = (screenWidth - 640 * scale) / 2
  offsetY = (screenHeight - 640 * scale) / 2

  math.randomseed(os.time())
  LG.setFont(FONTS.NORMAL)
  LG.setBackgroundColor(1,1,1)

  menu = MainMenu()
  gameOver = GameOver()
  mainTheme = MainTheme()
  pauseScreen = PauseScreen()
end

function love.draw()
  LG.setCanvas(canvas)
  LG.clear()

  if not WORLD.STORYMANAGER then
    menu:draw()
    mainTheme:play()
  end

  if WORLD.SCENE then
    mainTheme:stop()
    WORLD.SCENE:draw()
  end

  if GAME.STATE == 'paused' then
    pauseScreen:draw()
  end

  if GAME.STATE == 'gameover' then
    gameOver:draw()
    mainTheme:play()
  end

  DebugInfo:draw()

  LG.setCanvas()

  LG.setColor(0, 0, 0)
  LG.rectangle("fill", 0, 0, LG.getWidth(), LG.getHeight())

  LG.setColor(1, 1, 1)
  LG.draw(canvas, offsetX, offsetY, 0, scale, scale)
end

function love.update(dt)
  if not WORLD.STORYMANAGER then
    menu:update(dt)
  end

  if WORLD.SCENE then
      WORLD.SCENE:update(dt)
  end

  if GAME.STATE == 'paused' then
    pauseScreen:update(dt)
  end

  if GAME.STATE == 'gameover' then
    gameOver:update(dt)
  end
end

function love.keypressed(key)
  if not WORLD.STORYMANAGER then
    menu:keypressed(key)
  end

  if GAME.STATE == 'running' then
    if key == 'escape' then
      GAME.pause()
    end
  end

  if GAME.STATE == 'gameover' then
    gameOver:keypressed(key)
  end

  if GAME.STATE == 'paused' then
    pauseScreen:keypressed(key)
  end

  if key == 'f9' then
    DEBUG_MODE = not DEBUG_MODE
  else
    if WORLD.SCENE then
      WORLD.SCENE:keypressed(key)
    end
  end
end