--[[--
This plugin rotates the pages according to their aspect ratio.

@module koplugin.autorotate
--]]--
local Device = require("device")
local WidgetContainer = require("ui/widget/container/widgetcontainer")
local Screen = Device.screen
local Event = require("ui/event")
local UIManager = require("ui/uimanager")
local _ = require("gettext")
local logger = require("logger")

local AutoRotate = WidgetContainer:new{
    name = "AutoRotate",
}

last_portrait = Screen.DEVICE_ROTATED_UPRIGHT

function AutoRotate:onPageUpdate(page)
  local page_size = self.ui.document:getNativePageDimensions(page)
  rotation = Screen:getRotationMode()
  
  if (rotation == Screen.DEVICE_ROTATED_UPRIGHT or rotation == Screen.DEVICE_ROTATED_UPSIDE_DOWN) then
	last_portrait = rotation
	logger.dbg("[AutoRotate] Rotating updating last portrait rotation")
  end

  if (page_size.w > page_size.h and rotation ~= Screen.DEVICE_ROTATED_CLOCKWISE) then
    logger.dbg("[AutoRotate] Rotating clockwise")
    UIManager:broadcastEvent(Event:new("SetRotationMode", Screen.DEVICE_ROTATED_CLOCKWISE))
  elseif (page_size.h > page_size.w and (rotation ~= Screen.DEVICE_ROTATED_UPRIGHT or rotation ~= Screen.DEVICE_ROTATED_UPSIDE_DOWN)) then
    logger.dbg("[AutoRotate] Rotating upright")
    UIManager:broadcastEvent(Event:new("SetRotationMode", last_portrait))
  else
    -- logger.dbg("[AutoRotate] Not doing anything")
  end
end

return AutoRotate
