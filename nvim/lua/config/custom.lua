local function comment_code(start_line, end_line, comment_char)
  local comment_chars = {
    python = '#',
    javascript = '//',
    typescript = '//',
    typescriptreact = '//',
    lua = '--',
    sh = '#',
    bash = '#',
    zsh = '#',
    fish = '#',
    rust = '//',
    go = '//',
    c = '//',
    cpp = '//',
    java = '//',
    kotlin = '//',
    scala = '//',
    php = '//',
    ruby = '#',
    vim = '"',
    viml = '"',
    yaml = '#',
    toml = '#',
    json = '//',
    html = '<!--',
    xml = '<!--',
    css = '/*',
    scss = '/*',
    sass = '/*',
    less = '/*',
    markdown = '#',
  }

  local filetype = vim.bo.filetype
  local comment_string = comment_chars[filetype] or '#'
  local comment_pattern = "^%s*" .. vim.pesc(comment_string)
  comment_string = comment_string .. " "

  start_line = start_line - 1
  end_line = end_line - 1


  for i = start_line, end_line do
    local line = vim.api.nvim_buf_get_lines(0, i, i + 1, false)[1]
    local leading_whitespace = line:match("^(%s*)")

    if line:match(comment_pattern) then
      local uncommented_line = line:gsub(comment_pattern, "", 1)
      vim.api.nvim_buf_set_lines(0, i, i + 1, false, { uncommented_line })
    else
      if filetype == "html" then
        vim.api.nvim_buf_set_lines(0, i, i + 1, false,
          { leading_whitespace .. comment_string .. line:sub(#leading_whitespace + 1) .. " -->" })
      else
        vim.api.nvim_buf_set_lines(0, i, i + 1, false,
          { leading_whitespace .. comment_string .. line:sub(#leading_whitespace + 1) })
      end
    end
  end
end

vim.api.nvim_create_user_command(
  "CommentCode",
  function(range)
    comment_code(range.line1, range.line2)
  end,
  { range = true }
)

local function start_lazygit()
  local ui = vim.api.nvim_list_uis()[1]
  local width = math.floor(ui.width * 0.9)
  local height = math.floor(ui.height * 0.9)
  local col = math.floor((ui.width - width) / 2)
  local row = math.floor((ui.height - height) / 2)
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal'
  }
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_command('terminal lazygit')
  vim.api.nvim_command('startinsert')
end

vim.api.nvim_create_user_command("LazyGit", start_lazygit, {})
