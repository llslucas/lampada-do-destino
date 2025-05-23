local Sound = require 'src.core.sound'
local BgmLight = Sound:extend()

function BgmLight:new()
  BgmLight.super.new(self, 'assets/sounds/themes/bgm-light.mp3', 'stream', BGM_VOLUME, true)
end

return BgmLight