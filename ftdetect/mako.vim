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

au BufRead,BufNewFile *.mako     set filetype=mako
autocmd BufNewFile,BufRead *.html call s:SelectHTML()
