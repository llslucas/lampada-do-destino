GAME = {}
GAME.STATE = "running"

function GAME.resume()
  GAME.STATE = 'running'
end

function GAME.pause()
  GAME.STATE = 'paused'
end