local normal = false

local bang = false

function start(song)

end


function update(elapsed)
    local currentBeat = (songPos / 1000)*(bpm/60)
	
	   if curStep == 168 then
        for i =0,7 do
            tweenAngle(i, _G['defaultStrum'..i..'X'] + 64 * math.sin((currentBeat + i*0.25) * math.pi), 0.4)
            setActorAngle(getActorAngle(i) + 5, i)
            tweenAngle(i, 360, 0.4)
        end
	end
	   if curStep == 123 then
        for i =4,7 do
            setActorX(_G['defaultStrum'..i..'X'] + 6 * math.cos((currentBeat + i*0.25) * math.pi), i)
            tweenAngle(i, _G['defaultStrum'..i..'Y'] + 100 * math.sin((currentBeat + i*0.25) * math.pi), 0.4)
            setActorAngle(getActorAngle(i) + 5, i)
            tweenAngle(i, 360, 0.4)
        end
    end
end



function stepHit (step)

end