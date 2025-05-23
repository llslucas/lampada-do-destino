local Sound = require 'src.core.sound'
local DamageSound = Sound:extend()

function DamageSound:new()
  DamageSound.super.new(self, 'assets/sounds/effects/damage-noise.wav', 'stream', BGM_VOLUME, false)
end

return DamageSound