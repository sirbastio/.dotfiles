-- Option+1 through Option+9 select window groups from left to right.
-- Returning to a group focuses its frontmost window.
-- Press the same shortcut again to cycle through overlapping windows.
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

local function focusWindowByPosition(index)
    -- Rebuild each time so moving, opening, or closing windows is reflected.
    local group = windowGroups()[index]
    if not group then
        hs.alert.show("No window group #" .. index)
        return
    end

    local focused = hs.window.focusedWindow()
    local focusedID = focused and focused:id()
    -- Cycle only when focus is already inside this group. Keep the stable ID
    -- order so groups of three or more don't bounce between just two windows.
    for i, entry in ipairs(group) do
        if entry.id == focusedID then
            group[i % #group + 1].window:focus()
            return
        end
    end

    -- Coming back from another group: preserve the current stacking order.
    -- This also respects windows selected using the mouse or other shortcuts.
    local frontmost = group[1]
    for _, entry in ipairs(group) do
        if entry.stackIndex < frontmost.stackIndex then
            frontmost = entry
        end
    end
    frontmost.window:focus()
end

-- Option + 1 through Option + 9
for i = 1, 9 do
    hs.hotkey.bind({"alt"}, tostring(i), function()
        focusWindowByPosition(i)
    end)
end
