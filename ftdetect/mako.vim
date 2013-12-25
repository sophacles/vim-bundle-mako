if !exists("g:mako_detect_lang_from_ext")
  let g:mako_detect_lang_from_ext = 1
endif
if !exists("g:mako_extension")
  let g:mako_extension = ".mako"
endif
if g:mako_detect_lang_from_ext
  exe 'au BufNewFile *.*' . g:mako_extension . ' execute "do BufNewFile filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype'
  " it's important to get this before any of the normal BufRead autocmds execute
  " for this file, otherwise a mako tag at the start of the file can cause the
  " filetype to be set to mason
  exe 'au BufReadPre *.*' . g:mako_extension . ' execute "do BufRead filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype'
endif
exe 'au BufRead,BufNewFile *' . g:mako_extension . ' set filetype=mako'
autocmd BufNewFile,BufRead *.html call s:SelectHTML()

" Figure out which type of hilighting to use for html
fun! s:SelectHTML()
  let n = 1
  while n < 5 && n <= line("$")
    " check for mako
    if getline(n) =~ '<%.*'
      set ft=mako
      return
    endif
    let n = n + 1
  endwhile
endfun

