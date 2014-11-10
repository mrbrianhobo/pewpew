scriptId = 'com.thalmic.scripts.pewpew'

function goRight()
	myo.keyboard("left_arrow", "press")
	myo.keyboard("right_arrow", "down")
end

function goLeft()
	myo.keyboard("right_arrow", "press")
	myo.keyboard("left_arrow", "down")
end

function shoot()
	myo.keyboard("left_control", "down")
end

locked = true
appTitle = ""
 
function activeAppName()
	return appTitle
end
 
function onPoseEdge(pose, edge)
	myo.debug("onPoseEdge: " .. pose .. ": " .. edge)
	
	pose = conditionallySwapWave(pose)
	
	if (edge == "on") then
		if (pose == "fist") then
			toggleLock()
		elseif (not locked) then
			if (pose == "waveOut") then
				goRight()	
			elseif (pose == "waveIn") then
				goLeft()
			elseif (pose == "fingersSpread") then
				shoot()		
			end

		end
	end
end
 
function toggleLock()
	locked = not locked
	myo.vibrate("short")
	if (not locked) then
		-- Vibrate twice on unlock
		myo.debug("Unlocked")
		myo.vibrate("short")
	else 
		myo.debug("Locked")
	end
end
 
function conditionallySwapWave(pose)
	if myo.getArm() == "left" then
        if pose == "waveIn" then
            pose = "waveOut"
        elseif pose == "waveOut" then
            pose = "waveIn"
        end
    end
    return pose
end
function onForegroundWindowChange(app, title)   
    if string.match(title, "Unity") then    
        return true
    end
end