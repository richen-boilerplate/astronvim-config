-- New leader commands:
-- TODO: Open tab terminal
-- TODO: Open TODO Telescope
-- TODO: Open TODO List

local config = {

        -- Set colorscheme
        colorscheme = "onedark",
        -- Override highlight groups in any theme
        highlights = {
                -- duskfox = { -- a table of overrides
                --   Normal = { bg = "#000000" },
                -- },
                default_theme = function(hi) -- or a function that returns one
                        local C = require "default_theme.colors"
                        -- New approach instead of diagnostic_style
                        hi.DiagnosticError.italic = true
                        hi.DiagnosticHint.italic = true
                        hi.DiagnosticInfo.italic = true
                        hi.DiagnosticWarn.italic = true

                        hi.Normal = { bg = C.none, ctermbg = C.none }
                        return hi
                end,
        },


        -- -- Default theme configuration
        -- default_theme = {
        --         -- Modify the color table
        --         colors = {
        --                 fg = "#abb2bf",
        --         },
        --         plugins = { -- enable or disable extra plugin highlighting
        --                 aerial = true,
        --                 beacon = false,
        --                 bufferline = true,
        --                 dashboard = true,
        --                 highlighturl = true,
        --                 hop = false,
        --                 indent_blankline = true,
        --                 lightspeed = false,
        --                 ["neo-tree"] = true,
        --                 notify = true,
        --                 ["nvim-tree"] = false,
        --                 ["nvim-web-devicons"] = true,
        --                 rainbow = true,
        --                 symbols_outline = false,
        --                 telescope = true,
        --                 vimwiki = false,
        --                 ["which-key"] = true,
        --         },
        -- },


        -- Configure plugins
        plugins = {
                -- Add plugins, the packer syntax without the "use"
                init = {
                        {
                                "folke/todo-comments.nvim",
                                requires = "nvim-lua/plenary.nvim",
                                config = function()
                                        require("todo-comments").setup {
                                                signs = true, -- show icons in the signs column
                                                sign_priority = 8, -- sign priority
                                                -- keywords recognized as todo comments
                                                keywords = {
                                                        FIX = {
                                                                icon = " ", -- icon used for the sign, and in search results
                                                                color = "error", -- can be a hex color, or a named color (see below)
                                                                alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                                                                -- signs = false, -- configure signs for some keywords individually
                                                        },
                                                        TODO = { icon = " ", color = "info" },
                                                        HACK = { icon = " ", color = "warning" },
                                                        WARN = { icon = " ", color = "warning",
                                                                alt = { "WARNING", "XXX" } },
                                                        PERF = { icon = " ",
                                                                alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                                                        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                                                },
                                                merge_keywords = true, -- when true, custom keywords will be merged with the defaults
                                                -- highlighting of the line containing the todo comment
                                                -- * before: highlights before the keyword (typically comment characters)
                                                -- * keyword: highlights of the keyword
                                                -- * after: highlights after the keyword (todo text)
                                                highlight = {
                                                        before = "bg", -- "fg" or "bg" or empty
                                                        keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
                                                        after = "bg", -- "fg" or "bg" or empty
                                                        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
                                                        comments_only = true, -- uses treesitter to match keywords in comments only
                                                        max_line_len = 400, -- ignore lines longer than this
                                                        exclude = {}, -- list of file types to exclude highlighting
                                                },
                                                -- list of named colors where we try to extract the guifg from the
                                                -- list of hilight groups or use the hex color if hl not found as a fallback
                                                colors = {
                                                        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                                                        warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
                                                        info = { "DiagnosticInfo", "#2563EB" },
                                                        hint = { "DiagnosticHint", "#10B981" },
                                                        default = { "Identifier", "#7C3AED" },
                                                },
                                                search = {
                                                        command = "rg",
                                                        args = {
                                                                "--color=never",
                                                                "--no-heading",
                                                                "--with-filename",
                                                                "--line-number",
                                                                "--column",
                                                        },
                                                        -- regex that will be used to match keywords.
                                                        -- don't replace the (KEYWORDS) placeholder
                                                        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                                                        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
                                                },
                                        }
                                end,
                        },
                        {
                                "buidler-hub/react-nextjs-snippets",
                        },
                        {
                                "github/copilot.vim",
                        },
                        {
                                "navarasu/onedark.nvim",
                                as = "onedark",
                                config = function()
                                        require("onedark").setup {
                                                style = "darker",
                                                transparent = true,
                                        }
                                        require("onedark").load()
                                end,
                        },
                },
                  -- toggleterm needs to be extended by default to change default shell
                ["toggleterm"] = {
                        size = 10,
                        open_mapping = [[<c-\>]],
                        hide_numbers = true,
                        shade_filetypes = {},
                        shade_terminals = true,
                        shading_factor = 2,
                        start_in_insert = true,
                        insert_mappings = true,
                        persist_size = true,
                        direction = "float",
                        close_on_exit = true,
                        shell = "/bin/zsh",
                        float_opts = {
                                border = "curved",
                                winblend = 0,
                                highlights = {
                                        border = "Normal",
                                        background = "Normal",
                                },
                        },
                },
        },

        -- LuaSnip Options
        luasnip = {
                -- Add paths for including more VS Code style snippets in luasnip
                vscode_snippet_paths = {
                        "./lua/user/snippets",
                },
                -- Extend filetypes
                filetype_extend = {
                        javascript = { "javascriptreact", "html" },
                        typescript = { "typescriptreact", "html" },
                },
        },


        -- This function is run last
        -- good place to configuring augroups/autocommands and custom filetypes
        polish = function()
                -- Set key binding
                -- Copilot keybind
                vim.g.copilot_no_tab_map = true
                vim.api.nvim_set_keymap("i", "<S-Tab>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

                -- For performance reasons, lets remove copilot on certain filetypes
                vim.g.copilot_filetypes = {
                        ["*"] = false,
                        ["javascript"] = true,
                        ["typescript"] = true,
                        ["lua"] = false,
                        ["rust"] = true,
                        ["c"] = true,
                        ["c#"] = true,
                        ["c++"] = true,
                        ["go"] = true,
                        ["python"] = true,
                }
                -- Set autocommands
                vim.api.nvim_create_augroup("packer_conf", { clear = true })
                vim.api.nvim_create_autocmd("BufWritePost", {
                        desc = "Sync packer after modifying plugins.lua",
                        group = "packer_conf",
                        pattern = "plugins.lua",
                        command = "source <afile> | PackerSync",
                })


        end,
}

return config
