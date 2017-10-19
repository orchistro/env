" Define function

function! s:RunMakeTags()

    let directory = input("Directory to run ctags: ", "")

    if directory == ""
        return
    endif

    echomsg directory

    let dirlist = []
    call add(dirlist, glob("~/env/tags/*"))

    for f in dirlist
        echo f
    endfor

endfunction

" Define command

command! -nargs=* -complete=dir MakeTags call s:RunMakeTags()


