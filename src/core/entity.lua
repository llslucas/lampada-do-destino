local Entity = Object:extend()

function Entity:new(img, scale, angle)
    self.img = img or nil
    self.scale = scale or 1
    self.angle = angle or 0
    self.x = 0
    self.y = 0
end

function Entity:draw()
    if self.img then
        LG.draw(self.img, self.x, self.y, self.angle, self.scale, self.scale)
    end
end

function Entity:getHeight()
    if self.img then
        return math.floor(self.img:getHeight() * self.scale)
    end
end

function Entity:getWidth()
    if self.img then 
        return math.floor(self.img:getWidth() * self.scale)
    end
end

function Entity:setCoordinates(x, y)
    self.x = x
    self.y = y
end

function Entity:getCenter()
    return self:getWidth() / 2, self:getHeight() / 2
end

function Entity:getCoordinates()
    return self.x, self.y
end

function Entity:getCenterCoordinates()
    return self.x + (self:getWidth() / 2), self.y + (self:getHeight() / 2)
end

function Entity:getHitbox()
    return self.x, self.y, self:getWidth(), self:getHeight()
end

function Entity:checkCollision(object)
    local x1, y1, w1, h1 = self:getHitbox()
    local x2, y2, w2, h2 = object:getHitbox()

    local collision = {
        left = x1 < x2 + w2 and x1 + w1 > x2 and y1 < y2 + h2 and y1 + h1 > y2 and x1 + w1 <= x2 + w2,
        right = x1 < x2 + w2 and x1 + w1 > x2 and y1 < y2 + h2 and y1 + h1 > y2 and x1 >= x2,
        top = x1 < x2 + w2 and x1 + w1 > x2 and y1 < y2 + h2 and y1 + h1 > y2 and y1 + h1 <= y2 + h2,
        bottom = x1 < x2 + w2 and x1 + w1 > x2 and y1 < y2 + h2 and y1 + h1 > y2 and y1 >= y2
    }

    return collision
end

function Entity:checkBorderCollision(screenWidth, screenHeight)
    local x, y, w, h = self:getHitbox()

    local collision = {
        left = x < 0,
        right = x + w > screenWidth,
        top = y < 0,
        bottom = y + h > screenHeight
    }

    return collision
end

function Entity:interact()
    return
end

return Entity