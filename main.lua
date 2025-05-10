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
local Escritorio = require 'src.maps.escritorio'
local DebugInfo = require 'src.graphics.debug-info'

function love.load()
  math.randomseed(os.time())
  LG.setFont(FONTS.NORMAL)
  LG.setBackgroundColor(1,1,1)

  WORLD.MAP = Escritorio()
end

function love.draw()
  WORLD.MAP:draw()
  WORLD.DIALOGS:draw()
  DebugInfo:draw()
end

function love.update(dt)
  WORLD.MAP:update(dt)
  WORLD.DIALOGS:update(dt)
end