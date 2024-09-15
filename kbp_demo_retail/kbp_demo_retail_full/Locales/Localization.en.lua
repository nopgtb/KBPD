--Retrieve global variables passed to the addon
local addonName, addonTable = ...
if GetLocale() ~= "enUS" then return end
--Setup for english translations
--https://wowwiki-archive.fandom.com/wiki/Localizing_an_addon#An_Example

addonTable["KBP_DRF_PET_BATTLE_ENTERING"] = "Player is now entering a pet battle!"
addonTable["KBP_DRF_ENTERING_NEW_ZONE"] = "Player is now entering a new zone:"
addonTable["KBP_DRF_LOW_MANA_WARNING"] = "You are low on mana! Current mana %:"
