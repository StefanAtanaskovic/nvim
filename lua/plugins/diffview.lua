return { -- Side-by-side review of the working tree diff (what the agent changed)
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffReview" },
    keys = {
        { "<leader>gd", "<CMD>DiffviewOpen<CR>", desc = "[G]it [D]iff view" },
        { "<leader>gh", "<CMD>DiffviewFileHistory %<CR>", desc = "[G]it file [H]istory" },
    },
    config = function()
        require("diffview").setup({
            keymaps = {
                view = { { "n", "q", "<CMD>DiffviewClose<CR>", { desc = "Close diffview" } } },
                file_panel = { { "n", "q", "<CMD>DiffviewClose<CR>", { desc = "Close diffview" } } },
                file_history_panel = { { "n", "q", "<CMD>DiffviewClose<CR>", { desc = "Close diffview" } } },
            },
        })

        -- Used by the tmux Alt+D popup: open the diff, quit nvim when it is closed with q
        vim.api.nvim_create_user_command("DiffReview", function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "DiffviewViewClosed",
                once = true,
                callback = function()
                    vim.schedule(function()
                        vim.cmd("confirm qa")
                    end)
                end,
            })
            vim.cmd("DiffviewOpen")
        end, { desc = "Diffview that quits nvim on close" })
    end,
}
