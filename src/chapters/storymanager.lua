local StoryManager = Object:extend()

function StoryManager:new(currentChapter, currentScene)
  self.currentChapter = currentChapter or 1
  self.currentScene = currentScene or 1
  self:apply()
end

function StoryManager:setCurrentChapter(currentChapter)
  self.currentChapter = currentChapter
end

function StoryManager:setCurrentScene(currentScene)
  self.currentScene = currentScene
end

function StoryManager:getCurrentScene()
  local chapterPath = string.format("src.chapters.chapter-%d.scene-%d", self.currentChapter, self.currentScene)
  local _, scene = pcall(require, chapterPath)
  return scene
end

function StoryManager:apply()
  local Scene = self:getCurrentScene()
  WORLD.SCENE = Scene()
  GAME.STATE = 'running'
end

function StoryManager:advanceScene(...)
  self.currentScene = self.currentScene + 1
  WORLD.SCENE.map.theme:stop()
  self:apply()
end

function StoryManager:advanceChapter()
  self.currentChapter = self.currentChapter + 1
  WORLD.SCENE.map.theme:stop()
  self:apply()
end

return StoryManager
