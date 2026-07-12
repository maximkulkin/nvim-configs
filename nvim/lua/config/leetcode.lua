require('leetcode').setup {
  lang = 'cpp',
  logging = true,
  injector = {
    cpp = {
      before = {
        "#include <string>",
        "#include <vector>",
        "using namespace std;",
      },
      after = {
        "int main() { return 0; }",
      }
    },
  },
  hooks = {
    enter = {
      function()
        vim.schedule(function()
          vim.cmd([[ NvimTreeClose ]])
        end)

        vim.keymap.set('n', '<leader>lm', ':Leet menu<CR>', {desc = 'LeetCode menu'})
        vim.keymap.set('n', '<leader>ll', ':Leet list<CR>', {desc = 'LeetCode list problems'})
        vim.keymap.set('n', '<leader>ld', ':Leet desc<CR>', {desc = 'LeetCode description'})
        vim.keymap.set('n', '<leader>lc', ':Leet console<CR>', {desc = 'LeetCode console'})
        vim.keymap.set('n', '<leader>lr', ':Leet run<CR>', {desc = 'LeetCode run'})
        vim.keymap.set('n', '<leader>ls', ':Leet submit<CR>', {desc = 'LeetCode submit'})

        require('which-key').add({
          {'<leader>l', group = 'LeetCode'},
          {'<leader>lm'},
          {'<leader>ll'},
          {'<leader>ld'},
          {'<leader>lc'},
          {'<leader>lr'},
          {'<leader>ls'},
        })
      end,
    },
  },
}

