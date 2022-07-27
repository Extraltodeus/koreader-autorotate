--[[--
This plugin rotates the pages according to their aspect ratio.

@module koplugin.autorotate
--]]--
local Device = require("device")
local WidgetContainer = require("ui/widget/container/widgetcontainer")
local Screen = Device.screen
local Event = require("ui/event")
local UIManager = require("ui/uimanager")
local ReaderZooming = require("apps/reader/modules/readerzooming")
local _ = require("gettext")

local AutoRotate = WidgetContainer:new{
    name = "AutoRotate",
}

function AutoRotate:onPageUpdate(page)
  local page_size = self.ui.document:getNativePageDimensions(page)
  rot = Device.screen:getRotationMode()
  if (page_size.w > page_size.h) and (rot ~= Screen.ORIENTATION_LANDSCAPE) then
    UIManager:broadcastEvent(Event:new("SetRotationMode", Screen.ORIENTATION_LANDSCAPE))
  else
    if (rot ~= Screen.ORIENTATION_PORTRAIT) then
      UIManager:broadcastEvent(Event:new("SetRotationMode", Screen.ORIENTATION_PORTRAIT))
    end
  end
end

return AutoRotate
