-- Create a new button type
UnitPopupButtons["ARMORY_LINK"] = { text = "Armory Link", dist = 0 };

local frame = CreateFrame("Frame", "ArmoryLinkFrame", UIParent, "UIPanelDialogTemplate");

-- Add it to the FRIEND and PLAYER menus as the 2nd to last option (before Cancel)
table.insert(UnitPopupMenus["FRIEND"], #UnitPopupMenus["FRIEND"]-1, "ARMORY_LINK");
table.insert(UnitPopupMenus["PLAYER"], #UnitPopupMenus["FRIEND"]-1, "ARMORY_LINK");

-- Hook ToggleDropDownMenu with your function
hooksecurefunc("ToggleDropDownMenu", Armory_Link_Setup);

-- Your function to setup your button
function Armory_Link_Setup(level, value, dropDownFrame, anchorName, xOffset, yOffset, menuList, button, autoHideDelay)
    -- Make sure we have what we need to continue
    if (dropDownFrame and level) then
        -- Just so we don't have to concat strings for each interval
        local buttonPrefix = "DropDownList" .. level .. "Button";
        -- Start at 2 because 1 is always going to be the title (i.e. player name) in our case
        local i = 2;
        while (1) do
            -- Get the button at index i in the dropdown
            local button = _G[buttonPrefix..i];
            if (not button) then break end;
            -- If the button is our button...
            if (button:GetText() == UnitPopupButtons["ARMORY_LINK"].text) then
                -- Make it execute function for player that this menu popped up for (button at index 1)
                button.func = function()
					-- Function for the button
				end
                -- Break the loop; we got what we were looking for.
                break;
            end
            i = i + 1;
        end
    end
end