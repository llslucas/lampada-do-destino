-- Capítulo 1 - Prólogo
-- Cena 2 - Mensagem escondida

local GenericScene = require 'src.core.generic-scene'
local Scene = GenericScene:extend()

local Escritorio = require 'src.maps.escritorio'
local Player = require 'src.characters.player'
local Paper = require 'src.graphics.paper'
local InteractiveText = require 'src.graphics.interactive-text'
local NisusOverlay = require 'src.graphics.nisus-overlay'

local player, armarioAdam, paper1, paper2

function Scene:new(map)
  --Scene setup
  Scene.super.new(self)

  self.waitingCorrectText = false

  if map then
    self.map = map
    player = self.map.entities:getItemById('player')
  else
    self.map = Escritorio()

    player = Player()
    player:setCoordinates(2, 14)
    player:turn('up')

    self.map.entities:add(player)

    armarioAdam = self.map.entities:getItemById('armario-adam')
    armarioAdam:interact()
  end

  paper1 = Paper('papel-mensagem-1')
  paper1:setCoordinates(2, 2)

  paper1:addText(InteractiveText('*passeios.', 102, 192))
  paper1:addText(InteractiveText('*dar um passeio no navio.', 102, 262))
  paper1:addText(InteractiveText('*cordiais e dispostos,\ntambém passeiam no Nisus.', 102, 310))
  paper1:addText(InteractiveText('*Obrigado por tudo.', 102, 397))

  paper2 = Paper('papel-mensagem-2')
  paper2:setCoordinates(11, 2)

  paper2:addText(InteractiveText('*esconder tudo.', 391, 203))
  paper2:addText(InteractiveText('*estar em perigo.', 391, 271))
  paper2:addText(InteractiveText('*não confie neles.', 391, 339))
  paper2:addText(InteractiveText('*POR FAVOR FUJA', 391, 408))

  self:addEvent(function()
    self.map.entities:add(paper1)
    WORLD.SCENE.watingInput = true
  end)

  self:addEvent(function()
    WORLD.SCENE.dialogs:addDialog('david', 'Uma mensagem do Adam...')
  end)

  self:addEvent(function()
    self.map.entities:add(paper2)
    WORLD.SCENE.watingInput = true
  end)

  self:addEvent(function()
    WORLD.SCENE.dialogs:addDialog('david', 'Este texto nao faz o menor sentido...')
    WORLD.SCENE.dialogs:addDialog('david',
      'Sao textos completamente diferentes, mas ambos possuem palavras marcadas, porque sera?')
  end)

  --Palavra 1

  self:addEvent(function()
    WORLD.SCENE.state = 'paper1'
    paper1:hoverNextText()
    WORLD.SCENE.waitingCorrectText = true
  end)

  self:addEvent(function()
    WORLD.SCENE.state = 'paper2'
    paper2:hoverNextText()
    WORLD.SCENE.waitingCorrectText = true
  end)

  self:addEvent(function()
    paper1:replaceSelectedText(paper2:getSelectedText())
    paper2:unhover()
    WORLD.SCENE.dialogs:addDialog('david-susto', 'Os papeis estao relacionados!')
  end)

  --Palavra 2

  self:addEvent(function()
    WORLD.SCENE.state = 'paper1'
    paper1:hoverNextText()
    WORLD.SCENE.waitingCorrectText = true
  end)

  self:addEvent(function()
    WORLD.SCENE.state = 'paper2'
    paper2:hoverNextText()
    WORLD.SCENE.waitingCorrectText = true
  end)

  self:addEvent(function()
    paper1:replaceSelectedText(paper2:getSelectedText())
    paper2:unhover()
  end)

  --Palavra 3

  self:addEvent(function()
    WORLD.SCENE.state = 'paper1'
    paper1:hoverNextText()
    WORLD.SCENE.waitingCorrectText = true
  end)

  self:addEvent(function()
    WORLD.SCENE.state = 'paper2'
    paper2:hoverNextText()
    WORLD.SCENE.waitingCorrectText = true
  end)

  self:addEvent(function()
    paper1:replaceSelectedText(paper2:getSelectedText())
    paper2:unhover()
  end)

  --Palavra 4

  self:addEvent(function()
    WORLD.SCENE.state = 'paper1'
    paper1:hoverNextText()
    WORLD.SCENE.waitingCorrectText = true
  end)

  self:addEvent(function()
    WORLD.SCENE.state = 'paper2'
    paper2:hoverNextText()
    WORLD.SCENE.waitingCorrectText = true
  end)

  self:addEvent(function()
    paper1:replaceSelectedText(paper2:getSelectedText())
    paper1:unhover()
    paper2:unhover()
  end)

  self:addEvent(function()
    WORLD.SCENE.dialogs:addDialog('david-susto', 'Uma mensagem secreta!')
    self.waitingInput = true
  end)

  self:addEvent(function()
    WORLD.SCENE.map.entities:remove(paper2)
    paper1:setCoordinates(6, 2)
    for _, text in ipairs(paper1.interactiveTexts) do
      text.x = 231
    end
    self.waitTime = 5
  end)

  self:addEvent(function()
    WORLD.SCENE.dialogs:addDialog('david-susto',
    'O Nisus... Os funcionarios... Adam esta em perigo? E ele quer que eu fuja? Nao!')
    WORLD.SCENE.dialogs:addDialog('david', 'Preciso me acalmar...')
    WORLD.SCENE.dialogs:addDialog('david', 'Parando para pensar, esta lampada me parece esquisita...')
  end)

  self:addEvent(function()
    WORLD.SCENE.map.entities:remove(paper1)
    WORLD.SCENE.dialogs:addDialog('empty', 'David examina a base da lampada e ela entao emite um brilho intenso.')
  end)

  self:addEvent(function()
    player:playAnimation(1)
    self.waitTime = 2
  end)

  self:addEvent(function()
    self.overlay = NisusOverlay()
    self.overlay.scale = 0.2
    self.showOverlay = true
    self.waitTime = 1
  end)

  self:addEvent(function()
    self.showOverlay = false
    self.waitTime = 2
  end)

  self:addEvent(function()
    self.overlay.scale = 0.4
    self.showOverlay = true
    self.waitTime = 1
  end)
  self:addEvent(function()
    self.showOverlay = false
    self.waitTime = 2
  end)

  self:addEvent(function()
    self.overlay.scale = 0.6
    self.showOverlay = true
    self.waitTime = 1
  end)

  self:addEvent(function()
    self.showOverlay = false
    self.waitTime = 2
  end)

  self:addEvent(function()
    self.overlay.scale = 0.8
    self.showOverlay = true
    self.waitTime = 1
  end)

  self:addEvent(function()
    self.showOverlay = false
    self.waitTime = 2
  end)

  self:addEvent(function()
    self.overlay.scale = 1
    self.showOverlay = true
    self.waitTime = 1
  end)

  --Events init
  GAME.CUTSCENE = true

  self:makeCoroutine()
end

function Scene:resumeCoroutine()
  if #self.dialogs.objects == 0 and not self.watingInput and not self.waitingCorrectText and self.waitTime == 0 then
    Scene.super.resumeCoroutine(self)
  end
end

function Scene:keypressed(key)
  if self.waitingCorrectText and #self.dialogs.objects == 0 then
    if self.state == 'paper1' then
      if key == 'down' then
        paper1:hoverNextText()
      elseif key == 'up' then
        paper1:hoverPreviousText()
      end

      if key == 'space' then
        paper1:select()
        self.waitingCorrectText = false
      end
    elseif self.state == 'paper2' then
      if key == 'down' then
        paper2:hoverNextText()
      elseif key == 'up' then
        paper2:hoverPreviousText()
      end

      if key == 'space' then
        if paper1.selectedText == paper2.hoveredText then
          paper2:select()
          self.waitingCorrectText = false
        else
          self.dialogs:addDialog('david', 'Isso nao me parece certo...')
        end
      end
    end
  end

  Scene.super.keypressed(self, key)
end

return Scene
