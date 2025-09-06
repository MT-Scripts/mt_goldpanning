lib.locale()
local config = require 'config.server'
local utils = require 'modules.server'
local locationCooldowns = {}
local locationAttempts = {}
local cooldowns = {}
local COOLDOWN_SECONDS = 5

local pickRarity = function()
    local roll = math.random(1, 100)
    local cumulative = 0
    for rarity, weight in pairs(config.rarityWeights) do
        cumulative = cumulative + weight
        if roll <= cumulative then
            return rarity
        end
    end
    return 'common'
end

local getRandomReward = function()
    local chosenRarity = pickRarity()
    local pool = {}
    for _, reward in ipairs(config.rewards) do
        if reward.rarity == chosenRarity then
            table.insert(pool, reward)
        end
    end

    if #pool == 0 then return nil end

    local selected = pool[math.random(1, #pool)]
    local amount = math.random(selected.min, selected.max)
    return selected.item, amount
end

lib.callback.register('mt_goldpanning:server:checkDurability', function(source, slot)
    local src = source
    local item = utils.getItemBySlot(src, slot)
    if item and item.metadata and item.metadata.durability then
        return item.metadata.durability
    elseif item and not item.metadata.durability then
        return 100
    end
    return 0
end)

RegisterNetEvent('mt_goldpanning:server:giveReward', function(slot)
    local src = source
    local item = utils.getItemBySlot(src, slot)
    local now = os.time()
    local coords = GetEntityCoords(GetPlayerPed(src))
    local locKey = string.format("%.1f_%.1f_%.1f", coords.x, coords.y, coords.z)

    if cooldowns[src] and (now - cooldowns[src]) < COOLDOWN_SECONDS then return end

    if locationCooldowns[locKey] and (now - locationCooldowns[locKey]) < (config.locationCooldown * 1000 * 60) then
        utils.notify(locale('error.location_cooldown'), 'error')
        return
    end

    locationAttempts[locKey] = (locationAttempts[locKey] or 0) + 1
    if locationAttempts[locKey] > config.maxPansPerLocation then
        locationCooldowns[locKey] = now
        locationAttempts[locKey] = 0
        TriggerClientEvent('mt_goldpanning:client:notify', src, locale('error.location_cooldown'), 'error')
        return
    end

    if not (item and item.name == config.panningItem) then return end

    if item.metadata and item.metadata.durability then
        if item.metadata.durability <= 0 then
            utils.removeItem(src, item.name, slot)
            return
        end

        local newDurability = item.metadata.durability - config.durabilityPerUse
        if newDurability <= 0 then
            utils.removeItem(src, item.name, slot)
            return
        else
            utils.setItemMetadata(src, slot, { durability = newDurability })
        end
    else
        utils.setItemMetadata(src, slot, { durability = 99 })
    end

    local amount = math.random(config.itemsPerPanning.min, config.itemsPerPanning.max)
    for _ = 1, amount do
        local rewardItem, rewardCount = getRandomReward()
        if not rewardItem or rewardCount <= 0 then return end

        if not utils.canCarryItem(src, rewardItem, rewardCount) then
            TriggerClientEvent('mt_goldpanning:client:notify', src, locale('error.inventory_full'), 'error')
            return
        end

        utils.addItem(src, rewardItem, rewardCount)
    end

    cooldowns[src] = now
end)
