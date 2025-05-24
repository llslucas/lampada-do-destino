GAME = {}
GAME.STATE = "running"
GAME.CUTSCENE = false
GAME.DIALOG = false
GAME.MENUSTATE = "init"

function GAME.resume()
  GAME.STATE = 'running'
end

function GAME.pause()
  GAME.STATE = 'paused'
end