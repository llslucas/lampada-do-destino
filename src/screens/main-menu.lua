local Screen = require 'src.core.screen'
local MainMenu = Screen:extend()

local StoryManager = require 'src.chapters.storymanager'
local MainTheme = require 'src.sounds.main-theme'

function MainMenu:new()
  MainMenu.super.new(self, 'assets/img/screens/main.png')
  self.showText = true
  self.elapsedTime = 0
  self.theme = MainTheme()
  self.theme:play()
end

function MainMenu:draw()
  MainMenu.super.draw(self)
  if self.showText then
    LG.setFont(FONTS.MENU)
    LG.print("PRESSIONE ESPAÇO PARA INICIAR", 120, 580)
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
    WORLD.STORYMANAGER = StoryManager(1,3)
  end
end

return MainMenu
