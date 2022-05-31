vim.cmd([[
try
  colorscheme 2077
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=none
endtry
]])
