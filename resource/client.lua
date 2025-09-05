lib.locale()
local utils = require 'modules.client'
local config = require 'config.client'

local usePanning = function(_, item)
    if IsPedSwimming(cache.ped) then
        utils.notify(locale('error.swimming'), 'error')
        return
    end

    if not IsEntityInWater(cache.ped) then
        utils.notify(locale('error.not_in_water'), 'error')
        return
    end

    local durability = lib.callback.await('mt_goldpanning:server:checkDurability', false, item.slot)
    if durability <= 0 then
        utils.notify(locale('error.broken_tool'), 'error')
        return
    end

    utils.loadAnimDict(config.animation.anim.dict)
    utils.loadModel(config.animation.props[1])
    utils.loadModel(config.animation.props[2])

    TaskPlayAnim(cache.ped, config.animation.anim.dict, config.animation.anim.clip, 8.0, -8.0, -1, config.animation.anim.flag, 0, false, false, false)
    local coords = GetEntityCoords(cache.ped)
    local forward = GetEntityForwardVector(cache.ped)
    local newCoords = coords + forward
    local prop = CreateObject(GetHashKey(config.animation.props[1]), newCoords.x, newCoords.y, newCoords.z, true, true, false)
    PlaceObjectOnGroundProperly(prop)
    FreezeEntityPosition(prop, true)

    local panning = true
    CreateThread(function()
        while panning do
            PlaySoundFromEntity(GetSoundId(), "UNDER_WATER_COME_UP", prop, '', true, 0)
            Wait(2500)
        end
    end)

    local success = utils.minigame(config.minigame.difficulty, config.minigame.keys)
    if not success then
        ClearPedTasks(cache.ped)
        DeleteEntity(prop)
        utils.notify(locale('error.minigame_failed'), 'error')
        return
    end

    DeleteEntity(prop)
    prop = CreateObject(GetHashKey(config.animation.props[2]), newCoords.x, newCoords.y, newCoords.z, true, true, false)
    PlaceObjectOnGroundProperly(prop)
    FreezeEntityPosition(prop, true)

    local duration = math.random(config.progress.min, config.progress.max)
    local progress = utils.progressbar(locale('progress.panning'), duration, { move = true, car = true, combat = true }, {}, {})
    if progress then
        local reward = lib.callback.await('mt_goldpanning:server:giveReward', false, item.slot)
        if reward then
            utils.notify(locale('success.received'))
        else
            utils.notify(locale('error.inventory_full'), 'error')
        end
    else
        utils.notify(locale('error.canceled'), 'error')
    end

    ClearPedTasks(cache.ped)
    DeleteEntity(prop)
    panning = false
end
exports('usePanning', usePanning)