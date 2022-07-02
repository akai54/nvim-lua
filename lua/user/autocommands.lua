vim.cmd([[
  augroup _general_settings
  autocmd!
  autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
  autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
  autocmd BufWinEnter * :set formatoptions-=cro
  autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
  autocmd!
  autocmd FileType gitcommit setlocal wrap
  autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
  autocmd!
  autocmd FileType markdown setlocal wrap
  autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
  autocmd!
  autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
  autocmd!
  autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

]])

local keymap = vim.api.nvim_buf_set_keymap
local Compile = vim.api.nvim_create_augroup("Compile", { clear = true })
local optn = { noremap = true, silent = true }

local c = vim.api.nvim_create_autocmd
local cpp = vim.api.nvim_create_autocmd
local go = vim.api.nvim_create_autocmd
local js = vim.api.nvim_create_autocmd

local lsp = vim.api.nvim_create_autocmd
local format = vim.api.nvim_create_autocmd
local code = vim.api.nvim_create_autocmd

function My_lsp_errors()
  vim.diagnostic.setloclist({ open = false })
end

function My_formatting()
  vim.lsp.buf.format()
end

function My_clear()
  keymap(0, "n", "<F9>", ":echo ''<CR>", optn)
end

local Auto_formatting = vim.api.nvim_create_augroup("Formating", { clear = true })
format("BufWritePre", { callback = My_formatting, group = Auto_formatting })

local LSP_errors = vim.api.nvim_create_augroup("LSP_errors", { clear = true })
lsp("BufWrite,BufEnter,InsertLeave *", { callback = My_lsp_errors, group = LSP_errors })

code("FileType", {
  pattern = "c",
  callback = function()
    keymap(0, "n", "<F12>", ":w !make && ./%:r<CR>", optn)
  end,
  group = Compile,
})

code("FileType", {
  pattern = "cpp",
  callback = function()
    keymap(0, "n", "<F12>", ":w !make && ./%:r<CR>", optn)
  end,
  group = Compile,
})

c("FileType", {
  pattern = "c",
  callback = function()
    keymap(
      0,
      "n",
      "<F9>",
      ":w <bar> exec '!gcc '.shellescape('%').' -std=c11 -Wall -Wextra -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>"
      ,
      optn
    )
  end,
  group = Compile,
})

cpp("FileType", {
  pattern = "cpp",
  callback = function()
    keymap(
      0,
      "n",
      "<F9>",
      ":w <bar> exec '!g++ '.shellescape('%').' -std=c++17 -Wall -Wextra -Werror -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>"
      ,
      optn
    )
  end,
  group = Compile,
})

go("FileType", {
  pattern = "go",
  callback = function()
    keymap(0, "n", "<F9>", ":w <bar> exec '!go run ' shellescape('%')<CR>", optn)
  end,
  group = Compile,
})

js("FileType", {
  pattern = "javascript",
  callback = function()
    keymap(0, "n", "<F9>", ":w<CR>:echo ''<CR>:w !node<CR>", optn)
    keymap(0, "v", "<F9>", ":w !node<CR>", optn)
  end,
  group = Compile,
})
