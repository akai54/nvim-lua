local opts = { noremap = true, silent = true }
local optn = { noremap = true, silent = false }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<S-Up>", ":resize -2<CR>", opts)
keymap("n", "<S-Down>", ":resize +2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Saving & Quitting
keymap("n", "<Leader>w", ":w<CR>", opts)
keymap("n", "<Leader>q", ":Bdelete<CR>", optn)

-- Reload lua file
keymap("n", "<Leader>5", ":luafile %<CR>", optn)

-- Undotree
keymap("n", "<Leader>u", ":UndotreeShow<CR>", opts)

-- Language suggestions
keymap("n", "<Leader><BS>", "z=", opts)

-- QuickFix List
keymap("n", "<C-o>", ":copen<CR>", opts)
keymap("n", "<C-q>", ":cclose<CR>", opts)
keymap("n", "<A-h>", ":cprev<CR>", opts)
keymap("n", "<A-j>", ":cnext<CR>", opts)

-- LocalFix List
keymap("n", "<S-l>", ":lopen<CR>", optn)
keymap("n", "<S-q>", ":lclose<CR>", optn)
keymap("n", "<S-j>", ":lnext<CR>", opts)
keymap("n", "<S-k>", ":lprevious<CR>", opts)

-- Indent the Whole buffer
keymap("n", "<F10>", "ggVG=<C-o>", opts)

-- Telescope
keymap("n", "<Leader>ts", ":Telescope live_grep<CR>", opts)
keymap("n", "<Leader>tw", ":Telescope grep_string<CR>", opts)
keymap("n", "<Leader>tf", ":Telescope find_files<CR>", opts)
keymap("n", "<Leader>tc", ":Telescope git_commits previewer=false<CR><CR>", opts)
keymap("n", "<Leader>tb", ":Telescope git_branches previewer=false<CR>", opts)
keymap("n", "<Leader>tr", ":Telescope oldfiles<CR>", opts)
keymap("n", "<Leader>tp", ":Telescope projects<CR>", opts)
keymap("n", "<Leader>tt", ":Telescope buffers<CR>", opts)

-- Fugitive
keymap("n", "<Leader>gs", ":G<CR>", opts)
keymap("n", "<Leader>gl", ":Gclog<CR>", opts)
keymap("n", "<Leader>gb", ":Git blame<CR>", opts)
keymap("n", "<Leader>gc", ":Git commit<CR>", opts)
keymap("n", "<Leader>gp", ":Git push<CR>", opts)
keymap("n", "<Leader>gf", ":Git fetch --all<CR>", opts)
keymap("n", "<Leader>gm", ":Git merge<CR>", opts)

--[[ This will:
Rename your file on disk.
Rename the file in git repo.
Reload the file into the current buffer.
Preserve undo history." ]]
keymap("n", "<Leader>gn", ":GMove", opts)

--[[ If you want add a file to the .gitignore from the gitstatus window, just
press any number followd by g and I then save&quit the .gitignore. ]]

--[[ When trying to resolve merge conflicts, check the status then go to
the unstaged file with the conflict and press dv.
You shall see 3 sides.
The first one is the file on your local branch.
The last one is the file from the repo.
The one in the middle is the result file.
Once you're finished do ctrl+w ctrl+o. ]]

--[[ When trying to resolve merge conflicts, check the status then if you only
want the repo file to replace the local file then press X then s.
But if you the local file over the repo's one then press x then s. ]]

-- Choose which side to pick from Right or Left when resolving merge conflicts
keymap("n", "<Leader>ga", ":diffget //2<CR>", opts)
keymap("n", "<Leader>g;", ":diffget //3<CR>", opts)

-- Fine Command-Line
keymap("n", ":", ":FineCmdline<CR>", opts)
keymap("v", ":", ":<C-u>FineCmdline '<,'><CR>", opts)

--Fine Search box
keymap("n", "/", ":SearchBoxIncSearch<CR>", opts)

-- Nvimtree
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", opts)

-- Hop
keymap("n", "<Leader>hw", ":HopWord<CR>", optn) -- Highlight words
keymap("n", "<Leader>hl", ":HopLine<CR>", optn) -- Highlight beginning of each line
keymap("n", ",", ":HopChar1<CR>", optn) -- Highlight 1 char
keymap(
  "o",
  "f",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
  ,
  {}
)
keymap(
  "o",
  "F",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
  ,
  {}
)
-- New Lines + leave insert mode
keymap("n", "<Leader>o", "o<ESC>k", opts)
keymap("n", "<M-o>", "O<ESC>j", opts)

-- Insert --
-- Press jk to leave insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Press jk to leave insert mode
keymap("v", "jk", "<ESC>", opts)
keymap("v", "kj", "<ESC>", opts)

-- Move text up and down
keymap("v", "<S-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<S-k>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "p", '"_dP', opts)
