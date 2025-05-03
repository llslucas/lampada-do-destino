-- Dependências globais
LG = love.graphics
Object = require 'lib.classic'

-- Variáveis globais
require 'src.global.fonts'
require 'src.global.game'
require 'src.global.parameters'
require 'src.global.functions'

-- Dependências locais
local Player = require 'src.characters.player'
local drawGrid = require 'src.utils.draw-grid'

-- Variáveis locais
local player

function love.load()
  LG.setBackgroundColor(1,1,1)

  player = Player()
  player:setCoordinates(320,320) 
end

function love.draw()
  player:draw()

  drawGrid(32)
end

function love.update(dt)
  player:update(dt)
end