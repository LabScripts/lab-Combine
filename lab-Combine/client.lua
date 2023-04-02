RegisterNetEvent('lab-Combine:Combine', function(duration)
    TriggerServerEvent('ox_inventory:closeInventory')
    local result = lib.progressCircle({
        duration = duration,
        label = 'Combining..',
        position = 'middle',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            dict = 'amb@prop_human_parking_meter@male@base',
            clip = 'base'
        },
    })

    lib.callback('lab-Combine:success', false, function()
    end, result)
end)
