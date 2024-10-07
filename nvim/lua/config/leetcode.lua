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

        vim.keymap.set('n', '<leader>lm', ':Leet menu<CR>')
        vim.keymap.set('n', '<leader>ll', ':Leet list<CR>')
        vim.keymap.set('n', '<leader>ld', ':Leet desc<CR>')
        vim.keymap.set('n', '<leader>lc', ':Leet console<CR>')
        vim.keymap.set('n', '<leader>lr', ':Leet run<CR>')
        vim.keymap.set('n', '<leader>ls', ':Leet submit<CR>')

        require('which-key').register({
          ['<leader>l'] = {
            name = 'Leetcoode',
            m = 'Leetcode Menu',
            l = 'Leetcode List',
            d = 'Leetcode Description',
            c = 'Leetcode Console',
            r = 'Leetcode Run',
            s = 'Leetcode Submit',
          },
        })
      end,
    },
  },
}

