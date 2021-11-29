local normal = false

local normal1 = false

local weee = false

function update (elapsed)
local currentBeat = (songPos / 1000)*(bpm/60)
    if weee then
        for i=0,7 do
            setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.sin((currentBeat + i*4)), i)
            setActorX(_G['defaultStrum'..i..'X'],i)
        end
        camHudAngle = 1 * math.sin(currentBeat * math.pi)
        cameraAngle = 1 * math.sin(currentBeat * math.pi)
    end
    if normal then
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'], i)
			setActorY(_G['defaultStrum'..i..'Y'], i)
		end
		    camHudAngle = 0
            cameraAngle = 0
	end
end



function stepHit (step)
	if step == 863 then
		weee = true
		normal = false
    end
	if step == 1664 then
	    weee = false
		normal = true
	end
end