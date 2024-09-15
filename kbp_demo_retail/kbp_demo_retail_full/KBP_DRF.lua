--Retrieve global variables passed to the addon
local addonName, addonTable = ...

--Check and Fetch Libraries, we need
--Libstub, LibDataBroker and LibDbIcon
if not LibStub or not LibStub("LibDataBroker-1.1", true) or not LibStub("LibDBIcon-1.0", true) then
	--Dont proceed
	return
end
local LibDataBroker = LibStub("LibDataBroker-1.1", true)
local LibDBIcon = LibStub("LibDBIcon-1.0", true)

--Load the minimap icon tga using LibDataBroker
local KBP_DRF_MM_Icon = LibDataBroker:NewDataObject("KBP_DRF_MM_Icon", {
		type = "MM_Icon",
		text = "KBP_DRF_MM_ICON",
		icon = "Interface\\AddOns\\kbp_demo_retail\\Icons\\kbp_demo_retail_mm_icon",
		OnClick = function() print("KBP_DRF_MM_ICON") end,
	}
)
--Setup storage table for minimap icon variables
addonTable["KBP_DRF_MM_ICON"] = {hide=false}

--Create minimap icon
LibDBIcon:Register("KBP_DRF_MM_ICON", KBP_DRF_MM_Icon, addonTable["KBP_DRF_MM_ICON"])

--Alert when mana goes under 15%
local KBP_DRF_Player_GUID = UnitGUID("player")
local function OnManaEvent(self, event)
	if event == "UNIT_POWER_UPDATE" then
		--https://wowpedia.fandom.com/wiki/UNIT_POWER_UPDATE
		local unitId, powerType = select(12, CombatLogGetCurrentEventInfo())
		if powerType == "MANA" and unitId == KBP_DRF_Player_GUID then
			local unitManaCurrent = UnitPower(KBP_DRF_Player_GUID, Enum.PowerType.Mana)
			local unitManaMax = UnitPowerMax(KBP_DRF_Player_GUID, Enum.PowerType.Mana)
			local unitManaPercentage = (unitManaCurrent % unitManaMax)
			if unitManaPercentage <= 0.15 then
				print(addonTable["KBP_DRF_LOW_MANA_WARNING"], unitManaPercentage)
			end
		end
	end
end

local KBP_DRF_Mana_Event_Frame = CreateFrame("KBP_DR_Full_Mana_Event_Frame")
KBP_DRF_Mana_Event_Frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
KBP_DRF_Mana_Event_Frame:SetScript("OnEvent", OnManaEvent)