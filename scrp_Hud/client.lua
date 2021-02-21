local toghud = true
local timeText = ""

RegisterNetEvent('hud:toggleui')
AddEventHandler('hud:toggleui', function(show)

    if show == true then
        toghud = true
    else
        toghud = false
    end

end)

Citizen.CreateThread(function()
    while true do
        

        local myhunger = exports["ml_needs"]:ml_hunger()--hunger.getPercent()
        local mythirst = exports["ml_needs"]:ml_thirst()
        local mystress = exports["ml_needs"]:ml_stress()

        SendNUIMessage({
			action = "updateStatusHud",
            show = toghud,
            hunger = myhunger,
            thirst = mythirst,
            stress = mystress,
        })
        Citizen.Wait(5000)
    end
end)

Citizen.CreateThread(function()
    while true do
	    Wait(1)
        local hour = GetClockHours()
        local minute = GetClockMinutes()
        DrawTxt(" " ..timeText.. " ", 0.101, 0.961, 1.0, 0.3, true, 0, 255, 255, 255, true)
        timeText = ("%.2d"):format((hour == 0) and 12 or hour) .. ":" .. ("%.2d"):format( minute) .. ((hour < 12) and " AM" or " PM")
    end
end)


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        local player = PlayerPedId()
        local health = (GetEntityHealth(player))

        SendNUIMessage({
            action = 'updateStatusHud',
            show = toghud,
            health = health,
        })
        Citizen.Wait(200)
    end
end)