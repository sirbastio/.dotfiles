-- Windows that overlap enough form a group in one spot on screen.
-- Ctrl+h/j/k/l move between groups; Ctrl+I cycles through the current one.
local overlapThreshold = 0.60

local function samePosition(a, b)
    local width = math.max(0, math.min(a.x + a.w, b.x + b.w) - math.max(a.x, b.x))
    local height = math.max(0, math.min(a.y + a.h, b.y + b.h) - math.max(a.y, b.y))
    -- The intersection must cover at least 60% of each window's area.
    local largerArea = math.max(a.w * a.h, b.w * b.h)
    return largerArea > 0 and width * height / largerArea >= overlapThreshold
end

local function windowGroups()
    local windows = {}
    for stackIndex, win in ipairs(hs.window.orderedWindows()) do
        if win:isStandard() and not win:isMinimized() then
            local id = win:id()
            if id then
                table.insert(windows, {
                    window = win, id = id, frame = win:frame(), stackIndex = stackIndex,
                })
            end
        end
    end

    -- Stable position ordering, independent of which window is in front.
    table.sort(windows, function(a, b)
        if a.frame.x ~= b.frame.x then return a.frame.x < b.frame.x end
        if a.frame.y ~= b.frame.y then return a.frame.y < b.frame.y end
        return a.id < b.id
    end)

    local groups = {}
    local assigned = {}
    for i, entry in ipairs(windows) do
        if not assigned[i] then
            local group = { entry }
            assigned[i] = true
            local memberIndex = 1
            -- Follow qualifying overlaps, including chains: if A overlaps B
            -- by at least 60% and B overlaps C by at least 60%, group all three.
            while memberIndex <= #group do
                local member = group[memberIndex]
                for j, candidate in ipairs(windows) do
                    if not assigned[j] and samePosition(member.frame, candidate.frame) then
                        assigned[j] = true
                        table.insert(group, candidate)
                    end
                end
                memberIndex = memberIndex + 1
            end
            table.insert(groups, group)
        end
    end

    -- Keep cycling order stable even if focusing changes the stacking order.
    for _, group in ipairs(groups) do
        table.sort(group, function(a, b) return a.id < b.id end)
    end
    return groups
end

-- The group member highest in the current stacking order.
local function frontmostEntry(group)
    local frontmost = group[1]
    for _, entry in ipairs(group) do
        if entry.stackIndex < frontmost.stackIndex then
            frontmost = entry
        end
    end
    return frontmost
end

-- Focus the next window in the group if it holds the focused window.
-- Keep the stable ID order so groups of three or more don't bounce between
-- just two windows. Returns false when focus is outside the group.
local function cycleGroup(group)
    local focused = hs.window.focusedWindow()
    local focusedID = focused and focused:id()
    for i, entry in ipairs(group) do
        if entry.id == focusedID then
            group[i % #group + 1].window:focus()
            return true
        end
    end
    return false
end

-- Ctrl + I cycles the overlapping windows in the focused window's group.
-- Bound everywhere, Ghostty included.
hs.hotkey.bind({"ctrl"}, "i", function()
    -- Rebuild each time so moving, opening, or closing windows is reflected.
    for _, group in ipairs(windowGroups()) do
        if cycleGroup(group) then return end
    end
end)

-- Ctrl+h/j/k/l focus the nearest window group in that direction.
-- Ghostty keeps these keys so Neovim splits and tmux panes move first;
-- at their edge they hand off via `open -g hammerspoon://navigate?dir=left`.
local terminalBundleID = "com.mitchellh.ghostty"
local directionKeys = { h = "left", j = "down", k = "up", l = "right" }

local function focusWindowInDirection(direction)
    local focused = hs.window.focusedWindow()
    if not focused then return end
    local focusedID = focused:id()

    -- Only the frontmost window of each other group is a candidate, so
    -- windows stacked under the focused one are skipped (Ctrl+I cycles those).
    local candidates = {}
    for _, group in ipairs(windowGroups()) do
        local inGroup = false
        for _, entry in ipairs(group) do
            if entry.id == focusedID then inGroup = true end
        end
        if not inGroup then
            table.insert(candidates, frontmostEntry(group).window)
        end
    end

    local focusMethods = {
        left = focused.focusWindowWest, down = focused.focusWindowSouth,
        up = focused.focusWindowNorth, right = focused.focusWindowEast,
    }
    local focusMethod = focusMethods[direction]
    if focusMethod then focusMethod(focused, candidates) end
end

local directionHotkeys = {}
for key, direction in pairs(directionKeys) do
    table.insert(directionHotkeys, hs.hotkey.new({"ctrl"}, key, function()
        focusWindowInDirection(direction)
    end))
end

local function updateDirectionHotkeys(app)
    local inTerminal = app ~= nil and app:bundleID() == terminalBundleID
    for _, hotkey in ipairs(directionHotkeys) do
        if inTerminal then hotkey:disable() else hotkey:enable() end
    end
end

-- Global so the watcher isn't garbage collected.
directionAppWatcher = hs.application.watcher.new(function(_, event, app)
    if event == hs.application.watcher.activated then
        updateDirectionHotkeys(app)
    end
end):start()
updateDirectionHotkeys(hs.application.frontmostApplication())

hs.urlevent.bind("navigate", function(_, params)
    focusWindowInDirection(params.dir)
end)
