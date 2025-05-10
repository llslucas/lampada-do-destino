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
local drawGrid = require 'src.utils.draw-grid'
local Escritorio = require 'src.maps.escritorio'

-- Variáveis locais
local player

function love.load()
  math.randomseed(os.time())
  LG.setFont(FONTS.NORMAL)
  LG.setBackgroundColor(1,1,1)

  WORLD.MAP = Escritorio()
end

function love.draw()
  WORLD.MAP:draw()
  drawGrid(32)
  WORLD.MAP.entities:draw()
  WORLD.DIALOGS:draw()
end

function love.update(dt)
  if WORLD.DIALOGS.show then
    WORLD.DIALOGS:update(dt)

    if love.keyboard.isDown('space') then
      WORLD.DIALOGS:next()
    end
    return
  end

  WORLD.MAP.entities:update(dt)
end