local Screen = require 'src.core.screen'
local MainMenu = Screen:extend()

local MainTheme = require 'src.sounds.bgm.main-theme'

function MainMenu:new()
  MainMenu.super.new(self, 'assets/img/screens/game-over.png')
  self.showText = true
  self.elapsedTime = 0
  self.theme = MainTheme()
end

function MainMenu:draw()
  MainMenu.super.draw(self)
  self.theme:play()

  if self.showText then
    LG.setFont(FONTS.MENU)
    LG.print("PRESSIONE ESPAÇO PARA CONTINUAR", 100, 580)
    LG.setFont(FONTS.NORMAL)
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
  if key == 'space' then
    GAME.STATE = 'running'
    self.theme:stop()
    WORLD.STORYMANAGER:apply()
  end
end

return MainMenu
