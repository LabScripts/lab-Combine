local ox_inventory = exports.ox_inventory

local Combinations = {
    -- ['something'] = {
    --     needs = 'the other something', 
    --     result = {
    --         [1] = {name = 'some result', amount = 1},
    --         --[2] = {name = 'more results', amount = 5},
    --     }, 
    --     removeItemA = true, -- Remove the dragged item?
    --     removeItemB = true, -- Remove the item you dragged onto?
    -- },

	['coca'] = {
        needs = 'baggy', 
        result = {
            [1] = {name = 'coke', amount = 1},
            --[2] = {name = 'something', amount = 5},
        }, 
        removeItemA = true, -- Remove the dragged item?
        removeItemB = true, -- Remove the item you dragged onto?
    },
}

local combhook = ox_inventory:registerHook('swapItems', function(payload)
    if  payload.fromInventory == payload.source and payload.fromSlot ~= nil and payload.toSlot ~= nil and Combinations[payload.fromSlot.name] ~= nil and payload.toSlot.name == Combinations[payload.fromSlot.name].needs then
        TriggerClientEvent('ox_inventory:closeInventory', payload.source)
        TriggerClientEvent('lab-Combine:Combine', payload.source)
        Wait(2000)
        if Combinations[payload.fromSlot.name].removeItemA then
            ox_inventory:RemoveItem(payload.source, payload.fromSlot.name, 1)
        end
        if Combinations[payload.fromSlot.name].removeItemB then
            ox_inventory:RemoveItem(payload.source, Combinations[payload.fromSlot.name].needs, 1)
        end
        for k,v in pairs(Combinations[payload.fromSlot.name].result) do
            ox_inventory:AddItem(payload.source, v.name, v.amount)
        end
        return false
    end
end,{})
