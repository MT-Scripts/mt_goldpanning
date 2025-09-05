local utils = {}

utils.loadModel = function(model)
    if not HasModelLoaded(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(10)
        end
    end
end

utils.loadAnimDict = function(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(10)
        end
    end
end

utils.notify = function(message, type)
    lib.notify({
        description = message,
        type = type or 'success',
        position = 'top',
        duration = 5000
    })
end

utils.minigame = function(difficulty, keys)
    return lib.skillCheck(difficulty, keys)
end

utils.progressbar = function(label, duration, disable, anim, prop)
    return lib.progressBar({
        label = label,
        duration = duration,
        useWhileDead = false,
        canCancel = true,
        disable = disable,
        anim = anim,
        prop = prop
    })
end

return utils