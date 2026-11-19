-- Ctrl+h/j/k/l: Neovim split -> Rex pane -> macOS window (via Hammerspoon).
-- These programs get the key first; Neovim hands off through the navigate action at its edge.
-- ssh and tmux get it too, so the remote Neovim and nested panes can navigate.
local terminal = "com.superlogical.terminal"
local lazygitLabel = "lazygit"
local handlesNavigation = {
    vi = true, vim = true, nvim = true, lvim = true, gvim = true, view = true,
    vimdiff = true, nvimdiff = true, fzf = true, ssh = true, tmux = true,
}

-- The server starts from launchd's PATH, which doesn't include Homebrew.
local hammerspoonEnv = { PATH = "/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin" }

local function activeWindow(view)
    for _, window in ipairs(view.windows) do
        if window.window_id == view.active_window_id then return window end
    end
end

-- Move to the Rex pane in a direction. At the window edge (or when zoomed),
-- hand off to Hammerspoon to focus the macOS window in that direction instead.
local function navigate(direction)
    local view = rex.session.view{}
    local window = view and activeWindow(view)
    if not window then return end

    if not window.zoomed_block_id then
        -- The revision only changes if focus actually moved.
        local moved = rex.session.focus_direction{ direction = direction }
        if moved and moved.revision ~= view.revision then return end
    end
    rex.exec({ "hs", "-q", "-c", "navigateWindow('" .. direction .. "')" }, { env = hammerspoonEnv })
end

rex.action{
    name = "navigate",
    title = "Move to Pane or Window",
    args = { direction = "string" },
    run = function(_, args) navigate(args.direction) end,
}

-- Alt+Cmd+G toggles lazygit in a float over the focused pane's directory.
rex.action{
    name = "lazygit",
    title = "Toggle Lazygit",
    run = function()
        local view = rex.session.view{}
        local window = view and activeWindow(view)
        if not window then return end

        for _, layer in ipairs(window.layers) do
            if layer.kind ~= "tiled" and layer.blocks[1] and layer.blocks[1].label == lazygitLabel then
                rex.session.close_layer{ layer_id = layer.layer_id }
                return
            end
        end

        local process = rex.block.call(terminal, "process", {})
        local foreground = process and process.foreground
        local _, err = rex.session.new_layer{
            bounds = { 0.05, 0.05, 0.9, 0.9 },
            focus = true,
            layout = rex.layout.block{
                flavor = terminal .. ".shell",
                label = lazygitLabel,
                options = { command = { "lazygit" }, cwd = foreground and foreground.cwd },
            },
        }
        if err ~= nil then error(err, 0) end
    end,
}
rex.bind("alt+cmd+g", "lazygit")

for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
    rex.bind("ctrl+" .. key, function()
        local process = rex.block.call(terminal, "process", {})
        local foreground = process and process.foreground
        if foreground and handlesNavigation[foreground.name] then return false end
        navigate(direction)
        return true
    end)
end
