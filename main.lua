function grid (x, y)
	ret = {}
	for i = 1, y, 1 do
		z = {}
		for j = 1, x, 1 do
			table.insert(z, {
				['name'] = 'empty',
				['direction'] = nil
			})
		end
		table.insert(ret, z)
	end
	return ret
end

function love.load ()
	board = grid(100, 100)
	gridx = 100
	gridy = 100
	camx = 0
	camy = 0
	zoom = 20
	empty = love.graphics.newImage('empty.png')
	canzoom = true
	files = {}
	files.cells = love.filesystem.getDirectoryItems('cells')
	files.apis = love.filesystem.getDirectoryItems('apis')
	apis = {}
	for i, item in ipairs(files.apis) do
		if item:getExtension() == 'lua' then
			apis[item:getFilename()] = require(item)
	end end
	for i, item in ipairs(files.cells) do
		if item:getExtension() == 'objcell' then
			love.filesystem.mount(d, item:getFilename())
	end end
end

function love.update (dt)
	if love.keyboard.isDown('w') then
		camy = math.max(camy - 10, 0)
	end if love.keyboard.isDown('s') then
		camy = math.min(camy + 10, gridy * zoom - 600)
	end if love.keyboard.isDown('a') then
		camx = math.max(camx - 10, 0)
	end if love.keyboard.isDown('d') then
		camx = math.min(camx + 10, gridx * zoom - 800)
	end if love.keyboard.isDown('-') and canzoom == true then
		zoom = math.max(zoom - 5, 1)
		canzoom = false
	end if love.keyboard.isDown('=') and canzoom == true then
		zoom = zoom + 5
		canzoom = false
	end if not love.keyboard.isDown('-', '=') then
		canzoom = true
	end
	camx = math.min(camx + 10, gridx * zoom - love.graphics.getWidth())
	camx = math.max(camx - 10, 0)
	camy = math.min(camy + 10, gridy * zoom - love.graphics.getHeight())
	camy = math.max(camy - 10, 0)
	
	
end

function love.draw ()
	for i = 1, gridy, 1 do
		for j = 1, gridx, 1 do
			love.graphics.draw(empty, (j - 1) * zoom - camx, (i - 1) * zoom - camy, 0, zoom / 32, zoom / 32)
		end
	end
end

function love.filedropped (file)
	fext = file:getExtension()
	if fext == 'objlvl' then
		
	end
end
