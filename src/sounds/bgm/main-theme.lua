local Sound = require 'src.core.sound'
local MainTheme = Sound:extend()

function MainTheme:new()
  MainTheme.super.new(self, 'assets/sounds/themes/main-theme.mp3', 'stream', BGM_VOLUME, true)
end

return MainTheme