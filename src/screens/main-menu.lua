local Screen = require 'src.core.screen'
local MainMenu = Screen:extend()

local StoryManager = require 'src.chapters.storymanager'
local MenuOptions = require 'src.aggregate.menu-options'
local MenuOption = require 'src.graphics.menu-option'
local Entity = require 'src.core.entity'

function MainMenu:new()
  MainMenu.super.new(self, 'assets/img/screens/main.png')
  self.gradient = Entity(LG.newImage('assets/img/screens/gradient.png'))

  self.showText = true
  self.elapsedTime = 0
  self.options = nil
  self.configs = nil

  MainMenu:addOptions()
  MainMenu:addConfigurations()
end

function MainMenu:draw()
  MainMenu.super.draw(self)

  if GAME.MENUSTATE == 'init' then
    self:drawFirstMessage()
  end

  if GAME.MENUSTATE == 'menu' then
    self.gradient:draw()
    self.options:draw()
  end

  if GAME.MENUSTATE == 'config' then
    LG.setFont(FONTS.MENUTITTLE)
    LG.print('CONFIGURAÇÕES', 164, 50)
    LG.setFont(FONTS.NORMAL)
    LG.setColor(0,0,0)
    LG.rectangle("fill", 0, 0, LG.getWidth(), LG.getHeight())
    LG.setColor(1,1,1)
    self.configs:draw()
  end
end

function MainMenu:update(dt)
  MainMenu.super.update(self, dt)

  self.elapsedTime = self.elapsedTime + dt

  if self.elapsedTime > 1 then
    self.showText = not self.showText
    self.elapsedTime = 0
  end
end

function MainMenu:keypressed(key)
  if GAME.MENUSTATE == 'menu' then
    self.options:keypressed(key)
    return
  end

  if GAME.MENUSTATE == 'config' then
    self.configs:keypressed(key)
    return
  end

  if key == 'space' then
    GAME.MENUSTATE = 'menu'
  end
end

function MainMenu:drawFirstMessage()
  if self.showText then
    LG.setFont(FONTS.MENU)
    LG.print("PRESSIONE ESPAÇO PARA INICIAR", 120, 580)
    LG.setFont(FONTS.NORMAL)
  end
end

function MainMenu:addOptions()
  self.options = MenuOptions()

  local optIniciar = MenuOption('INICIAR', 257, 472)
  optIniciar:setInteractionCallback(
    function()
      GAME.STATE = 'running'
      GAME.MENUSTATE = 'init'
      WORLD.STORYMANAGER = StoryManager()
    end
  )

  local optConfiguracoes = MenuOption('CONFIGURAÇÕES', 203, 510)
  optConfiguracoes:setInteractionCallback(
    function(self)
      GAME.MENUSTATE = 'config'
    end)

  local optSair = MenuOption('SAIR', 284, 548)
  optSair:setInteractionCallback(
    function()
      love.event.quit()
    end
  )

  self.options:add(optIniciar, optConfiguracoes, optSair)
  self.options:activate()
end

function MainMenu:addConfigurations()
  self.configs = MenuOptions()

  local optBgm, optSfx, optTextSpeed, optSair

  optBgm = MenuOption('MUSIC VOLUME', 176, 166)
  optBgm:setProperty(BGM_VOLUME * 100)
  optBgm:setCallback(function(self) BGM_VOLUME = self.property * 100 end)

  optSfx = MenuOption('SFX VOLUME', 194, 228)
  optSfx:setProperty(SFX_VOLUME * 100)
  optSfx:setCallback(function(self) BGM_VOLUME = self.property * 100 end)

  optTextSpeed = MenuOption('TEXT SPEED', 194, 290)
  optTextSpeed:setProperty(WORD_RENDERING_SPEED * 100)
  optTextSpeed:setCallback(function(self) BGM_VOLUME = self.property * 100 end)

  optSair = MenuOption('SAIR', 284, 352)
  optSair:setInteractionCallback(function() GAME.MENUSTATE = 'menu' end)

  self.configs:add(optBgm, optSfx, optTextSpeed, optSair)
  self.configs:activate()
end

return MainMenu
