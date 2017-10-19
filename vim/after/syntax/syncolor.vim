" Altibase 용 소스코드 하이라이팅 for gvim
" Shawn <shawn@altibase.com>
"
" hilight 가 어느 파일에서 세팅되었나를 알아보려면,
" :verbose hi keyword 하면 된다.
" 예) :verbose hi Comment

" pinkish
hi Todo                 term=inverse cterm=none ctermfg=Blue        ctermbg=Brown gui=none guifg=Blue        guibg=#99ee66
hi Comment              term=none    cterm=none ctermfg=DarkBlue                  gui=none guifg=#2a81db
hi Type                 term=none    cterm=none ctermfg=DarkGreen                 gui=none guifg=#5db736
hi Constant             term=none    cterm=none ctermfg=DarkMagenta               gui=none guifg=#b35a27
hi Statement            term=none    cterm=none ctermfg=DarkRed                   gui=BOLD guifg=#d6972e
hi AltibaseAssertion    term=none    cterm=none ctermfg=DarkRed                   gui=none guifg=#e37eff
hi AltibaseException    term=none    cterm=none ctermfg=DarkMagenta               gui=none guifg=#888888
hi ShawnNote            term=BOLD    cterm=BOLD ctermfg=Black                     gui=BOLD guifg=#000000
hi IDULIST              term=none    cterm=none ctermfg=Black                     gui=none guifg=#ff7ec9
hi UlnFlag              term=none    cterm=none ctermfg=Black                     gui=none guifg=#ec7514     guibg=White
hi IdeReturn            term=none    cterm=none ctermfg=DarkMagenta               gui=none guifg=#ff5f5f

" hi Search               term=none    cterm=none                                   gui=none                   guibg=#fcbbff
" hi IncSearch            term=none    cterm=none                                   gui=none                   guibg=#fcbbff

" greenish
" hi Comment              term=none    cterm=none ctermfg=DarkBlue                  gui=none guifg=#ccdd00
" hi AltibaseAssertion    term=none    cterm=none ctermfg=DarkRed                   gui=none guifg=#aacc00
" hi AltibaseException    term=none    cterm=none ctermfg=DarkMagenta               gui=none guifg=#aacc00
" hi Search               term=none    cterm=none                                   gui=none                   guibg=#ccff77
" hi IncSearch            term=none    cterm=none                                   gui=none                   guibg=#ccff77
" hi Statement            term=none    cterm=none ctermfg=DarkRed                   gui=none guifg=#667700
" hi Type                 term=none    cterm=none ctermfg=DarkRed                   gui=none guifg=#667700
hi Search               term=none    cterm=none                                   gui=reverse                   guifg=#ddff00 guibg=#225522
hi IncSearch            term=none    cterm=none                                   gui=reverse                   guifg=#ddff00 guibg=#225522
