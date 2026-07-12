require('cmake-tools').setup({
  cmake_compile_commands_from_lsp = true,
  -- cmake_executor = {
  --   name = 'overseer',
  --   default_opts = {
  --   overseer = {
  --     new_task_opts = {
  --       strategy = {
  --         "toggleterm",
  --         direction = "horizontal",
  --         autos_croll = true,
  --         quit_on_exit = "success"
  --       }
  --     }, -- options to pass into the `overseer.new_task` command
  --     -- on_new_task = function()
  --     --   require("overseer").open(
  --     --     { enter = false, direction = "right" }
  --     --   )
  --     -- end,   -- a function that gets overseer.Task when it is created, before calling `task:start`
  --    },

  --   },
  -- },
  -- cmake_runner = {
  --   name = 'overseer',
  --   default_opts = {
  --     overseer = {
  --       new_task_opts = {
  --         strategy = {
  --           "toggleterm",
  --           direction = "horizontal",
  --           autos_croll = true,
  --           quit_on_exit = "success"
  --         }
  --       }, -- options to pass into the `overseer.new_task` command
  --     },
  --   },
  -- },
  cmake_build_directory = 'build',
  cmake_dap_configuration = { -- debug settings for cmake
    name = "cpp",
    type = "codelldb",
    request = "launch",
    stopOnEntry = false,
    runInTerminal = true,
    console = "integratedTerminal",
  },
  cmake_notifications = {
    runner = { enabled = true },
    executor = { enabled = true },
    spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
    refresh_rate_ms = 100, -- how often to iterate icons
  },
  cmake_virtual_text_support = true, -- Show the target related to current file using virtual text (at right corner)

})
