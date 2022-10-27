local middot = '·'
local raquo = '»'
local small_l = 'l'

-- Override default `foldtext()`, which produces something like:
--
--   +---  2 lines: source $HOME/.config/nvim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim--------------------------------
--
-- Instead returning:
--
--   »··[2l]··: source $HOME/.config/nvim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim···································
--
local folding = function()
  local lines = '[' .. (vim.v.foldend - vim.v.foldstart + 1) .. small_l .. ']'
  local first = ({vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1, vim.v.foldstart, true)[1]:gsub(' *', '', 1)})[1]
  local dashes = ({vim.v.folddashes:gsub('-', middot)})[1]
  return raquo .. middot .. middot .. lines .. dashes .. ': ' .. first
end

return folding
