if version > 580
    hi clear
    if exists('syntax_on')
        syntax reset
    endif
endif

let g:colors_name='ghbw'

let g:atlas_colors = {
  \ "bg"      : ["#121212", 233],
  \ "dark"    : ["#262626", 235],
  \ "dim"     : ["#444444", 238],
  \ "muted"   : ["#666666", 242],
  \ "normal"  : ["#c0c0c0", 250],
  \ "bright"  : ["#e4e4e4", 254],
  \ "white"   : ["#ffffff", 255],
  \ "red"     : ["#f43753", 203],
  \ "yellow"  : ["#ffc24b", 221],
  \ "green"   : ["#5af78d", 119],
  \ "none"    : ["NONE", "NONE"]
  \ }

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

function! s:hl(group, guifg, ...)
    let fg = g:atlas_colors[a:guifg]

    if a:0 >= 1
        let bg = g:atlas_colors[a:1]
    else
        let bg = g:atlas_colors["none"]
    endif

    if a:0 >= 2
        let style = a:2
    else
        let style = "NONE"
    endif

    let hi_str = [ "hi", a:group,
            \ 'guifg=' . fg[0], "ctermfg=" . fg[1],
            \ 'guibg=' . bg[0], "ctermbg=" . bg[1],
            \ 'gui=' . style, "cterm=" . style
            \ ]

    execute join(hi_str, ' ')
endfunction

" --- base groups ---
call s:hl("AtlasBg",      "bg")
call s:hl("AtlasDark",    "dark")
call s:hl("AtlasDim",     "dim")
call s:hl("AtlasMuted",   "muted")
call s:hl("AtlasNormal",  "normal")
call s:hl("AtlasBright",  "bright")
call s:hl("AtlasWhite",   "white")
call s:hl("AtlasRed",     "red")
call s:hl("AtlasYellow",  "yellow")
call s:hl("AtlasGreen",   "green")

call s:hl("AtlasBold",       "none", "none", "bold")
call s:hl("AtlasItalic",     "none", "none", "italic")
call s:hl("AtlasUnderline",  "none", "none", "underline")

" --- UI ---
call s:hl("Normal",       "normal",  "bg")
call s:hl("LineNr",       "dim",     "none")
call s:hl("CursorLine",   "none",    "dark")
call s:hl("CursorLineNr", "bright",  "dark")
call s:hl("CursorColumn", "none",    "dark")
call s:hl("ColorColumn",  "none",    "dark")
call s:hl("SignColumn",   "muted",   "bg")
call s:hl("VertSplit",    "dark",    "dark")
call s:hl("Folded",       "muted",   "dark")
call s:hl("FoldColumn",   "muted",   "dark")
call s:hl("NonText",      "dim",     "none")
call s:hl("SpecialKey",   "dim",     "none")
call s:hl("Visual",       "none",    "bg",   "reverse")
call s:hl("VisualNOS",    "none",    "bg",   "reverse")
call s:hl("Directory",    "bright",  "none")
call s:hl("Title",        "bright",  "none", "bold")
call s:hl("MatchParen",   "red",     "none", "bold")
call s:hl("Search",       "white",   "none", "bold,underline")
call s:hl("IncSearch",    "bg",      "white")
call s:hl("WildMenu",     "bg",      "normal", "bold")
call s:hl("PMenu",        "normal",  "dark")
call s:hl("PMenuSel",     "bright",  "dim")
call s:hl("PmenuSbar",    "normal",  "normal")
call s:hl("PmenuThumb",   "white",   "white")
call s:hl("StatusLine",   "normal",  "dark", "bold")
call s:hl("StatusLineNC", "muted",   "dark")
call s:hl("TabLine",      "muted",   "dark")
call s:hl("TabLineFill",  "none",    "dark")
call s:hl("TabLineSel",   "bright",  "none", "bold")
call s:hl("Question",     "normal",  "none")
call s:hl("WarningMsg",   "yellow",  "none")
call s:hl("ErrorMsg",     "red",     "none", "reverse")

" --- diffs ---
call s:hl("DiffAdd",    "green",  "bg")
call s:hl("DiffChange", "yellow", "bg")
call s:hl("DiffDelete", "red",    "bg")
call s:hl("DiffText",   "none",   "none", "reverse")

" --- spell ---
call s:hl("SpellBad",   "red",    "none", "underline")
call s:hl("SpellLocal", "yellow", "none", "underline")
call s:hl("SpellCap",   "normal", "none", "underline")
call s:hl("SpellRare",  "muted",  "none", "underline")

" --- syntax ---
call s:hl("Comment",    "muted",  "none")
call s:hl("Constant",   "normal", "none")
call s:hl("String",     "normal", "none")
call s:hl("Number",     "bright", "none")
call s:hl("Boolean",    "bright", "none")
call s:hl("Float",      "bright", "none")
call s:hl("Identifier", "normal", "none")
call s:hl("Function",   "bright", "none")
call s:hl("Statement",  "bright", "none")
call s:hl("Conditional","bright", "none")
call s:hl("Operator",   "red",    "none")
call s:hl("Exception",  "red",    "none")
call s:hl("PreProc",    "normal", "none")
call s:hl("Type",       "bright", "none")
call s:hl("Special",    "bright", "none")
call s:hl("Underlined", "none",   "none", "underline")
call s:hl("Error",      "red",    "none", "reverse")
call s:hl("Todo",       "yellow", "none", "bold")

" --- git gutter ---
call s:hl("GitGutterAdd",          "green",  "none")
call s:hl("GitGutterChange",       "yellow", "none")
call s:hl("GitGutterDelete",       "red",    "none")
call s:hl("GitGutterChangeDelete", "red",    "none")

hi! link SignifySignAdd              GitGutterAdd
hi! link SignifySignDelete           GitGutterDelete
hi! link SignifySignDeleteFirstLine  SignifySignDelete
hi! link SignifySignChange           GitGutterChange
hi! link SignifySignChangeDelete     GitGutterChangeDelete

" --- diff ---
hi! link diffAdded   DiffAdd
hi! link diffRemoved DiffDelete
hi! link diffChanged DiffChange
hi! link diffSubname AtlasMuted

" --- fugitive ---
call s:hl("FugitiveblameHash",            "normal", "none")
call s:hl("FugitiveblameUncommitted",     "red",    "none")
call s:hl("FugitiveblameTime",            "yellow", "none")
call s:hl("FugitiveblameNotCommittedYet", "muted",  "none")

" --- gitcommit ---
call s:hl("gitcommitBranch",        "bright", "none")
call s:hl("gitcommitDiscardedFile", "red",    "none")
call s:hl("gitcommitSelectedFile",  "green",  "none")
call s:hl("gitcommitUntrackedFile", "yellow", "none")
call s:hl("gitcommitHeader",        "normal", "none")

hi! link gitcommitDiscardedType  gitcommitDiscardedFile
hi! link gitcommitSelectedType   gitcommitSelectedFile

" --- NERDTree ---
call s:hl("NERDTreeDir",      "normal", "none")
call s:hl("NERDTreeDirSlash", "muted",  "none")
call s:hl("NERDTreeFile",     "normal", "none")
call s:hl("NERDTreeCWD",      "bright", "none", "bold")
call s:hl("NERDTreeUp",       "muted",  "none")
call s:hl("NERDTreeOpenable", "red",    "none")
call s:hl("NERDTreeClosable", "green",  "none")
call s:hl("NERDTreeHelp",     "muted",  "none")
call s:hl("NERDTreeHelpKey",  "normal", "none")
call s:hl("NERDTreeHelpTitle","bright", "none", "bold")

" --- vim-plug ---
call s:hl("plug2",        "normal", "none")
call s:hl("plugH2",       "bright", "none", "bold")
call s:hl("plugBracket",  "normal", "none")
call s:hl("plugNumber",   "bright", "none")
call s:hl("plugDash",     "muted",  "none")
call s:hl("plugStar",     "normal", "none")
call s:hl("plugMessage",  "normal", "none")
call s:hl("plugName",     "bright", "none")
call s:hl("plugUpdate",   "yellow", "none")
call s:hl("plugEdge",     "muted",  "none")
call s:hl("plugSha",      "muted",  "none")
call s:hl("plugNotLoaded","dim",    "none")