local Sound = require 'src.core.sound'
local BgmDark = Sound:extend()

function BgmDark:new()
  BgmDark.super.new(self, 'assets/sounds/themes/bgm-dark.mp3', 'stream', BGM_VOLUME, true)
end

return BgmDark