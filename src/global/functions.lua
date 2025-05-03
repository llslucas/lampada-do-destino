function StartGame()
  GAME.STATE = 'start'
end

function ResumeGame()
  GAME.STATE = 'playing'
end

function QuitGame()
  love.event.quit()
end