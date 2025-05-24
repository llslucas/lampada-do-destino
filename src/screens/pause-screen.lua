local Screen = require 'src.core.screen'
local PauseScreen = Screen:extend()

local MenuOptions = require 'src.aggregate.menu-options'
local MenuOption = require 'src.graphics.menu-option'

function PauseScreen:new()
  self.showText = true
  self.options = nil
  self.configs = nil

  PauseScreen:addOptions()
  PauseScreen:addConfigurations()
end

function PauseScreen:draw()
  LG.setColor(0, 0, 0, 0.9)
  LG.rectangle("fill", 0, 0, LG.getWidth(), LG.getHeight())
  LG.setColor(1, 1, 1)

  if GAME.MENUSTATE == 'config' then
    LG.setColor(1, 0.592, 0)
    LG.setFont(FONTS.MENUTITTLE)
    LG.print('CONFIGURAÇÕES', 164, 50)
    LG.setFont(FONTS.NORMAL)
    self.configs:draw()
  else
    self.options:draw()
  end
end

function PauseScreen:update(dt)
  if GAME.MENUSTATE == 'config' then
    self.configs:update(dt)
  end
end

function PauseScreen:keypressed(key)
  if GAME.MENUSTATE == 'config' then
    self.configs:keypressed(key)
    return
  end

  self.options:keypressed(key)
end

function PauseScreen:addOptions()
  self.options = MenuOptions()

  local optContinuar = MenuOption('CONTINUAR', 239, 273)
  optContinuar:setInteractionCallback(
    function()
      GAME.STATE = 'running'
    end
  )

  local optConfiguracoes = MenuOption('CONFIGURAÇÕES', 203, 311)
  optConfiguracoes:setInteractionCallback(
    function(self)
      GAME.MENUSTATE = 'config'
    end)

  local optReset = MenuOption('REINICIAR FASE', 194, 349)
  optReset:setInteractionCallback(
    function()
      WORLD.STORYMANAGER:apply()
    end
  )

  local optSair = MenuOption('SAIR', 284, 387)
  optSair:setInteractionCallback(function() love.event.quit() end)

  self.options:add(optContinuar, optConfiguracoes, optReset, optSair)
  self.options:activate()
end

function PauseScreen:addConfigurations()
  self.configs = MenuOptions()

  local optBgm, optSair

  optBgm = MenuOption('MUSIC VOLUME', 176, 166)
  optBgm:setProperty(BGM_VOLUME * 100)
  optBgm:setCallback(function(self) BGM_VOLUME = self.property / 100 end)

  optSair = MenuOption('SAIR', 284, 352)
  optSair:setInteractionCallback(function() GAME.MENUSTATE = 'menu' end)

  self.configs:add(optBgm, optSair)
  self.configs:activate()
end

return PauseScreen
