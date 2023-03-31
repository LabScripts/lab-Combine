local ox_inventory = exports.ox_inventory

local Combinations = {
 -- ['item you drag'] = {needs = 'item you drag on to', result = 'result item'},
	['coca'] = {needs = 'baggy', result = 'coke'},
    ['meth'] = {needs = 'baggy', result = 'packagedmeth'},
}

local combhook = ox_inventory:registerHook('swapItems', function(payload)
    if payload.fromSlot ~= nil and payload.toSlot ~= nil then
        local item1 = (Combinations[payload.fromSlot.name] and payload.fromSlot.name) or (Combinations[payload.toSlot.name] and payload.toSlot.name)
        if not item1 then return end

        local item2 = (Combinations[item1].needs == payload.fromSlot.name and payload.fromSlot.name) or (Combinations[item1].needs == payload.toSlot.name and payload.toSlot.name)
        if not item2 then return end

        if Combinations[payload.fromSlot.name] then
            item1 = payload.fromSlot.name
        end
        TriggerClientEvent('ox_inventory:closeInventory', payload.source)
        TriggerClientEvent('lab-Combine:Combine', payload.source)
        Wait(2000)
        ox_inventory:RemoveItem(payload.source, item1, 1)
        ox_inventory:RemoveItem(payload.source, item2, 1)
        ox_inventory:AddItem(payload.source, Combinations[item1].result, 1)
        return false
    end
end, {})
