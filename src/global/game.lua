GAME = {}
GAME.STATE = "running"
GAME.CUTSCENE = false

function GAME.resume()
  GAME.STATE = 'running'
end

function GAME.pause()
  GAME.STATE = 'paused'
end