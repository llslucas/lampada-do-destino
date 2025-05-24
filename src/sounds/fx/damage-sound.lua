local Sound = require 'src.core.sound'
local ArmarioSound = Sound:extend()

function ArmarioSound:new()
  ArmarioSound.super.new(self, 'assets/sounds/effects/damage-noise.wav', 'static', BGM_VOLUME, false)
end

return ArmarioSound