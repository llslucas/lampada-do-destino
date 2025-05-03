local Sound = Object:extend()

function Sound:new(soundPath, soundType, volume, looping)
  self.sound = love.audio.newSource(soundPath, soundType)
  self.sound:setVolume(volume)
  self.sound:setLooping(looping)
end

function Sound:play()
  if not self.sound:isPlaying() then
    self.sound:play()
  end
end

function Sound:stop()
  if self.sound:isPlaying() then
    self.sound:stop()
  end
end

function Sound:pause()
  if self.sound:isPlaying() then
    self.sound:pause()
  end
end

return Sound
