if $OS_NAME == "osx"
    set guifont=Bitstream\ Vera\ Sans\ Mono:h12
elseif $OS_NAME == "windows"
    set guifont=µ¸¿òÃ¼:h10:cHANGEUL
elseif $OS_NAME == "linux"
    " GTK+ 2
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 8.7
    set guifontwide=Nanum\ Gothic\ 8.7
else
    " GTK+ 1.2
    set guifontset=6x13,-sun-gothic-medium-r-normal-*-12-*-*-*-*-*-ksc5601.1987-0
    " In the file /usr/local/share/vim/vim70/syntax/doxygen.vim
    " Because of if guifont == '' let font='font=-b&h-lucid.....
    " An annoying message keep coming out to the terminal.
    " In order to supress it, set guifont.
    set guifont=Bitstream\ Vera\ Sans\ Mono:h11
endif

set background=light
set mousemodel=popup

" Background is white
hi Normal guibg=white
 
" Shift + left mouse click: search the word under the pointer
" Shift + right mouse click: search the word under the pointer, full matching
nnoremap <S-LeftMouse> <LeftMouse>g*
nnoremap <S-RightMouse> <LeftMouse>*

" Prevent pasting with the middle button
nnoremap <MiddleMouse> <Nop>
inoremap <MiddleMouse> <Nop>
nnoremap <2-MiddleMouse> <Nop>
inoremap <2-MiddleMouse> <Nop>
nnoremap <3-MiddleMouse> <Nop>
inoremap <3-MiddleMouse> <Nop>
nnoremap <4-MiddleMouse> <Nop>
inoremap <4-MiddleMouse> <Nop>

" gui option: menu and toolbar
set go=mLriT

" When GUI starts, 't_vb' is reset to its default value.
" In order to keep bell from beeping, 't_vb=' must also be in gvimrc.
set vb t_vb=
