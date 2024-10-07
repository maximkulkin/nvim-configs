local scheduler = require("plenary.async").util.scheduler

local telescope = require('telescope')
local telescope_actions = require('telescope.actions')
local telescope_action_state = require('telescope.actions.state')
local telescope_finders = require('telescope.finders')
local telescope_pickers = require('telescope.pickers')
local telescope_previewers = require('telescope.previewers')
local telescope_make_entry = require('telescope.make_entry')
local telescope_entry_display = require('telescope.pickers.entry_display')
local telescope_config = require("telescope.config").values
local telescope_themes = require('telescope.themes')

local overseer = require('overseer')
local overseer_task_list = require('overseer.task_list')
local overseer_template = require('overseer.template')

overseer.setup {
  templates = { "builtin", "user.cmake", "user.run" },
  bindings = {
    -- Disable builtin
    ['<C-j>'] = false,
    ['<C-k>'] = false,
    ['<C-h>'] = false,
    ['<C-l>'] = false,
  },
}

local function task_status_icon(status)
  if status == 'PENDING' then
    return ''
  elseif status == 'SUCCESS' then
    return ''
  elseif status == 'FAILURE' then
    return ''
  elseif status == 'RUNNING' then
    return '󰄾'
  end
  return ''
end

local function overseer_templates_picker(opts)
  local make_template_entry = telescope_make_entry.gen_from_string({})
  local results = {}
  local templates_finder = setmetatable({
    results = results,
    make_entry = make_template_entry,
    close = function() end,
  }, {
    __call = function(_, _, process_result, process_complete)
      overseer_template.list({dir = ''}, function(templates)
        for i, v in ipairs(templates) do
          local name = make_template_entry(v.name)
          table.insert(results, name)

          if process_result(name) then
            break
          end

          if i % 1000 == 0 then
            scheduler()
          end
        end

        process_complete()
      end)
    end,
  })

  return telescope_pickers.new(opts, {
    prompt_title = 'Run Overseer Task',
    finder = templates_finder,
    sorter = telescope_config.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      telescope_actions.select_default:replace(function()
        telescope_actions.close(prompt_bufnr)
        local entry = telescope_action_state.get_selected_entry()
        overseer.run_template({name = entry.value})
      end)
      return true
    end,
  })
end

local function open_overseer_templates_picker()
  overseer_templates_picker(telescope_themes.get_dropdown()):find()
end

local function overseer_tasks_picker(opts)
  opts = opts or {}
  local displayer = telescope_entry_display.create {
    separator = ' ',
    items = {
      { width = 1 },
      { remaining = true },
    },
  }

  return telescope_pickers.new(opts, {
    prompt_title = 'Overseer Tasks',
    finder = telescope_finders.new_dynamic({
      fn = function()
        return overseer_task_list.list_tasks({recent_first = true})
      end,
      entry_maker = function(task)
        return {
          value = task,
          display = function(entry)
            local task = entry.value
            local hlgroup = 'Overseer' .. task.status

            return displayer({
              { task_status_icon(task.status), hlgroup },
              task.name,
            })
          end,
          ordinal = task.name,
        }
      end,
    }),
    sorter = telescope_config.generic_sorter(opts),
    previewer = telescope_previewers.new_buffer_previewer({
      define_preview = function(self, entry, status)
        vim.print(entry.value)
        local lines = {}
        if entry.value.strategy.bufnr ~= nil then
          lines = vim.api.nvim_buf_get_lines(entry.value.strategy.bufnr, 0, -1, false)
        end
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
      end,
    }),
    attach_mappings = function(prompt_bufnr, map)
      telescope_actions.select_default:replace(function()
        telescope_actions.close(prompt_bufnr)
        local entry = telescope_action_state.get_selected_entry()
        overseer.run_action(entry.value)
      end)
      return true
    end,
  })
end

local function open_overseer_tasks_picker()
  overseer_tasks_picker({
    layout_strategy = 'vertical',
    layout_config = {
      prompt_position = 'top',
    },
  }):find()
end

-- vim.keymap.set("n", "<leader>rr", function()
--   overseer.run_template({autostart = false, first = false})
-- end, {})
vim.keymap.set("n", "<leader>rr", open_overseer_templates_picker, {})
vim.keymap.set("n", "<leader>rt", open_overseer_tasks_picker, {})
vim.keymap.set("n", "<leader>ra", '<cmd>OverseerTaskAction<cr>', {})
vim.keymap.set("n", "<leader>rq", '<cmd>OverseerQuickAction<cr>', {})
vim.keymap.set("n", "<leader>ri", '<cmd>OverseerInfo<cr>', {})
vim.keymap.set("n", "<leader>rb", function()
  overseer.run_template({tags = {overseer.TAG.BUILD}})
end, {})

-- telescope.register_extension({
--   exports = {
--     overseer_tasks = overseer_tasks_picker(),
--   }
-- })

vim.api.nvim_create_autocmd({"VimEnter", "DirChanged"}, {
  callback = function(ev)
    local cwd = vim.v.cwd or vim.fn.getcwd()
    require("overseer").preload_task_cache({ dir = cwd })
  end,
})

require('which-key').register({
  ['<leader>r'] = {
    name = "Overseer",
    i = 'Overseer Info',
    r = 'Overseer Run',
    t = 'Overseer Tasks',
    b = 'Overseer Build',
    a = 'Overseer Task Action',
    q = 'Overseer Quick Action',
  },
})
