-- New leader commands:
-- TODO: Open tab terminal
-- TODO: Open TODO Telescope
-- TODO: Open TODO List

-- Features
-- FIX: TODO Highlight italic bug

local config = {

        -- Configure AstroNvim updates
        updater = {
                remote = "origin", -- remote to use
                channel = "nightly", -- "stable" or "nightly"
                version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
                branch = "main", -- branch name (NIGHTLY ONLY)
                commit = nil, -- commit hash (NIGHTLY ONLY)
                pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
                skip_prompts = false, -- skip prompts about breaking changes
                show_changelog = true, -- show the changelog after performing an update
                auto_reload = false, -- automatically reload and sync packer after a successful update
                auto_quit = false, -- automatically quit the current session after a successful update
                -- remotes = { -- easily add new remotes to track
                --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
                --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
                --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
                -- },
        },
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
        -- set vim options here (vim.<first_key>.<second_key> =  value)
        options = {
                opt = {
                        relativenumber = true, -- sets vim.opt.relativenumber
                },
                g = {
                        mapleader = " ", -- sets vim.g.mapleader
                },
        },

        -- Default theme configuration
        default_theme = {
                -- Modify the color table
                colors = {
                        fg = "#abb2bf",
                },
                plugins = { -- enable or disable extra plugin highlighting
                        aerial = true,
                        beacon = false,
                        bufferline = true,
                        dashboard = true,
                        highlighturl = true,
                        hop = false,
                        indent_blankline = true,
                        lightspeed = false,
                        ["neo-tree"] = true,
                        notify = true,
                        ["nvim-tree"] = false,
                        ["nvim-web-devicons"] = true,
                        rainbow = true,
                        symbols_outline = false,
                        telescope = true,
                        vimwiki = false,
                        ["which-key"] = true,
                },
        },



        -- Disable AstroNvim ui features
        ui = {
                nui_input = true,
                telescope_select = true,
        },

        -- Configure plugins
        plugins = {
                -- Add plugins, the packer syntax without the "use"
                init = {
                        -- You can disable default plugins as follows:
                        -- ["goolord/alpha-nvim"] = { disable = true },

                        -- You can also add new plugins here as well:
                        -- { "andweeb/presence.nvim" },
                        -- {
                        --   "ray-x/lsp_signature.nvim",
                        --   event = "BufRead",
                        --   config = function()
                        --     require("lsp_signature").setup()
                        --   end,
                        -- },
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
                -- All other entries override the require("<key>").setup({...}) call for default plugins
                ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
                        -- config variable is the default configuration table for the setup functino call
                        local null_ls = require "null-ls"
                        -- Check supported formatters and linters
                        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
                        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
                        config.sources = {
                                -- Set a formatter that is manually installed
                                null_ls.builtins.formatting.prettier,
                        }
                        return config -- return final config table to use in require("null-ls").setup(config)
                end,
                treesitter = { -- overrides `require("treesitter").setup(...)`
                        ensure_installed = { "lua" },
                },
                -- use mason-lspconfig to configure LSP installations
                ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
                        ensure_installed = { "sumneko_lua" },
                },
                -- use mason-null-ls to install and setup configure null-ls sources
                ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
                        ensure_installed = { "stylua" },
                },
                packer = { -- overrides `require("packer").setup(...)`
                        compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua",
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
                ["neo-tree"] = {
                        close_if_last_window = true,
                        popup_border_style = "rounded",
                        enable_git_status = true,
                        enable_diagnostics = false,
                        default_component_configs = {
                                indent = {
                                        indent_size = 2,
                                        padding = 0,
                                        with_markers = true,
                                        indent_marker = "│",
                                        last_indent_marker = "└",
                                        highlight = "NeoTreeIndentMarker",
                                        with_expanders = false,
                                        expander_collapsed = "",
                                        expander_expanded = "",
                                        expander_highlight = "NeoTreeExpander",
                                },
                                icon = {
                                        folder_closed = "",
                                        folder_open = "",
                                        folder_empty = "",
                                        default = "",
                                },
                                name = {
                                        trailing_slash = false,
                                        use_git_status_colors = true,
                                },
                                git_status = {
                                        symbols = {
                                                added = "",
                                                deleted = "",
                                                modified = "",
                                                renamed = "➜",
                                                untracked = "★",
                                                ignored = "◌",
                                                unstaged = "✗",
                                                staged = "✓",
                                                conflict = "",
                                        },
                                },
                        },
                        window = {
                                position = "left",
                                width = 25,
                                mappings = {
                                        ["<2-LeftMouse>"] = "open",
                                        ["<cr>"] = "open",
                                        ["o"] = "open",
                                        ["S"] = "open_split",
                                        ["s"] = "open_vsplit",
                                        ["C"] = "close_node",
                                        ["."] = "set_root",
                                        ["H"] = "toggle_hidden",
                                        ["R"] = "refresh",
                                        ["/"] = "fuzzy_finder",
                                        ["f"] = "filter_on_submit",
                                        ["<c-x>"] = "clear_filter",
                                        ["a"] = "add",
                                        ["d"] = "delete",
                                        ["r"] = "rename",
                                        ["y"] = "copy_to_clipboard",
                                        ["x"] = "cut_to_clipboard",
                                        ["p"] = "paste_from_clipboard",
                                        ["c"] = "copy",
                                        ["m"] = "move",
                                        ["q"] = "close_window",
                                },
                        },
                        nesting_rules = {},
                        filesystem = {
                                filtered_items = {
                                        visible = true,
                                        hide_dotfiles = true,
                                        hide_gitignored = true,
                                        hide_by_name = {
                                                ".DS_Store",
                                                "thumbs.db",
                                                "node_modules",
                                                "__pycache__",
                                        },
                                },
                                follow_current_file = true,
                                hijack_netrw_behavior = "open_current",
                                use_libuv_file_watcher = true,
                        },
                        buffers = {
                                show_unloaded = true,
                                window = {
                                        mappings = {
                                                ["bd"] = "buffer_delete",
                                        },
                                },
                        },
                        git_status = {
                                window = {
                                        position = "float",
                                        mappings = {
                                                ["A"] = "git_add_all",
                                                ["gu"] = "git_unstage_file",
                                                ["ga"] = "git_add_file",
                                                ["gr"] = "git_revert_file",
                                                ["gc"] = "git_commit",
                                                ["gp"] = "git_push",
                                                ["gg"] = "git_commit_and_push",
                                        },
                                },
                        },
                        event_handlers = {
                                {
                                        event = "vim_buffer_enter",
                                        handler = function(_)
                                                if vim.bo.filetype == "neo-tree" then vim.wo.signcolumn = "auto" end
                                        end,
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

        -- CMP Source Priorities
        -- modify here the priorities of default cmp sources
        -- higher value == higher priority
        -- The value can also be set to a boolean for disabling default sources:
        -- false == disabled
        -- true == 1000
        cmp = {
                source_priority = {
                        nvim_lsp = 1000,
                        luasnip = 750,
                        buffer = 500,
                        path = 250,
                },
        },

        -- Extend LSP configuration
        lsp = {
                -- enable servers that you already have installed without mason
                servers = {
                        -- "pyright"
                },
                -- easily add or disable built in mappings added during LSP attaching
                mappings = {
                        n = {
                                -- ["<leader>lf"] = false -- disable formatting keymap
                        },
                },
                -- add to the server on_attach function
                -- on_attach = function(client, bufnr)
                -- end,

                -- override the lsp installer server-registration function
                -- server_registration = function(server, opts)
                --   require("lspconfig")[server].setup(opts)
                -- end,

                -- Add overrides for LSP server settings, the keys are the name of the server
                ["server-settings"] = {
                        -- example for addings schemas to yamlls
                        -- yamlls = {
                        --   settings = {
                        --     yaml = {
                        --       schemas = {
                        --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
                        --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                        --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
                        --       },
                        --     },
                        --   },
                        -- },
                },
        },

        -- Diagnostics configuration (for vim.diagnostics.config({}))
        diagnostics = {
                virtual_text = true,
                underline = true,
        },

        -- Mapping data with "desc" stored directly by vim.keymap.set().
        --
        -- Please use this mappings table to set keyboard mapping since this is the
        -- lower level configuration and more robust one. (which-key will
        -- automatically pick-up stored data by this setting.)
        mappings = {
                -- first key is the mode
                n = {
                        -- second key is the lefthand side of the map
                        -- mappings seen under group name "Buffer"
                        ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
                        ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
                        ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
                        ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
                        -- quick save
                        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
                },
                t = {
                        -- setting a mapping to false will disable it
                        -- ["<esc>"] = false,
                },
        },

        -- Modify which-key registration (Use this with mappings table in the above.)
        ["which-key"] = {
                -- Add bindings which show up as group name
                register_mappings = {
                        -- first key is the mode, n == normal mode
                        n = {
                                -- second key is the prefix, <leader> prefixes
                                ["<leader>"] = {
                                        -- third key is the key to bring up next level and its displayed
                                        -- group name in which-key top level menu
                                        ["b"] = { name = "Buffer" },
                                },
                        },
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

                -- Set up custom filetypes
                -- vim.filetype.add {
                --   extension = {
                --     foo = "fooscript",
                --   },
                --   filename = {
                --     ["Foofile"] = "fooscript",
                --   },
                --   pattern = {
                --     ["~/%.config/foo/.*"] = "fooscript",
                --   },
                -- }
        end,
}

return config
