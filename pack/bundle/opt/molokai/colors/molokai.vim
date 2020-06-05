" Vim color file
"
" Author: Tomas Restrepo <tomas@winterdom.com>
" https://github.com/tomasr/molokai
"
" Note: Based on the Monokai theme for TextMate
" by Wimer Hazenberg and its darker variant
" by Hamish Stuart Macpherson
"
" Modified by: Rufus Deponian <deponian@pm.me>
" https://github.com/deponian/vim-molokai
"

highlight clear

if exists("syntax_on")
	syntax reset
endif

let g:colors_name="molokai"

hi Boolean         guifg=#AE81FF                               ctermfg=135
hi Character       guifg=#E6DB74                               ctermfg=144
hi ColorColumn                   guibg=#232526                              ctermbg=236
hi Comment         guifg=#7E8E91               gui=italic      ctermfg=59
hi Conditional     guifg=#F92672               gui=bold        ctermfg=161                cterm=bold
hi Constant        guifg=#AE81FF               gui=bold        ctermfg=135                cterm=bold
hi Cursor          guifg=#000000 guibg=#F8F8F0                 ctermfg=16   ctermbg=253
hi CursorColumn                  guibg=#293739                              ctermbg=236
hi CursorLine                    guibg=#293739                              ctermbg=234   cterm=none
hi CursorLineNr    guifg=#FD971F               gui=none        ctermfg=208                cterm=none
hi Debug           guifg=#BCA3A3               gui=bold        ctermfg=225                cterm=bold
hi Define          guifg=#66D9EF                               ctermfg=81
hi Delimiter       guifg=#8F8F8F                               ctermfg=241
hi DiffAdd                       guibg=#13354A                              ctermbg=24
hi DiffChange      guifg=#89807D guibg=#4C4745                 ctermfg=181  ctermbg=239
hi DiffDelete      guifg=#960050 guibg=#1E0010                 ctermfg=162  ctermbg=53
hi DiffText                      guibg=#4C4745 gui=italic,bold              ctermbg=102 cterm=bold
hi Directory       guifg=#A6E22E               gui=bold        ctermfg=118                cterm=bold
hi Error           guifg=#E6DB74 guibg=#1E0010                 ctermfg=219  ctermbg=89
hi ErrorMsg        guifg=#F92672 guibg=#232526 gui=bold        ctermfg=199  ctermbg=16    cterm=bold
hi Exception       guifg=#A6E22E               gui=bold        ctermfg=118                cterm=bold
hi Float           guifg=#AE81FF                               ctermfg=135
hi FoldColumn      guifg=#465457 guibg=#000000                 ctermfg=67   ctermbg=16
hi Folded          guifg=#465457 guibg=#000000                 ctermfg=67   ctermbg=16
hi Function        guifg=#A6E22E                               ctermfg=118
hi Identifier      guifg=#FD971F                               ctermfg=208                cterm=none
hi Ignore          guifg=#808080 guibg=bg                      ctermfg=244  ctermbg=232
hi IncSearch       guifg=#FD971F guibg=#000000                 ctermfg=208  ctermbg=16
hi Keyword         guifg=#F92672               gui=bold        ctermfg=161                cterm=bold
hi Label           guifg=#E6DB74               gui=none        ctermfg=229                cterm=none
hi LineNr          guifg=#465457 guibg=#232526                 ctermfg=250  ctermbg=236
hi Macro           guifg=#C4BE89               gui=italic      ctermfg=193
hi MatchParen      guifg=#000000 guibg=#FD971F gui=bold        ctermfg=233   ctermbg=208 cterm=bold
hi ModeMsg         guifg=#E6DB74                               ctermfg=229
hi MoreMsg         guifg=#E6DB74                               ctermfg=229
hi NonText         guifg=#465457                               ctermfg=59
hi Normal          guifg=#F8F8F2 guibg=#1B1D1E                 ctermfg=252  ctermbg=233
hi Number          guifg=#AE81FF                               ctermfg=135
hi Operator        guifg=#F92672                               ctermfg=161
hi Pmenu           guifg=#66D9EF guibg=#000000                 ctermfg=81   ctermbg=16
hi PmenuSbar                     guibg=#080808                              ctermbg=232
hi PmenuSel                      guibg=#808080                 ctermfg=255  ctermbg=242
hi PmenuThumb      guifg=#66D9EF                               ctermfg=81
hi PreCondit       guifg=#A6E22E               gui=bold        ctermfg=118                cterm=bold
hi PreProc         guifg=#A6E22E                               ctermfg=118
hi Question        guifg=#66D9EF                               ctermfg=81
hi Repeat          guifg=#F92672               gui=bold        ctermfg=161                cterm=bold
hi Search          guifg=#000000 guibg=#FFE792                 ctermfg=0    ctermbg=222   cterm=NONE
hi SignColumn      guifg=#A6E22E guibg=#232526                 ctermfg=118  ctermbg=235
hi Special         guifg=#66D9EF guibg=bg      gui=italic      ctermfg=81
hi SpecialChar     guifg=#F92672               gui=bold        ctermfg=161                cterm=bold
hi SpecialComment  guifg=#7E8E91               gui=bold        ctermfg=245                cterm=bold
hi SpecialKey      guifg=#465457                               ctermfg=59
hi SpecialKey      guifg=#66D9EF               gui=italic      ctermfg=81
hi SpellBad        guisp=#FF0000 gui=undercurl                              ctermbg=52
hi SpellCap        guisp=#7070F0 gui=undercurl                              ctermbg=17
hi SpellLocal      guisp=#70F0F0 gui=undercurl                              ctermbg=17
hi SpellRare       guisp=#FFFFFF gui=undercurl                 ctermfg=none ctermbg=none  cterm=reverse
hi Statement       guifg=#F92672               gui=bold        ctermfg=161                cterm=bold
hi StatusLine      guifg=#455354 guibg=fg                      ctermfg=238  ctermbg=253
hi StatusLineNC    guifg=#808080 guibg=#080808                 ctermfg=244  ctermbg=232
hi StorageClass    guifg=#FD971F               gui=italic      ctermfg=208
hi String          guifg=#E6DB74                               ctermfg=144
hi Structure       guifg=#66D9EF                               ctermfg=81
hi TabLine         guibg=#1B1D1E guifg=#808080 gui=none        ctermfg=233  ctermbg=244   cterm=none
hi TabLineFill     guifg=#1B1D1E guibg=#1B1D1E                 ctermfg=233  ctermbg=233
hi Tag             guifg=#F92672               gui=italic      ctermfg=161
hi Title           guifg=#EF5939                               ctermfg=166
hi Todo            guifg=#FFFFFF guibg=bg      gui=bold        ctermfg=231  ctermbg=232   cterm=bold
hi Type            guifg=#66D9EF               gui=none        ctermfg=81                 cterm=none
hi Typedef         guifg=#66D9EF                               ctermfg=81
hi Underlined      guifg=#808080               gui=underline   ctermfg=244                cterm=underline
hi VertSplit       guifg=#808080 guibg=#080808 gui=bold        ctermfg=244  ctermbg=232   cterm=bold
hi Visual                        guibg=#403D3D                              ctermbg=235
hi VisualNOS                     guibg=#403D3D                              ctermbg=238
hi WarningMsg      guifg=#FFFFFF guibg=#333333 gui=bold        ctermfg=231  ctermbg=238   cterm=bold
hi WildMenu        guifg=#66D9EF guibg=#000000                 ctermfg=81   ctermbg=16
hi iCursor         guifg=#000000 guibg=#F8F8F0                 ctermfg=16   ctermbg=253

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
