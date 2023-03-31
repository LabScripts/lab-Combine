local ox_inventory = exports.ox_inventory

local Combinations = {
 -- ['item you drag'] = {needs = 'item you drag on to', result = 'result item'},
	['coca'] = {needs = 'baggy', result = 'coke'},
    ['meth'] = {needs = 'baggy', result = 'packagedmeth'},
}

local combhook = ox_inventory:registerHook('swapItems', function(payload)
    if  payload.fromSlot ~= nil and payload.toSlot ~= nil and Combinations[payload.fromSlot.name] ~= nil and payload.toSlot.name == Combinations[payload.fromSlot.name].needs then
        TriggerClientEvent('ox_inventory:closeInventory', payload.source)
        TriggerClientEvent('lab-Combine:Combine', payload.source)
        Wait(2000)
        ox_inventory:RemoveItem(payload.source, payload.fromSlot.name, 1)
        ox_inventory:RemoveItem(payload.source, Combinations[payload.fromSlot.name].needs, 1)
        ox_inventory:AddItem(payload.source, Combinations[payload.fromSlot.name].result, 1)
        return false
    end
end,{})