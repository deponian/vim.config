if exists("loaded_detectindent")
    finish
endif
let loaded_detectindent = 1

augroup detectindent
  au!
  au BufReadPost *.py call detectindent#detect()
augroup End

