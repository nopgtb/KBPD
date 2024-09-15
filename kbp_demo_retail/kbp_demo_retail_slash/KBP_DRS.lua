--Slash command declarations
SLASH_KBPDRISPLAYERSPELL1 = "/kbpdrisplayerspell"
SLASH_KBPDRISINPETBATTLE1 = "/kbpdrisinpetbattle"
SLASH_KBPDRISINARENA1 = "/kbpdrisinarena"
SLASH_KBPDRCREATEDROPDOWNMENU1 = "/kbpdrcreatedropdownmenu"
SLASH_KBPDRISBUSY1 = "/kbpdrisbusy"
SLASH_KBPDRISFULLMANA1 = "/kbpdrisfullmana"

--Test target info:
--https://wowpedia.fandom.com/wiki/API_IsPlayerSpell
--IsPlayerSpell was added in MOP patch 5.0.4
--Function description:
--Returns a boolean for if player charecter has learned the spell, descriped by the given spell_id
--Test purpose:
--While IsPlayerSpell does not exist in the older API, we can still replicate its function
--Using the available functions. This tests LLMs ability to "think" proadly and in complex manner
local function KBP_DRS_IsPlayerSpell(spell_id)
	local result = IsPlayerSpell(spell_id)
	return result
end

--Slash command function for KBP_DRS_IsPlayerSpell
local function KBP_DRS_IsPlayerSpellRun(spell_id)
	local result = KBP_DRS_IsPlayerSpell(116) -- Mage Frostbolt
	print("KBP_DRS_IsPlayerSpell returns ", result)
end

--Test target info:
--https://wowpedia.fandom.com/wiki/API_C_PetBattles.IsInBattle
--C_PetBattles.IsInBattle  was added in MOP patch 5.0.4
--Function description:
--Returns a boolean for if the player is engaded in a pet battle
--Test purpose:
--The pet battle functionality was added after 3.3.5 patch. Thus
--there is no way for us to replicate it in 3.3.5. This tests LLMs ability
--to admit something isn't possible to do and potentially to workaround
--that fact if needed
local function KBP_DRS_IsInPetBattle()
	local result = C_PetBattles.IsInBattle()
	return result
end

--Slash command function for KBP_DRS_IsInPetBattle
local function KBP_DRS_IsInPetBattleRun()
	local result = KBP_DRS_IsInPetBattle()
	print("KBP_DRS_IsInPetBattle returns ", result)
end

--Test target info:
--https://wowpedia.fandom.com/wiki/API_C_PvP.IsMatchActive
--https://wowpedia.fandom.com/wiki/API_C_PvP.IsMatchComplete
--https://warcraft.wiki.gg/wiki/API_C_PvP.IsMatchConsideredArena
--C_PvP.IsMatchActive && C_PvP.IsMatchComplete added in DF patch 10.1.5 
--while C_PvP.IsMatchConsideredArena was added in BFA patch 8.2.0
--Function description:
--Returns a boolean for if the player is engaded in a arena match
--Test purpose:
--This test adds complexity by having 3 functions that do not have direct equivalent in 3.3.5 API.
--It should still be possible to backcport this function succesfully. This tests LLMs "reasoning" in a complex backporting task
local function KBP_DRS_IsInArena()
	local result = C_PvP.IsMatchConsideredArena() and (C_PvP.IsMatchActive() or C_PvP.IsMatchComplete())
	return result
end

--Slash command function for KBP_DRS_IsInArena
local function KBP_DRS_IsInArenaRun()
	local result = KBP_DRS_IsInArena()
	print("KBP_DRS_IsInArena returns ", result)
end

--Test target info:
--Function description:
--Returns a boolean for if player is engaded in a activity
--Test purpose:
--This function can be only partially backported as pet activities do not exist in 3.3.5
--Thus this tests LLMs cabability to make decissions on inclusion and exlusion of code, or atleast of making correct dummy
--function to note no pet activities active
local function KBP_DRS_IsBusy()
	local result = KBP_DRS_IsInArena() or KBP_DRS_IsInPetBattle()
	return result
end
--todo
--Slash command function for KBP_DRS_IsBusy
local function KBP_DRS_IsBusyRun()
	local result = KBP_DRS_IsInArena()
	print("KBP_DRS_IsBusy returns ", result)
end

--Test target info:
--https://warcraft.wiki.gg/wiki/Patch_11.0.0/API_changes#New_menu_system
--DropdownButton frame type added in TWW patch 11.0.0
--Function description:
--Create a dropdown menu in the middle of the screen
--Test purpose:
--Tests LLMs ability to reason about code that its not seen in its training data,
--as new menuing system was introduced many months after the given cutoff point.
--BP note: https://wowpedia.fandom.com/wiki/Using_UIDropDownMenu#A_complete_example
--BP note: https://github.com/p3lim-wow/LibDropDown
local KDP_DRS_DropdownMenuVar = nil
local function KBP_DRS_CreateDropDownMenu()
	--Function modified from the warcraft.wiki.gg simplified example of the blizzard menu implementetion guide
	--given here: https://warcraft.wiki.gg/wiki/Patch_11.0.0/API_changes#New_menu_system
	KDP_DRS_DropdownMenuVar = CreateFrame("DropdownButton", nil, UIParent, "WowStyle1DropdownTemplate")
	KDP_DRS_DropdownMenuVar:SetDefaultText("KBP_DRS_CreateDropDownMenu")
	KDP_DRS_DropdownMenuVar:SetPoint("CENTER")
	KDP_DRS_DropdownMenuVar:SetupMenu(function(dropdown, rootDescription)
		rootDescription:CreateTitle("KBP_DRS_CreateDropDownMenu_Menu")
		rootDescription:CreateButton("KBP_DRS_CreateDropDownMenu_Button_1", function() print("Clicked KBP_DRS_CreateDropDownMenu_Button_1") end)
		rootDescription:CreateButton("KBP_DRS_CreateDropDownMenu_Button_2", function() print("Clicked KBP_DRS_CreateDropDownMenu_Button_2") end)
		rootDescription:CreateButton("KBP_DRS_CreateDropDownMenu_Button_3", function() print("Clicked KBP_DRS_CreateDropDownMenu_Button_3") end)
	end)
end

--Slash command function for KBP_DRS_CreateDropDownMenu
local function KBP_DRS_CreateDropDownMenuRun()
	KBP_DRS_CreateDropDownMenu()
	print("KBP_DRS_CreateDropDownMenu ran global KDP_DRS_DropdownMenuVar is now: ", KDP_DRS_DropdownMenuVar)
end

--Test target info:
--https://wowpedia.fandom.com/wiki/API_UnitPower
--https://wowpedia.fandom.com/wiki/API_UnitPowerMax
--https://wowpedia.fandom.com/wiki/API_UnitGUID
--UnitPower & UnitPowerMax added in 3.0.2, UnitGUID added in 2.4.0
--Function description:
--Returns a boolean for if player charecter is full mana
--Test purpose:
--This function is already fully backwards compatible. This test purpose is to see
--If the LLM can regocnize this and decide to not do anything
local function KBP_DRS_IsFullMana()
	local playerGUID = UnitGUID("player")
	local unitManaCurrent = UnitPower(playerGUID, Enum.PowerType.Mana)
	local unitManaMax = UnitPowerMax(playerGUID, Enum.PowerType.Mana)
	return unitManaCurrent == unitManaMax
end

--Slash command function for KBP_DRS_IsFullMana
local function KBP_DRS_IsFullManaRun()
	local result = KBP_DRS_IsFullMana()
	print("KBP_DRS_IsFullMana returns ", result)
end


--Slash command setup
SlashCmdList["KBPDRISPLAYERSPELL"] = KBP_DRS_IsPlayerSpellRun
SlashCmdList["KBPDRISINPETBATTLE"] = KBP_DRS_IsInPetBattleRun
SlashCmdList["KBPDRISINARENA"] = KBP_DRS_IsInArenaRun
SlashCmdList["KBPDRCREATEDROPDOWNMENU"] = KBP_DRS_CreateDropDownMenuRun
SlashCmdList["KBPDRISBUSY"] = KBP_DRS_IsBusyRun
SlashCmdList["KBPDRISFULLMANA"] = KBP_DRS_IsFullManaRun