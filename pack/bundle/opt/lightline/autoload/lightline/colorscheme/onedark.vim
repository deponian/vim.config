" =============================================================================
" Filename: autoload/lightline/colorscheme/onedark.vim
" Author: Zoltan Dalmadi
" License: MIT License
" Last Change: 2019/09/09 22:42:48.
" Modified By: Rufus Deponian <deponian@pm.me>
" =============================================================================

" Colors
let s:blue   = [ '#61afef', 75 ]
let s:green  = [ '#98c379', 76 ]
let s:purple = [ '#c678dd', 176 ]
let s:red1   = [ '#e06c75', 168 ]
let s:red2   = [ '#be5046', 168 ]
let s:yellow = [ '#e5c07b', 180 ]
let s:gray1  = [ '#5c6370', 241 ]
let s:gray2  = [ '#282c34', 235 ]
let s:gray3  = [ '#3e4452', 240 ]
let s:fg     = [ '#abb2bf', 145 ]
let s:bg     = [ '#282c34', 235 ]
let s:none   = ['NONE', 'NONE']

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.inactive.left   = [ [ s:gray1,  s:bg ], [ s:gray1, s:bg ] ]
let s:p.inactive.middle = [ [ s:gray1, s:gray2 ] ]
let s:p.inactive.right  = [ [ s:gray1, s:bg ] ]
let s:p.normal.left     = [ [ s:bg, s:green, 'bold' ], 
						\   [ s:red1, s:gray3 ], 
						\   [ s:yellow, s:gray3	],
						\   [ s:green, s:gray2 ] ]
let s:p.normal.middle   = [ [ s:fg, s:gray2 ] ]
let s:p.normal.right    = [ [ s:bg, s:green, 'bold' ], [ s:fg, s:gray3 ], [s:green, s:gray2] ]
let s:p.normal.error    = [ [ s:red2, s:bg ] ]
let s:p.normal.warning  = [ [ s:yellow, s:bg ] ]
let s:p.insert.right    = [ [ s:bg, s:blue, 'bold' ], [ s:fg, s:gray3 ], [s:blue, s:gray2] ]
let s:p.insert.left     = [ [ s:bg, s:blue, 'bold' ],
						\   [ s:red1, s:gray3 ],
						\   [ s:yellow, s:gray3 ],
						\   [ s:blue, s:gray2 ] ]
let s:p.replace.right   = [ [ s:bg, s:red1, 'bold' ], [ s:fg, s:gray3 ], [s:red1, s:gray2] ]
let s:p.replace.left    = [ [ s:bg, s:red1, 'bold' ], 
						\   [ s:red1, s:gray3 ],
						\   [ s:yellow, s:gray3 ],
						\   [ s:red1, s:gray2 ] ]
let s:p.visual.right    = [ [ s:bg, s:purple, 'bold' ], [ s:fg, s:gray3 ], [s:purple, s:gray2] ]
let s:p.visual.left     = [ [ s:bg, s:purple, 'bold' ],
						\   [ s:red1, s:gray3 ],
						\   [ s:yellow, s:gray3 ],
						\   [ s:purple, s:gray2 ] ]
let s:p.tabline.left    = [ [ s:none, s:none ] ]
let s:p.tabline.tabsel  = [ [ s:green, s:none, 'bold' ] ]
let s:p.tabline.middle  = [ [ s:none, s:none ] ]
let s:p.tabline.right   = copy(s:p.normal.right)

let g:lightline#colorscheme#onedark#palette = lightline#colorscheme#flatten(s:p)
