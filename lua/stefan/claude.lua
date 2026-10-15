-- Send the current file (or visual selection's line range) to the Claude agent
-- running in this tmux session, then jump to it. Agent windows are the ones
-- tagged with @agent_state by the Claude Code hooks (see ~/dotfiles).

local function find_agent_pane()
    local out = vim.fn.systemlist({
        "tmux", "list-panes", "-s", "-F", "#{window_activity}\t#{pane_id}\t#{@agent_state}\t#{pane_current_path}",
    })
    local best, best_activity
    for _, line in ipairs(out) do
        local activity, pane, state, path = line:match("^(%d+)\t([^\t]*)\t([^\t]*)\t(.*)$")
        if pane and state ~= "" and (not best_activity or tonumber(activity) > best_activity) then
            best, best_activity = { id = pane, cwd = path }, tonumber(activity)
        end
    end
    return best
end

local function send_to_claude(range)
    if not vim.env.TMUX then
        vim.notify("Not inside tmux", vim.log.levels.WARN)
        return
    end
    local file = vim.fn.expand("%:p")
    if file == "" then
        vim.notify("Buffer has no file", vim.log.levels.WARN)
        return
    end

    local function send(pane)
        local rel = file
        if vim.startswith(file, pane.cwd .. "/") then
            rel = file:sub(#pane.cwd + 2)
        end
        local text = "@" .. rel .. " "
        if range then
            text = text .. string.format("(lines %d-%d) ", range[1], range[2])
        end
        vim.fn.system({ "tmux", "send-keys", "-t", pane.id, "-l", text })
        vim.fn.system({ "tmux", "switch-client", "-t", pane.id })
    end

    local pane = find_agent_pane()
    if pane then
        send(pane)
        return
    end

    -- No agent in this session yet: start one at the repo root, then send once it is up
    local root = vim.fn.systemlist({ "git", "-C", vim.fn.expand("%:p:h"), "rev-parse", "--show-toplevel" })[1]
    if vim.v.shell_error ~= 0 then
        root = vim.fn.getcwd()
    end
    vim.fn.system({ "tmux", "run-shell", "-b", vim.fn.expand("~/.local/bin/agent-new") .. " " .. vim.fn.shellescape(root) })
    vim.defer_fn(function()
        local p = find_agent_pane()
        if p then
            send(p)
        end
    end, 2500)
end

vim.keymap.set("n", "<leader>ac", function()
    send_to_claude(nil)
end, { desc = "[A]sk [C]laude about this file" })

vim.keymap.set("v", "<leader>ac", function()
    local a, b = vim.fn.line("v"), vim.fn.line(".")
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
    send_to_claude({ math.min(a, b), math.max(a, b) })
end, { desc = "[A]sk [C]laude about selection" })
