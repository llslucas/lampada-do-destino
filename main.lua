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

local Dialog = require 'src.graphics.dialog'

-- Variáveis locais
local player, dialog

function love.load()
  LG.setFont(FONTS.NORMAL)

  LG.setBackgroundColor(1,1,1)

  player = Player()
  player:setCoordinates(320,320)

  dialog = Dialog('david', {"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sed dolor vel velit pulvinar feugiat. Ut mauris tortor, hendrerit at scelerisque non, laoreet a justo. Vivamus sapien nibh, sagittis vitae facilisis eget."})
end

function love.draw()
  drawGrid(32)
  player:draw()
  dialog:draw()
end

function love.update(dt)
  player:update(dt)
  dialog:update(dt)
end