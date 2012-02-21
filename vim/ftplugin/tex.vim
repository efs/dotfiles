map <F7> :w<CR>:make %<<CR>
map <F8> :!xpdf -fullscreen %<.pdf &<CR>
map <F9> :cprev<CR>
map <F10> :cnext<CR>
map <F11> :clist<CR>


let b:tex_flavor = 'pdflatex'
:
compiler tex
set makeprg=pdflatex\ \-file\-line\-error\ \-interaction=nonstopmode\ -\-shell\-escape
set errorformat=%f:%l:\ %m
set spell
