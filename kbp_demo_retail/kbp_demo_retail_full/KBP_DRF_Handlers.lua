--Retrieve global variables passed to the addon
local addonName, addonTable = ...

--Handle frame events
local function KBP_DRF_OnEvent(self, event, ...)
    --Print message when player is able to enter Pet Battle
    if event == "PET_BATTLE_OPENING_START" then
        print(addonTable["KBP_DRF_PET_BATTLE_ENTERING"])
    --Print message when changing zone
    elseif event == "ZONE_CHANGED_NEW_AREA" then
        --Print zone name along with localized message
        print(addonTable["KBP_DRF_ENTERING_NEW_ZONE"], GetZoneText())
    end
end