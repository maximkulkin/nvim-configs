local overseer = require('overseer')

local function get_cmakelists(opts)
  return vim.fs.find('CMakeLists.txt', { upward = true, type = 'file', path = opts.dir })[1]
end

return {
  cache_key = function(opts)
    return get_cmakelists(opts)
  end,
  condition = {
    callback = function(opts)
      if vim.fn.executable("cmake") == 0 then
        return false, 'Command "cmake" not found'
      end
      if not get_cmakelists(opts) then
        return false, 'No CMakeLists.txt found'
      end
      return true
    end,
  },
  generator = function(opts, cb)
    local cmakelists = get_cmakelists(opts)

    cb({
      {
        name = "cmake build",
        builder = function(_)
          return {
            cmd = { "cmake" },
            args = { "-B", "build" },
            cwd = vim.fs.dirname(cmakelists),
            components = {
              { "open_output", direction = "float", focus = true, on_complete = "failure", },
              "on_exit_set_status",
              "display_duration",
            },
          }
        end,
        tags = {overseer.TAG.BUILD},
      },
    })
  end,
}
