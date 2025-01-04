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

function AutoRotate:onPageUpdate(page)
  local page_size = self.ui.document:getNativePageDimensions(page)
  rotation = Screen:getRotationMode()

  if (page_size.w > page_size.h and rotation ~= Screen.DEVICE_ROTATED_CLOCKWISE) then
    logger.dbg("[AutoRotate] Rotating clockwise")
    UIManager:broadcastEvent(Event:new("SetRotationMode", Screen.DEVICE_ROTATED_CLOCKWISE))
  elseif (page_size.h > page_size.w and rotation ~= Screen.DEVICE_ROTATED_UPRIGHT) then
    logger.dbg("[AutoRotate] Rotating upright")
    UIManager:broadcastEvent(Event:new("SetRotationMode", Screen.DEVICE_ROTATED_UPRIGHT))
  else
    -- logger.dbg("[AutoRotate] Not doing anything")
  end
end

return AutoRotate
