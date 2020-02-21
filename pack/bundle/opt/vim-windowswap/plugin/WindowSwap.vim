if !exists('g:windowswap_map_keys')
   let g:windowswap_map_keys = 1
endif

if !exists('g:windowswap_mapping_deprecation_notice')
   let g:windowswap_mapping_deprecation_notice = 1
endif

if g:windowswap_map_keys
   nnoremap <silent> <leader>s :call WindowSwap#EasyWindowSwap()<CR>
endif

let g:loaded_windowswap = 1
