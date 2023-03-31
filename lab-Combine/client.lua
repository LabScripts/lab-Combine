RegisterNetEvent('lab-Combine:Combine')
AddEventHandler('lab-Combine:Combine', function()
    lib.progressCircle({
        duration = 2000,
        label = 'Combining..',
        position = 'middle',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
        },
        anim = {
            dict = 'amb@prop_human_parking_meter@male@base',
            clip = 'base'
        },
    })
end)
