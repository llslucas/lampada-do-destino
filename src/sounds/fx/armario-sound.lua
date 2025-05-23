local Sound = require 'src.core.sound'
local DamageSound = Sound:extend()

function DamageSound:new()
  DamageSound.super.new(self, 'assets/sounds/effects/armario.mp3', 'static', SFX_VOLUME, false)
end

return DamageSound