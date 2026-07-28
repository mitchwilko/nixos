set background=dark
hi clear
if exists("syntax_on")
      syntax reset
endif
let g:colors_name="atlas"

" 16 named ANSI colors:
"   black, darkgray              = backgrounds, subtle chrome
"   lightgray, white             = normal fg, bright fg
"   red                          = errors, operators, deletes
"   yellow                       = warnings, TODOs
"   green                        = additions

" --- UI ---
hi Normal           ctermfg=lightgray   ctermbg=NONE        cterm=NONE
hi Comment          ctermfg=darkgray    ctermbg=NONE        cterm=NONE
hi LineNr           ctermfg=darkgray    ctermbg=NONE        cterm=NONE
hi CursorLine       ctermfg=NONE        ctermbg=NONE        cterm=underline
hi CursorLineNr     ctermfg=white       ctermbg=NONE        cterm=NONE
hi ColorColumn      ctermfg=NONE        ctermbg=black       cterm=NONE
hi CursorColumn     ctermfg=NONE        ctermbg=black       cterm=NONE
hi SignColumn       ctermfg=darkgray    ctermbg=NONE        cterm=NONE
hi VertSplit        ctermfg=black       ctermbg=black       cterm=NONE
hi Folded           ctermfg=darkgray    ctermbg=NONE        cterm=NONE
hi FoldColumn       ctermfg=darkgray    ctermbg=NONE        cterm=NONE
hi NonText          ctermfg=darkgray    ctermbg=NONE        cterm=NONE
hi SpecialKey       ctermfg=darkgray    ctermbg=NONE        cterm=NONE
hi Visual           ctermfg=black       ctermbg=lightgray   cterm=NONE
hi VisualNOS        ctermfg=black       ctermbg=lightgray   cterm=NONE
hi Directory        ctermfg=white       ctermbg=NONE        cterm=NONE
hi Title            ctermfg=white       ctermbg=NONE        cterm=bold
hi MatchParen       ctermfg=red         ctermbg=NONE        cterm=bold
hi Search           ctermfg=white       ctermbg=NONE        cterm=bold,underline
hi IncSearch        ctermfg=black       ctermbg=white       cterm=NONE
hi WildMenu         ctermfg=black       ctermbg=lightgray   cterm=bold
hi PMenu            ctermfg=black       ctermbg=lightgray   cterm=NONE
hi PMenuSel         ctermfg=white       ctermbg=darkgray    cterm=NONE
hi PmenuSbar        ctermfg=lightgray   ctermbg=lightgray   cterm=NONE
hi PmenuThumb       ctermfg=white       ctermbg=white       cterm=NONE
hi StatusLine       ctermfg=lightgray   ctermbg=black       cterm=bold
hi StatusLineNC     ctermfg=darkgray    ctermbg=black       cterm=NONE
hi TabLine          ctermfg=darkgray    ctermbg=black       cterm=NONE
hi TabLineFill      ctermfg=NONE        ctermbg=black       cterm=NONE
hi TabLineSel       ctermfg=white       ctermbg=NONE        cterm=bold
hi Question         ctermfg=lightgray   ctermbg=NONE        cterm=NONE
hi WarningMsg       ctermfg=yellow      ctermbg=NONE        cterm=NONE
hi ErrorMsg         ctermfg=red         ctermbg=NONE        cterm=reverse

" --- Diffs ---
hi DiffAdd          ctermfg=NONE        ctermbg=black       cterm=NONE
hi DiffChange       ctermfg=NONE        ctermbg=black       cterm=NONE
hi DiffDelete       ctermfg=red         ctermbg=black       cterm=NONE
hi DiffText         ctermfg=NONE        ctermbg=NONE        cterm=reverse
hi diffAdded        ctermfg=green       ctermbg=NONE        cterm=NONE
hi diffRemoved      ctermfg=red         ctermbg=NONE        cterm=NONE
hi diffChanged      ctermfg=lightgray   ctermbg=NONE        cterm=NONE
hi diffSubname      ctermfg=darkgray    ctermbg=NONE        cterm=NONE

" --- Spell ---
hi SpellBad         ctermfg=red         ctermbg=NONE        cterm=underline
hi SpellLocal       ctermfg=yellow      ctermbg=NONE        cterm=underline
hi SpellCap         ctermfg=lightgray   ctermbg=NONE        cterm=underline
hi SpellRare        ctermfg=darkgray    ctermbg=NONE        cterm=underline

" --- Syntax ---
hi Constant         ctermfg=lightgray   ctermbg=NONE        cterm=NONE
hi String           ctermfg=lightgray   ctermbg=NONE        cterm=NONE
hi Character        ctermfg=lightgray   ctermbg=NONE        cterm=NONE
hi Number           ctermfg=white       ctermbg=NONE        cterm=NONE
hi Boolean          ctermfg=white       ctermbg=NONE        cterm=NONE
hi Float            ctermfg=white       ctermbg=NONE        cterm=NONE
hi Identifier       ctermfg=lightgray   ctermbg=NONE        cterm=NONE
hi Function         ctermfg=white       ctermbg=NONE        cterm=NONE
hi Statement        ctermfg=white       ctermbg=NONE        cterm=NONE
hi Conditional      ctermfg=white       ctermbg=NONE        cterm=NONE
hi Operator         ctermfg=red         ctermbg=NONE        cterm=NONE
hi Exception        ctermfg=red         ctermbg=NONE        cterm=NONE
hi PreProc          ctermfg=lightgray   ctermbg=NONE        cterm=NONE
hi Type             ctermfg=white       ctermbg=NONE        cterm=NONE
hi Special          ctermfg=white       ctermbg=NONE        cterm=NONE
hi Underlined       ctermfg=NONE        ctermbg=NONE        cterm=underline
hi Error            ctermfg=red         ctermbg=NONE        cterm=reverse
hi Todo             ctermfg=yellow      ctermbg=NONE        cterm=bold

" --- Git gutter ---
hi GitGutterAdd             ctermfg=green       ctermbg=NONE    cterm=NONE
hi GitGutterChange          ctermfg=yellow      ctermbg=NONE    cterm=NONE
hi GitGutterDelete          ctermfg=red         ctermbg=NONE    cterm=NONE
hi GitGutterChangeDelete    ctermfg=red         ctermbg=NONE    cterm=NONE
hi link SignifySignAdd              GitGutterAdd
hi link SignifySignDelete           GitGutterDelete
hi link SignifySignDeleteFirstLine  SignifySignDelete
hi link SignifySignChange           GitGutterChange
hi link SignifySignChangeDelete     GitGutterChangeDelete

" --- Fugitive ---
hi FugitiveblameHash                ctermfg=lightgray   ctermbg=NONE    cterm=NONE
hi FugitiveblameUncommitted         ctermfg=red         ctermbg=NONE    cterm=NONE
hi FugitiveblameTime                ctermfg=yellow      ctermbg=NONE    cterm=NONE
hi FugitiveblameNotCommittedYet     ctermfg=darkgray    ctermbg=NONE    cterm=NONE

" --- gitcommit ---
hi gitcommitBranch          ctermfg=white       ctermbg=NONE    cterm=NONE
hi gitcommitDiscardedType   ctermfg=red         ctermbg=NONE    cterm=NONE
hi gitcommitSelectedType    ctermfg=green       ctermbg=NONE    cterm=NONE
hi gitcommitHeader          ctermfg=lightgray   ctermbg=NONE    cterm=NONE
hi gitcommitUntrackedFile   ctermfg=yellow      ctermbg=NONE    cterm=NONE
hi gitcommitDiscardedFile   ctermfg=red         ctermbg=NONE    cterm=NONE
hi gitcommitSelectedFile    ctermfg=green       ctermbg=NONE    cterm=NONE

" --- NERDTree ---
hi NERDTreeHelp         ctermfg=lightgray   ctermbg=NONE    cterm=NONE
hi NERDTreeHelpKey      ctermfg=yellow      ctermbg=NONE    cterm=NONE
hi NERDTreeHelpCommand  ctermfg=white       ctermbg=NONE    cterm=NONE
hi NERDTreeHelpTitle    ctermfg=white       ctermbg=NONE    cterm=bold
hi NERDTreeUp           ctermfg=lightgray   ctermbg=NONE    cterm=NONE
hi NERDTreeCWD          ctermfg=white       ctermbg=NONE    cterm=NONE
hi NERDTreeOpenable     ctermfg=red         ctermbg=NONE    cterm=NONE
hi NERDTreeClosable     ctermfg=yellow      ctermbg=NONE    cterm=NONE

" --- vim-plug ---
hi plug2            ctermfg=lightgray   ctermbg=NONE    cterm=NONE
hi plugH2           ctermfg=white       ctermbg=NONE    cterm=bold
hi plugBracket      ctermfg=lightgray   ctermbg=NONE    cterm=NONE
hi plugNumber       ctermfg=white       ctermbg=NONE    cterm=NONE
hi plugDash         ctermfg=darkgray    ctermbg=NONE    cterm=NONE
hi plugStar         ctermfg=lightgray   ctermbg=NONE    cterm=NONE
hi plugMessage      ctermfg=lightgray   ctermbg=NONE    cterm=NONE
hi plugName         ctermfg=white       ctermbg=NONE    cterm=NONE
hi plugUpdate       ctermfg=yellow      ctermbg=NONE    cterm=NONE
hi plugEdge         ctermfg=darkgray    ctermbg=NONE    cterm=NONE
hi plugSha          ctermfg=darkgray    ctermbg=NONE    cterm=NONE
hi plugNotLoaded    ctermfg=darkgray    ctermbg=NONE    cterm=NONE
