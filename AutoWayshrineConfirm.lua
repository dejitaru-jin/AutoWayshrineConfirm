local ADDON_NAME = "AutoWayshrineConfirm"

local function OnAddOnLoaded(event, addonName)
    if addonName ~= ADDON_NAME then
        return
    end

    -- Hook the platform dialog function.
    -- When the game wants to show the wayshrine confirm dialog ("FAST_TRAVEL_CONFIRM"),
    -- we just call FastTravelToNode ourselves and tell the game not to show the dialog.
    ZO_PreHook("ZO_Dialogs_ShowPlatformDialog", function(dialogName, data)
        -- Only touch the wayshrine confirmation dialog
        if dialogName == "FAST_TRAVEL_CONFIRM" and data and data.nodeIndex then
            -- This is what the dialog would do when you press "Accept"
            FastTravelToNode(data.nodeIndex)
            -- Returning true tells ESO "we handled it, don't show the dialog"
            return true
        end
        -- For all other dialogs, do nothing special
        -- (returning nil/false lets the normal behavior continue)
    end)

    EVENT_MANAGER:UnregisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED)
end

EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
