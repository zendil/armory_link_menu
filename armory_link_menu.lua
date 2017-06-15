--Localization Tables
local L
if GetLocale() == "enUS" then
	L = --@localization(locale="enUS", format="lua_table", handle-unlocalized="english", handle-subnamespaces="concat")@
elseif GetLocale() == "esMX" then
	L = --@localization(locale="enUS", format="lua_table", handle-unlocalized="english", handle-subnamespaces="concat")@
elseif GetLocale() == "esMX" then
	L = --@localization(locale="enUS", format="lua_table", handle-unlocalized="english", handle-subnamespaces="concat")@
elseif GetLocale() == "esMX" then
	L = --@localization(locale="enUS", format="lua_table", handle-unlocalized="english", handle-subnamespaces="concat")@
elseif GetLocale() == "esMX" then
	L = --@localization(locale="enUS", format="lua_table", handle-unlocalized="english", handle-subnamespaces="concat")@
elseif GetLocale() == "esMX" then
	L = --@localization(locale="enUS", format="lua_table", handle-unlocalized="english", handle-subnamespaces="concat")@
elseif GetLocale() == "esMX" then
	L = --@localization(locale="enUS", format="lua_table", handle-unlocalized="english", handle-subnamespaces="concat")@
elseif GetLocale() == "esMX" then
	L = --@localization(locale="enUS", format="lua_table", handle-unlocalized="english", handle-subnamespaces="concat")@
elseif GetLocale() == "esMX" then
	L = --@localization(locale="enUS", format="lua_table", handle-unlocalized="english", handle-subnamespaces="concat")@
elseif GetLocale() == "esMX" then
	L = --@localization(locale="enUS", format="lua_table", handle-unlocalized="english", handle-subnamespaces="concat")@
elseif GetLocale() == "esMX" then
	L = --@localization(locale="enUS", format="lua_table", handle-unlocalized="english", handle-subnamespaces="concat")@
elseif GetLocale() == "esMX" then
	L = --@localization(locale="enUS", format="lua_table", handle-unlocalized="english", handle-subnamespaces="concat")@
elseif GetLocale() == "esMX" then
	L = --@localization(locale="enUS", format="lua_table", handle-unlocalized="english", handle-subnamespaces="concat")@
else
	--No locale or error locale
end
if not type(L) == "table" then
	--failsafe locale table
	L = {
		["Armory Link"] = "Armory Link",
		["Okay"] = "Okay"
	}
-- Create a new button type
UnitPopupButtons["ARMORY_LINK"] = { text = "Armory Link", dist = 0 }

local frame = CreateFrame("Frame", "ArmoryLinkFrame", UIParent, "UIPanelDialogTemplate")
local edit = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
local button = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")

frame.edit = edit
frame.button = button

local sitestable = {
	--NA Region
	["enUS"] = "https://worldofwarcraft.com/en-us/character/",
	["esMX"] = "https://worldofwarcraft.com/es-mx/character/",
	["ptBR"] = "https://worldofwarcraft.com/pt-br/character/",
	--EU Region
	["enGB"] = "https://worldofwarcraft.com/en-gb/character/",
	["frFR"] = "https://worldofwarcraft.com/fr-fr/character/",
	["deDE"] = "https://worldofwarcraft.com/de-de/character/",
	["itIT"] = "https://worldofwarcraft.com/it-it/character/",
	["esES"] = "https://worldofwarcraft.com/es-es/character/",
	["ruRU"] = "https://worldofwarcraft.com/ru-ru/character/",
	--Asian Regions
	["koKR"] = "https://worldofwarcraft.com/ko-kr/character/",
	["zhCN"] = "https://worldofwarcraft.com/zh-cn/character/", --Wrong site, blame censorship
	["zhTW"] = "https://worldofwarcraft.com/zh-tw/character/",
}
local site = sitestable[GetLocale()]

--Frame Setup
frame:Hide()
frame:SetHeight(100)
frame:SetWidth(450)
frame:SetPoint("CENTER", UIParent, "TOP", 0, -1 * GetScreenHeight() / 4)
frame:EnableKeyboard(false)
frame.Title:SetText("Armory Link")
frame:SetMovable(true)
frame:SetScript("OnShow", function(self) self.edit:SetFocus() end)
frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
frame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
frame:RegisterForDrag("LeftButton")
frame:EnableMouse(true)

--Editbox Setup
edit:SetPoint("TOPLEFT", frame, "LEFT", 30, 8)
edit:SetPoint("BOTTOMRIGHT", frame, "RIGHT", -30, -8)
edit:SetScript("OnEnterPressed", function(self) ArmoryLinkFrameClose:Click() end)
edit:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
edit:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
edit:SetAutoFocus(false)

--Button Setup
button:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
button:SetHeight(20)
button:SetWidth(50)
button:SetText("Okay")
button:SetScript("OnClick", function() ArmoryLinkFrameClose:Click() end)

-- Add it to the FRIEND and PLAYER menus as the 2nd to last option (before Cancel)
table.insert(UnitPopupMenus["FRIEND"], #UnitPopupMenus["FRIEND"], "ARMORY_LINK")
table.insert(UnitPopupMenus["PLAYER"], #UnitPopupMenus["PLAYER"], "ARMORY_LINK")
table.insert(UnitPopupMenus["SELF"], #UnitPopupMenus["SELF"], "ARMORY_LINK")

-- Your function to setup your button
function Armory_Link_Setup(level, value, dropDownFrame, anchorName, xOffset, yOffset, menuList, button, autoHideDelay)
    -- Make sure we have what we need to continue
    if (dropDownFrame and level) then
		
        -- Just so we don't have to concat strings for each interval
        local buttonPrefix = "DropDownList" .. level .. "Button"
        -- Start at 2 because 1 is always going to be the title (i.e. player name) in our case
        local i = 2
        while (1) do
            -- Get the button at index i in the dropdown
            local button = _G[buttonPrefix..i]
            if (not button) then break end
            -- If the button is our button...
            if (button:GetText() == UnitPopupButtons["ARMORY_LINK"].text) then
                -- Make it execute function for player that this menu popped up for (button at index 1)
                button.func = function()
					-- Function for the button
					--Get the name and realm
					local name = dropDownFrame.name:lower()
					local server = dropDownFrame.server or GetRealmName()
					server = server:gsub(" ", "-"):gsub("'", ""):lower()
					--Set edit box
					edit:SetText(site..server.."/"..name)
					frame:Show()
				end
                -- Break the loop; we got what we were looking for.
                break
            end
            i = i + 1
        end
    end
end

-- Hook ToggleDropDownMenu with your function
hooksecurefunc("ToggleDropDownMenu", Armory_Link_Setup);