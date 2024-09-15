--Retrieve global variables passed to the addon
local addonName, addonTable = ...
--Setup the addontable to support translation fetching
--https://wowwiki-archive.fandom.com/wiki/Localizing_an_addon#An_Example
--Any non existing translation, defaults to return the fetch key itself
setmetatable(addonTable, {__index=function(t,k) return k end})