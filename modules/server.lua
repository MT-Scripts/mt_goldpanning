local utils = {}

utils.getItemBySlot = function(src, slot)
   return exports.ox_inventory:GetSlot(src, slot)
end

utils.canCarryItem = function(src, item, count)
    return exports.ox_inventory:CanCarryItem(src, item, count)
end

utils.addItem = function(src, item, count)
    return exports.ox_inventory:AddItem(src, item, count)
end

utils.setItemMetadata = function(src, slot, metadata)
    return exports.ox_inventory:SetMetadata(src, slot, metadata)
end

utils.removeItem = function(src, item, slot)
    return exports.ox_inventory:RemoveItem(src, item, 1, nil, slot)
end

return utils