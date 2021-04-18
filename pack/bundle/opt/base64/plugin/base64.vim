if exists('g:loaded_base64')
	finish
endif

let g:loaded_base64 = 1

command! -range=% ToBase64 call base64#to()
command! -range=% FromBase64 call base64#from()
