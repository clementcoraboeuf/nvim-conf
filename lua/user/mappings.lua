-- stylua: ignore start
local fn = require'user.fn'
local m = require'mapx'.setup{ global = true, whichkey = true, debug = vim.g.mapxDebug or false }

local silent = m.silent
local expr = m.expr

local curry, icurry = fn.curry, fn.icurry

-- Disable C-z suspend
map     ([[<C-z>]], [[<Nop>]])
mapbang ([[<C-z>]], [[<Nop>]])

-- Disable C-c warning
map     ([[<C-c>]], [[<Nop>]])

-- Disable Ex mode
nnoremap ([[Q]], [[<Nop>]])

-- Disable command-line window
nnoremap ([[q:]], [[<Nop>]])
nnoremap ([[q/]], [[<Nop>]])
nnoremap ([[q?]], [[<Nop>]])

noremap ([[j]], function(count) return count > 1 and "j" or "gj" end, silent, expr)
noremap ([[k]], function(count) return count > 0 and "k" or "gk" end, silent, expr)
noremap ([[J]], [[5j]])
noremap ([[K]], [[5k]])

-- since the vim-wordmotion plugin overrides the normal `w` wordwise movement,
-- make `W` behave as vanilla `w`
nnoremap ([[W]], [[w]], "Move full word forward")

nnoremap ([[<M-b>]], [[ge]], "Move to the end of the previous word")

-- https://vim.fandom.com/wiki/Insert_a_single_character
nnoremap ([[<M-S-i>]], [[:exec "normal i".nr2char(getchar())."\e"<Cr>]], silent, "Insert a single character")
nnoremap ([[<M-S-a>]], [[:exec "normal a".nr2char(getchar())."\e"<Cr>]], silent, "Insert a single character")

vnoremap ([[>]], [[>gv]], "Indent")
vnoremap ([[<]], [[<gv]], "De-Indent")

nnoremap ({[[Q]], [[<F29>]]}, [[:CloseWin<Cr>]],     silent, "Close window")
nnoremap ([[ZQ]],             [[:confirm qall<Cr>]], silent, "Quit all")
nnoremap ([[<C-w>]],          [[:tabclose<Cr>]],     silent, "Close tab (except last one)")
nnoremap ([[<leader>H]],      [[:hide<Cr>]],         silent, "Hide buffer")

-- save file
noremap ([[<C-s>]], [[:w<Cr>]])

-- quickly enter command mode with substitution commands prefilled
-- TODO: need to force redraw
nnoremap ([[<leader>/]], [[:%s/]], "Substitute")
nnoremap ([[<leader>?]], [[:%S/]], "Substitute (rev)")
vnoremap ([[<leader>/]], [[:s/]],  "Substitute")
vnoremap ([[<leader>?]], [[:S/]],  "Substitute (rev)")

-- Toggle line wrapping
nnoremap ({[[<leader>W]], [[<leader>ww]]}, [[:setlocal wrap!<Cr>:setlocal wrap?<Cr>]], silent, "Toggle wrap")

nnoremap ([[<M-o>]], [[m'Do<esc>p`']], "Insert a space and then paste before/after cursor")
nnoremap ([[<M-O>]], [[m'DO<esc>p`']], "Insert a space and then paste before/after cursor")

nnoremap ([[Y]], [[y$]], "Yank until end of line")

vnoremap ([[<leader>y]], [["+y]], "Yank to system clipboard")
nnoremap ([[<leader>Y]], [["+yg_]], "Yank 'til EOL to system clipboard")
nnoremap ([[<leader>yy]], [["+yy]], "Yank line to system clipboard")
nnoremap ([[<C-y>]], [[pumvisible() ? "\<C-y>" : '"+yy']], expr)
vnoremap ([[<C-y>]], [[pumvisible() ? "\<C-y>" : '"+y']], expr)

-- yank path of current file to system clipboard
nnoremap ([[<leader>yp]], [[:let @+ = expand("%:p")<Cr>:echom "Copied " . @+<Cr>]], silent, "Yank file path to system clipboard")

-- Paste from system clipboard
vnoremap ([[<C-p>]], [["+p]])
nnoremap ([[<C-p>]], [["+p]])

-- Insert a space and then paste before/after cursor
nnoremap ([[<M-p>]], [[a <esc>p]])
nnoremap ([[<M-P>]], [[i <esc>P]])

-- Duplicate line downwards/upwards
nnoremap ([[<C-M-j>]], [["dY"dp]])
nnoremap ([[<C-M-k>]], [["dY"dP]])

-- Duplicate selection downwards/upwards
vnoremap ([[<C-M-j>]], [["dy`<"dPjgv]])
vnoremap ([[<C-M-k>]], [["dy`>"dpgv]])


-- Clear UI state:
-- - Clear search highlight
-- - Clear command-line
-- - Close floating windows
nnoremap ([[<Esc>]], function()
  vim.cmd("nohlsearch")
  fn.closeFloatWins()
  vim.cmd("echo ''")
end, silent)

-- Force redraw
-- See: https://github.com/mhinz/vim-galore#saner-ctrl-l
nnoremap ([[<leader>L]], [[:nohlsearch<Cr>:diffupdate<Cr>:syntax sync fromstart<Cr><c-l>]], "Redraw")

-- Reload vim configuration
nnoremap ([[<leader>rr]], [[:lua require'user.fn'.reload()<Cr>]], silent, "Reload config")

-- goto file under cursor in new tab
noremap ([[gF]], [[<C-w>gf]], "Go to file under cursor (new tab)")

-- open tab in new terminal instance
-- nnoremap ([[<leader>W]], [[:call user#fn#windowToNewTerminal()<Cr>]], "Move window to new terminal")

-- conceal
nnoremap ([[<leader>cl]], [[:call user#fn#toggleConcealLevel()<Cr>]], silent, "Toggle conceal level")
nnoremap ([[<leader>cc]], [[:call user#fn#toggleConcealCursor()<Cr>]], silent, "Toggle conceal cursor")

-- cursorcolumn
nmap     ([[<leader>|]], [[:set invcursorcolumn<Cr>]], silent, "Toggle cursorcolumn")

-- emacs-style motion & editing in insert mode
inoremap ([[<C-a>]], [[<Home>]])
inoremap ([[<C-e>]], [[<End>]])
inoremap ([[<C-b>]], [[<Left>]])
inoremap ([[<C-f>]], [[<Right>]])
inoremap ([[<C-n>]], [[<Down>]])
inoremap ([[<M-b>]], [[<S-Left>]])
inoremap ([[<M-f>]], [[<S-Right>]])
inoremap ([[<M-d>]], [[<C-o>de]])
inoremap ([[<C-k>]], [[<C-o>D]])
inoremap ([[<C-p>]], [[<Up>]])
inoremap ([[<C-d>]], [[<Delete>]])

-- restore support for digraphs to M-k
inoremap ([[<M-k>]], [[<C-k>]])

-- nano-like kill buffer
-- TODO
vim.cmd([[
  let @k=''
  let @l=''
]])
nnoremap ([[<F30>]], [["ldd:let @k=@k.@l | let @l=@k<cr>]], silent)
nnoremap ([[<F24>]], [[:if @l != "" | let @k=@l | end<cr>"KgP:let @l=@k<cr>:let @k=""<cr>]], silent)

-- overload tab key to also perform next/prev in popup menus
-- inoremap ([[<Tab>]],   [[pumvisible() ? "\<C-n>" : "\<Tab>"]], silent, expr)
-- inoremap ([[<S-Tab>]], [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], silent, expr)

-- emacs-style motion & editing in command mode
cnoremap ([[<C-a>]], [[<Home>]])
cnoremap ([[<C-b>]], [[<Left>]])
cnoremap ([[<C-d>]], [[<Delete>]])
cnoremap ([[<C-f>]], [[<Right>]])
cnoremap ([[<C-g>]], [[<C-c>]])
cnoremap ([[<C-k>]], [[<C-\>e(" ".getcmdline())[:getcmdpos()-1][1:]<Cr>]])
cnoremap ([[<M-f>]], [[<C-\>euser#fn#cmdlineMoveWord( 1, 0)<Cr>]])
cnoremap ([[<M-b>]], [[<C-\>euser#fn#cmdlineMoveWord(-1, 0)<Cr>]])
cnoremap ([[<M-d>]], [[<C-\>euser#fn#cmdlineMoveWord( 1, 1)<Cr>]])
cnoremap ([[<M-Backspace>]], [[<C-\>euser#fn#cmdlineMoveWord(-1, 1)<Cr>]])

-- restore support for digraphs to M-k
cnoremap ([[<M-k>]], [[<C-k>]])

-- Make c-n and c-p behave like up/down arrows, i.e. take into account the
-- beginning of the text entered in the command line when jumping, but only if
-- the pop-up menu (completion menu) is not visible
-- See: https://github.com/mhinz/vim-galore#saner-command-line-history
cnoremap ([[<c-p>]], [[pumvisible() ? "\<C-p>" : "\<up>"]], expr)
cnoremap ([[<c-n>]], [[pumvisible() ? "\<C-n>" : "\<down>"]], expr)

--"" Tabs

-- Navigate tabs
noremap  ([[<M-'>]], [[:tabn<Cr>]],           silent, "Tabs: Goto next")
noremap  ([[<M-;>]], [[:tabp<Cr>]],           silent, "Tabs: Goto prev")
tnoremap ([[<M-'>]], [[<C-\><C-n>:tabn<Cr>]], silent, "Tabs: goto next")
tnoremap ([[<M-;>]], [[<C-\><C-n>:tabp<Cr>]], silent, "Tabs: goto prev")
noremap  ([[<M-a>]], [[g<Tab>]],              silent, "Tabs: Goto last accessed")

-- Rearrange tabs
noremap ([[<M-">]], [[:+tabm<Cr>]], silent)
noremap ([[<M-:>]], [[:-tabm<Cr>]], silent)

-- Open/close tabs
noremap ([[<F13>]], [[:tabnew<Cr>]], silent)
noremap ([[<M-Backspace>]], [[:tabclose<Cr>]], silent)

-- Navigation through tabs by index
noremap ([[<M-1>]], [[:call user#fn#tabnm(1)<Cr>]], silent)
noremap ([[<M-2>]], [[:call user#fn#tabnm(2)<Cr>]], silent)
noremap ([[<M-3>]], [[:call user#fn#tabnm(3)<Cr>]], silent)
noremap ([[<M-4>]], [[:call user#fn#tabnm(4)<Cr>]], silent)
noremap ([[<M-5>]], [[:call user#fn#tabnm(5)<Cr>]], silent)
noremap ([[<M-6>]], [[:call user#fn#tabnm(6)<Cr>]], silent)
noremap ([[<M-7>]], [[:call user#fn#tabnm(7)<Cr>]], silent)
noremap ([[<M-8>]], [[:call user#fn#tabnm(8)<Cr>]], silent)
noremap ([[<M-9>]], [[:call user#fn#tabnm(9)<Cr>]], silent)
noremap ([[<M-0>]], [[:call user#fn#tabnm(10)<Cr>]], silent)

-- Alt+[hjkl] to navigate through splits in terminal mode
tnoremap ([[<M-h>]], [[<C-\><C-n><C-w>h]])
tnoremap ([[<M-j>]], [[<C-\><C-n><C-w>j]])
tnoremap ([[<M-k>]], [[<C-\><C-n><C-w>k]])
tnoremap ([[<M-l>]], [[<C-\><C-n><C-w>l]])

-- resize splits left/right
noremap ([[<M-[>]], [[<C-w>3<]])
noremap ([[<M-]>]], [[<C-w>3>]])

-- resize splits up/down
noremap ([[<M-{>]], [[<C-w>3-]])
noremap ([[<M-}>]], [[<C-w>3+]])

-- make splits equally wide and high
nnoremap ([[<leader>sa]], [[<c-w>=]], "Equalize window sizes")

-- create splits
-- see also the VSplit plugin mappings below
nnoremap ([[<leader>S]],  [[:new<Cr>]],    silent, "Split (horiz, new)")
nnoremap ([[<leader>sn]], [[:new<Cr>]],    silent, "Split (horiz, new)")
nnoremap ([[<leader>V]],  [[:vnew<Cr>]],   silent, "Split (vert, new)")
nnoremap ([[<leader>vn]], [[:vnew<Cr>]],   silent, "Split (vert, new)")
nnoremap ([[<leader>ss]], [[:split<Cr>]],  silent, "Split (horiz, cur)")
nnoremap ([[<leader>st]], [[:split<Cr>]],  silent, "Split (horiz, cur)")
nnoremap ([[<leader>vv]], [[:vsplit<Cr>]], silent, "Split (vert, cur)")
nnoremap ([[<leader>vt]], [[:vsplit<Cr>]], silent, "Split (vert, cur)")

-- Interleave two same-sized contiguous blocks
vnoremap ([[<leader>I]], [[<esc>:call user#fn#interleave()<Cr>]], silent, "Interleave two contiguous blocks")

-- PasteRestore
-- paste register without overwriting with the original selection
-- use P for original behavior
vnoremap ([[p]], [[user#fn#pasteRestore()]], silent, expr)

-- Open Terminal
nnoremap ([[<leader>T]], [[:Term!<Cr>]], silent, "New term (tab)")
nnoremap ([[<leader>t]], [[:10Term<Cr>]], silent, "New term (split)")

-- close terminal window
-- map <C-S-q> to \x1b[15;5~ (F29) in your terminal emulator
tnoremap ([[<F29>]], [[<C-\><C-n>:q<Cr>]])

-- switch to normal mode
-- map <C-S-n> to \x1b[14;5~ (F28) in your terminal emulator
tnoremap ([[<F24>]], [[<C-\><C-n>]])

tnoremap ([[<C-n>]], [[<C-n>]])
tnoremap ([[<C-p>]], [[<C-p>]])
tnoremap ([[<M-n>]], [[<M-n>]])
tnoremap ([[<M-p>]], [[<M-p>]])

-- Modeline
nnoremap ([[<Leader>ml]], [[:call AppendModeline()<Cr>]], silent, "Append modeline with current settings")

------ Filetypes
m.group(silent, { ft = "lua" }, function()
  nmap     ([[<leader><Enter>]], require'user.fn'.luarun, "Lua: Eval line")
  xmap     ([[<leader><Enter>]], require'user.fn'.luarun, "Lua: Eval selection")
  nmap     ([[<leader><F12>]],   "<Cmd>Put lua require'user.fn'.luarun()<Cr>", "Lua: Eval line (Append)")
  xmap     ([[<leader><F12>]],   "<Cmd>Put lua require'user.fn'.luarun()<Cr>", "Lua: Eval selection (Append)")
end)

------ Plugins
---- wbthomason/packer.nvim
m.nname("<leader>p", "Packer")
nmap     ([[<leader>pC]], [[:PackerClean<Cr>]])
nmap     ([[<leader>pc]], [[:PackerCompile<Cr>]])
nmap     ([[<leader>pi]], [[:PackerInstall<Cr>]])
nmap     ([[<leader>pu]], [[:PackerUpdate<Cr>]])
nmap     ([[<leader>ps]], [[:PackerSync<Cr>]])
nmap     ([[<leader>pl]], [[:PackerLoad<Cr>]])

---- tpope/vim-commentary
map      ([[<M-/>]], [[:Commentary<Cr>]], silent)

---- christoomey/vim-tmux-navigator
nmap     ([[<M-h>]], [[:TmuxNavigateLeft<cr>]],  silent)
nmap     ([[<M-j>]], [[:TmuxNavigateDown<cr>]],  silent)
nmap     ([[<M-k>]], [[:TmuxNavigateUp<cr>]],    silent)
nmap     ([[<M-l>]], [[:TmuxNavigateRight<cr>]], silent)


---- nvim-telescope/telescope.nvim TODO: In-telescope maps
m.group("silent", function()
  m.nname("<C-f>", "Telescope")
  nnoremap ({[[<C-f>b]], [[<C-f><C-b>]]}, icurry(require('telescope.builtin').buffers),                         "Telescope: Buffers")
  nnoremap ({[[<C-f>f]], [[<C-f><C-f>]]}, icurry(require('telescope.builtin').find_files, {previewer = false}), "Telescope: Files")
  nnoremap ({[[<C-f>h]], [[<C-f><C-h>]]}, icurry(require('telescope.builtin').help_tags),                       "Telescope: Help tags")
  nnoremap ({[[<C-f>t]], [[<C-f><C-t>]]}, icurry(require('telescope.builtin').tags),                            "Telescope: Tags")
  nnoremap ({[[<C-f>a]], [[<C-f><C-a>]]}, icurry(require('telescope.builtin').grep_string),                     "Telescope: Grep for string")
  nnoremap ({[[<C-f>p]], [[<C-f><C-p>]]}, icurry(require('telescope.builtin').live_grep),                       "Telescope: Live grep")
  nnoremap ({[[<C-f>o]], [[<C-f><C-o>]]}, icurry(require('telescope.builtin').oldfiles),                        "Telescope: Old files")

  m.nname("<M-f>", "Telescope-Buffer")
  nnoremap ({[[<M-f>b]], [[<M-f><M-b>]]}, icurry(require('telescope.builtin').current_buffer_fuzzy_find),          "Telescope: Buffer (fuzzy)")
  nnoremap ({[[<M-f>t]], [[<M-f><M-t>]]}, icurry(require('telescope.builtin').tags ,{only_current_buffer = true}), "Telescope: Tags (buffer)")
end)

---- neovim/nvim-lspconfig
m.nname("<leader>l", "LSP")
nnoremap ([[<leader>li]], [[:LspInfo<Cr>]],    "LSP: Show LSP information")
nnoremap ([[<leader>lr]], [[:LspRestart<Cr>]], "LSP: Restart LSP")
nnoremap ([[<leader>ls]], [[:LspStart<Cr>]],   "LSP: Start LSP")
nnoremap ([[<leader>lS]], [[:LspStop<Cr>]],    "LSP: Stop LSP")

_G.nvim_lsp_mapfn = function(bufnr)
  local user_lsp = require'user.lsp'

  m.group({ buffer = bufnr, silent = true }, function()
    m.nname("<localleader>g", "LSP-Goto")
    nnoremap ({[[<localleader>gd]], [[gd]]}, icurry(vim.lsp.buf.definition),      "LSP: Goto definition")
    nnoremap ({[[<localleader>gd]], [[gd]]}, icurry(vim.lsp.buf.definition),      "LSP: Goto definition")
    nnoremap ([[<localleader>gD]],           icurry(vim.lsp.buf.declaration),     "LSP: Goto declaration")
    nnoremap ([[<localleader>gi]],           icurry(vim.lsp.buf.implementation),  "LSP: Goto implementation")
    nnoremap ([[<localleader>gt]],           icurry(vim.lsp.buf.type_definition), "LSP: Goto type definition")
    nnoremap ([[<localleader>gr]],           icurry(vim.lsp.buf.references),      "LSP: Goto references")

    m.nname("<localleader>w", "LSP-Workspace")
    nnoremap ([[<localleader>wa]], icurry(vim.lsp.buf.add_workspace_folder),    "LSP: Add workspace folder")
    nnoremap ([[<localleader>wr]], icurry(vim.lsp.buf.remove_workspace_folder), "LSP: Rm workspace folder")

    nnoremap ([[<localleader>wl]], function() fn.inspect(vim.lsp.buf.list_workspace_folders()) end, "LSP: List workspace folders")

    nnoremap ([[<localleader>R]],  icurry(vim.lsp.buf.rename), "LSP: Rename")

    nnoremap ({[[<localleader>A]], [[<localleader>ca]]}, icurry(vim.lsp.buf.code_action),       "LSP: Code action")
    vnoremap ({[[<localleader>A]], [[<localleader>ca]]}, icurry(vim.lsp.buf.range_code_action), "LSP: Code action (range)")

    nnoremap ([[<localleader>F]], icurry(vim.lsp.buf.formatting),       "LSP: Format")
    vnoremap ([[<localleader>F]], icurry(vim.lsp.buf.range_formatting), "LSP: Format (range)")

    m.nname("<localleader>s", "LSP-Save")
    nnoremap ([[<localleader>S]],  user_lsp.fmtOnSave,               "LSP: Toggle format on save")
    nnoremap ([[<localleader>ss]], user_lsp.fmtOnSave,               "LSP: Toggle format on save")
    nnoremap ([[<localleader>se]], curry(user_lsp.fmtOnSave, true),  "LSP: Enable format on save")
    nnoremap ([[<localleader>sd]], curry(user_lsp.fmtOnSave, false), "LSP: Disable format on save")

    local function gotoDiag(dir, sev)
      return curry(
        vim.diagnostic["goto_" .. (dir == -1 and "prev" or "next")],
        { enable_popup = true, severity = sev }
      )
    end
    m.nname("<localleader>d", "LSP-Diagnostics")
    nnoremap ([[<localleader>di]],                        icurry(vim.diagnostic.show_line_diagnostics), "LSP: Show diagnostics")
    nnoremap ({[[<localleader>dI]], [[<localleader>T]]},  icurry(require'trouble'.toggle),              "LSP: Toggle Trouble")

    nnoremap ({[[<localleader>dd]], [[[d]]}, gotoDiag(-1),            "LSP: Goto prev diagnostic")
    nnoremap ({[[<localleader>dD]], [[]d]]}, gotoDiag(1),             "LSP: Goto next diagnostic")
    nnoremap ({[[<localleader>dw]], [[[w]]}, gotoDiag(-1, "Warning"), "LSP: Goto prev diagnostic (warning)")
    nnoremap ({[[<localleader>dW]], [[]w]]}, gotoDiag(1,  "Warning"), "LSP: Goto next diagnostic (warning)")
    nnoremap ({[[<localleader>de]], [[[e]]}, gotoDiag(-1, "Error"),   "LSP: Goto prev diagnostic (error)")
    nnoremap ({[[<localleader>dE]], [[]e]]}, gotoDiag(1,  "Error"),   "LSP: Goto next diagnostic (error)")

    m.nname("<localleader>s", "LSP-Search")
    nnoremap ({[[<localleader>so]], [[<leader>so]]}, icurry(require('telescope.builtin').lsp_document_symbols), "LSP: Telescope symbol search")

    m.nname("<localleader>h", "LSP-Hover")
    nnoremap ([[<localleader>hs]], icurry(vim.lsp.buf.signature_help), "LSP: Signature help")
    nnoremap ([[<localleader>ho]], icurry(vim.lsp.buf.hover),          "LSP: Hover")
    nnoremap ([[<M-i>]],           icurry(vim.lsp.buf.hover),          "LSP: Hover")
    inoremap ([[<M-i>]],           icurry(vim.lsp.buf.hover),          "LSP: Hover")
    nnoremap ([[<M-S-i>]],         user_lsp.peekDefinition,            "LSP: Peek definition")
  end)
end

---- tpope/vim-fugitive
m.nname("<leader>g",  "Fugitive")
m.nname("<leader>ga", "Fugitive-Add")
nnoremap ([[<leader>gA]],  [[:Git add --all<Cr>]],                "Fugitive: Add all")
nnoremap ([[<leader>gaa]], [[:Git add --all<Cr>]],                "Fugitive: Add all")
nnoremap ([[<leader>gaf]], [[:Git add :%<Cr>]],                   "Fugitive: Add file")

m.nname("<leader>gc", "Fugitive-Commit")
nnoremap ([[<leader>gC]],  [[:Git commit --verbose<Cr>]],         "Fugitive: Commit")
nnoremap ([[<leader>gcc]], [[:Git commit --verbose<Cr>]],         "Fugitive: Commit")
nnoremap ([[<leader>gca]], [[:Git commit --verbose --all<Cr>]],   "Fugitive: Commit (all)")
nnoremap ([[<leader>gcA]], [[:Git commit --verbose --amend<Cr>]], "Fugitive: Commit (amend)")

m.nname("<leader>gl", "Fugitive-Log")
nnoremap ([[<leader>gL]],  [[:Gclog!<Cr>]],                       "Fugitive: Log")
nnoremap ([[<leader>gll]], [[:Gclog!<Cr>]],                       "Fugitive: Log")
nnoremap ([[<leader>glL]], [[:tabnew | Gclog<Cr>]],               "Fugitive: Log (tab)")

m.nname("<leader>gp", "Fugitive-Push-Pull")
nnoremap ([[<leader>gpa]], [[:Git push --all<Cr>]],               "Fugitive: Push all")
nnoremap ([[<leader>gpp]], [[:Git push<Cr>]],                     "Fugitive: Push")
nnoremap ([[<leader>gpl]], [[:Git pull<Cr>]],                     "Fugitive: Pull")

nnoremap ([[<leader>gR]],  [[:Git reset<Cr>]],                    "Fugitive: Reset")

m.nname("<leader>gs", "Fugitive-Status")
nnoremap ([[<leader>gS]],  [[:Git<Cr>]],                          "Fugitive: Status")
nnoremap ([[<leader>gss]], [[:Git<Cr>]],                          "Fugitive: Status")
nnoremap ([[<leader>gst]], [[:Git<Cr>]],                          "Fugitive: Status")

nnoremap ([[<leader>gsp]], [[:Gsplit<Cr>]],                       "Fugitive: Split")

m.nname("<leader>G", "Fugitive")
nnoremap ([[<leader>GG]],  [[:Git<Cr>]],                          "Fugitive: Status")
nnoremap ([[<leader>GS]],  [[:Git<Cr>]],                          "Fugitive: Status")
nnoremap ([[<leader>GA]],  [[:Git add<Cr>]],                      "Fugitive: Add")
nnoremap ([[<leader>GC]],  [[:Git commit<Cr>]],                   "Fugitive: Commit")
nnoremap ([[<leader>GF]],  [[:Git fetch<Cr>]],                    "Fugitive: Fetch")
nnoremap ([[<leader>GL]],  [[:Git log<Cr>]],                      "Fugitive: Log")
nnoremap ([[<leader>GPP]], [[:Git push<Cr>]],                     "Fugitive: Push")
nnoremap ([[<leader>GPL]], [[:Git pull<Cr>]],                     "Fugitive: Pull")

-- mbbill/undotree
nnoremap ([[<leader>ut]], [[:UndotreeToggle<Cr>]], "Undotree: Toggle")

-- godlygeek/tabular
nmap ([[<Leader>a]], ":Tabularize /", "Tabularize")
vmap ([[<Leader>a]], ":Tabularize /", "Tabularize")

-- b0o/vim-man
m.group({ "silent", ft = "man" }, function()
  -- open manpage tag (e.g. isatty(3)) in current buffer
  nnoremap ([[<C-]>]], function() require'user.fn'.man('', vim.fn.expand('<cword>')) end,      "Man: Open tag in current buffer")
  nnoremap ([[<M-]>]], function() require'user.fn'.man('tab', vim.fn.expand('<cword>')) end,   "Man: Open tag in new tab")
  nnoremap ([[}]],     function() require'user.fn'.man('split', vim.fn.expand('<cword>')) end, "Man: Open tag in new split")

  -- TODO
  -- go back to previous manpage
--   nnoremap ([[<C-t>]],   [[:call man#pop_page))
--   nnoremap ([[<C-o>]],   [[:call man#pop_page()<CR>]])
--   nnoremap ([[<M-o>]],   [[<C-o>]])

  -- navigate to next/prev section
  nnoremap ("[[", [[:<C-u>call user#fn#manSectionMove('b', 'n', v:count1)<CR>]], "Man: Goto prev section")
  nnoremap ("]]", [[:<C-u>call user#fn#manSectionMove('' , 'n', v:count1)<CR>]], "Man: Goto next section")
  xnoremap ("[[", [[:<C-u>call user#fn#manSectionMove('b', 'v', v:count1)<CR>]], "Man: Goto prev section")
  xnoremap ("]]", [[:<C-u>call user#fn#manSectionMove('' , 'v', v:count1)<CR>]], "Man: Goto next section")

  -- navigate to next/prev manpage tag
  nnoremap ([[<Tab>]],   [[:call search('\(\w\+(\w\+)\)', 's')<CR>]],  "Man: Goto next tag")
  nnoremap ([[<S-Tab>]], [[:call search('\(\w\+(\w\+)\)', 'sb')<CR>]], "Man: Goto prev tag")

  -- search from beginning of line (useful for finding command args like -h)
  nnoremap ([[g/]], [[/^\s*\zs]], { silent = false }, "Man: Start BOL search")
end)

---- KabbAmine/vCoolor.vim
nmap([[<leader>co]], [[:VCoolor<CR>]], silent, "Open VCooler color picker")

---- kyazdani42/nvim-tree.lua
nmap([[<C-\>]], [[:NvimTreeToggle<CR>]], silent, "Nvim-Tree: Toggle")

m.group({ ft = "NvimTree" }, function()
  local function withSelected(cmd, fmt)
    return function()
      local file = require'nvim-tree.lib'.get_node_at_cursor().absolute_path
      cmd = fmt and (cmd):format(file) or ("%s %s"):format(cmd, file)
      local tab_open = vim.g.nvim_tree_tab_open
      if tab_open == 1 then
        vim.g.nvim_tree_tab_open = 0
      end
      vim.cmd(cmd)
      if tab_open == 1 then
        vim.defer_fn(function()
          vim.g.nvim_tree_tab_open = tab_open
        end, 500)
      end
    end
  end
  nnoremap ([[ga]], withSelected("Git add"),             "Nvim-Tree: Git add")
  nnoremap ([[gr]], withSelected("Git reset --quiet"),   "Nvim-Tree: Git reset")
  nnoremap ([[gb]], withSelected("tabnew | Git blame"),  "Nvim-Tree: Git blame")
  nnoremap ([[gd]], withSelected("tabnew | Gdiffsplit"), "Nvim-Tree: Git diff")
end)

---- sindrets/winshift.nvim
nnoremap ([[<Leader>M]], [[<Cmd>WinShift<Cr>]], "WinShift: Start")

-- Testing out Mapx mini-modes
-- m.mode('test', function()
--   map("gH", ":echo 'Hello'<Cr>")
--   map("gx", m.exitMode)
-- end)
-- map("<Leader>mt", function() m.enterMode("test") end)

---- bfredl/nvim-luadev
-- m.group({ ft = "lua" }, function()
--   nmap([[zx]], function() print("lua: x") end)
--   nmap([[zy]], function() print("lua: y") end)
--   nmap([[zz]], function() print("lua: z") end)
-- end)
-- m.group({ ft = "yaml" }, function()
--   nmap([[zx]], function() print("yaml: x") end)
--   nmap([[zy]], function() print("yaml: y") end)
--   nmap([[zz]], function() print("yaml: z") end)
-- end)
-- m.group({ ft = { "lua", "yaml" } }, function()
--   nmap([[zw]], function() print("luayaml: w") end)
-- end)
-- m.audone()
-- function! g:Luadev_setup()
--   if exists('b:luadev_did_setup')
--     return
--   endif

--   nmap <buffer> <F12> :Luadev<Cr><Plug>(Luadev-RunLine)
--   vmap <buffer> <F12> :Luadev<Cr><Plug>(Luadev-Run)
--   nmap <buffer> <F13> :Luadev<Cr><Plug>(Luadev-RunWord)
--   imap <buffer> <C-r> <Plug>(Luadev-Complete)
--   imap <buffer> <F12> <Esc><F12>a
--   imap <buffer> <F13> <Esc><F13>a

--   let b:luadev_did_setup = 1
-- endfunction

-- augroup luadev_setup
--   autocmd!
--   autocmd BufEnter *.lua call g:Luadev_setup()
-- augroup END
-- end
--
--   m.group({ ft = "LspSagaCodeAction" }, silent, function()
--     map({
--       [[<Esc>]], [[q]], [[Q]], [[<C-c>]], [[<C-d>]], [[<C-g>]]
--     }, require'lspsaga.codeaction'.quit_action_window, "LSPSaga: Close CodeAction window")

--     map([[<Tab>]],   function()
--       local c = vim.fn.getpos(".")[2]
--       local l = vim.api.nvim_buf_line_count(0)
--       vim.fn.cursor({c == l and 1 or c + 1, 2})
--     end, "LSPSaga: Next action")

--     map([[<S-Tab>]], function()
--       local c = vim.fn.getpos(".")[2]
--       vim.fn.cursor({c == 2 and '$' or c - 1, 2})
--     end, "LSPSaga: Prev action")

--     local function selectAction(n, doAction)
--       return function()
--         vim.fn.cursor({n + 2, 2})
--         if doAction then require'lspsaga.codeaction'.do_code_action() end
--       end
--     end

--     map([[1]],      selectAction(1),       "LSPSaga: Select action 1")
--     map([[2]],      selectAction(2),       "LSPSaga: Select action 2")
--     map([[3]],      selectAction(3),       "LSPSaga: Select action 3")
--     map([[4]],      selectAction(4),       "LSPSaga: Select action 4")
--     map([[5]],      selectAction(5),       "LSPSaga: Select action 5")
--     map([[6]],      selectAction(6),       "LSPSaga: Select action 6")
--     map([[7]],      selectAction(7),       "LSPSaga: Select action 7")
--     map([[8]],      selectAction(8),       "LSPSaga: Select action 8")
--     map([[9]],      selectAction(9),       "LSPSaga: Select action 9")
--     map([[10]],     selectAction(10),      "LSPSaga: Select action 10")

--     map([[<M-1>]],  selectAction(1, true), "LSPSaga: Do action 1")
--     map([[<M-2>]],  selectAction(2, true), "LSPSaga: Do action 2")
--     map([[<M-3>]],  selectAction(3, true), "LSPSaga: Do action 3")
--     map([[<M-4>]],  selectAction(4, true), "LSPSaga: Do action 4")
--     map([[<M-5>]],  selectAction(5, true), "LSPSaga: Do action 5")
--     map([[<M-6>]],  selectAction(6, true), "LSPSaga: Do action 6")
--     map([[<M-7>]],  selectAction(7, true), "LSPSaga: Do action 7")
--     map([[<M-8>]],  selectAction(8, true), "LSPSaga: Do action 8")
--     map([[<M-9>]],  selectAction(9, true), "LSPSaga: Do action 9")
--     map([[<M-10>]], selectAction(10, true), "LSPSaga: Do action 10")
--   end)