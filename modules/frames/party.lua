--[[
    modules\frames\party.lua
    Styles and Repositions the Blizzard Party Frames.
]]
ImpUI_Party = ImpUI:NewModule('ImpUI_Party', 'AceEvent-3.0');

-- Get Locale
local L = LibStub('AceLocale-3.0'):GetLocale('ImprovedBlizzardUI');

-- Local Functions

-- Local Variables
local dragFrame;

--[[
	Applies the actual styling.
	
    @ return void
]]
function ImpUI_Party:StyleFrames()
    if (ImpUI.db.char.styleUnitFrames == false) then return; end

    -- Fonts
    local font = LSM:Fetch('font', ImpUI.db.char.primaryInterfaceFont);
    local _, _, flags = PlayerFrameHealthBarTextLeft:GetFont();
    local r, g, b, a = PlayerFrameHealthBarTextLeft:GetTextColor();

    -- Style Each Party Frame
    for i = 1, 4 do
        -- Update Fonts
        _G["PartyMemberFrame"..i.."Name"]:SetTextColor(r, g, b, a);
        _G["PartyMemberFrame"..i.."Name"]:SetFont(font, 10, flags);
        
        _G["PartyMemberFrame"..i.."HealthBarText"]:SetFont(font, 8, flags);
        _G["PartyMemberFrame"..i.."HealthBarTextLeft"]:SetFont(font, 8, flags);
        _G["PartyMemberFrame"..i.."HealthBarTextRight"]:SetFont(font, 8, flags);

        _G["PartyMemberFrame"..i.."ManaBarText"]:SetFont(font, 8, flags);
        _G["PartyMemberFrame"..i.."ManaBarTextLeft"]:SetFont(font, 8, flags);
        _G["PartyMemberFrame"..i.."ManaBarTextRight"]:SetFont(font, 8, flags);
    end
end

--[[
	Loads the position of the Party Frames from SavedVariables.
]]
function ImpUI_Party:LoadPosition()
    local pos = ImpUI.db.char.partyFramePosition;
    local scale = ImpUI.db.char.partyFrameScale;
    local offset = 0;
    
    -- Set Drag Frame Position
    dragFrame:SetPoint(pos.point, pos.relativeTo, pos.relativePoint, pos.x, pos.y);

    for i = 1, 4 do
        _G["PartyMemberFrame"..i]:SetMovable(true);
        _G["PartyMemberFrame"..i]:ClearAllPoints();
        _G["PartyMemberFrame"..i]:SetPoint('CENTER', dragFrame, 'BOTTOM', 0, 35 + offset);
        _G["PartyMemberFrame"..i]:SetScale(scale);
        _G["PartyMemberFrame"..i]:SetUserPlaced(true);
        _G["PartyMemberFrame"..i]:SetMovable(false);
        offset = offset + 60;
    end
end

--[[
	Called when unlocking the UI.
]]
function ImpUI_Party:Unlock()
    dragFrame:Show();
end

--[[
	Called when locking the UI.
]]
function ImpUI_Party:Lock()
    local point, relativeTo, relativePoint, xOfs, yOfs = dragFrame:GetPoint();

    ImpUI.db.char.partyFramePosition = Helpers.pack_position(point, relativeTo, relativePoint, xOfs, yOfs);

    dragFrame:Hide();
end

--[[
	Fires when the module is Initialised.
	
    @ return void
]]
function ImpUI_Party:OnInitialize()
end

--[[
	Fires when the module is Enabled. Set up frames, events etc here.
	
    @ return void
]]
function ImpUI_Party:OnEnable()
    -- Create Drag Frame and load position.
    dragFrame = Helpers.create_drag_frame('ImpUI_PartyFrame_DragFrame', 205, 350, L['Party Frames']);

    ImpUI_Party:LoadPosition();
end

--[[
	Clean up behind ourselves if needed.
	
    @ return void
]]
function ImpUI_Party:OnDisable()
end