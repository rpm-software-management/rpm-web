function! s:cycle()
    let l:cmds = ['    ', 'drop', 'pick']
    let l:line = getline('.')
    let l:i = index(l:cmds, l:line[0:3])
    if l:i < 0
        return
    endif
    let l:next = l:cmds[(l:i + 1) % len(l:cmds)]
    call setline('.', l:next . l:line[4:])
endfunction

function! s:hash()
    let l:line = getline('.')
    if empty(l:line) || l:line[0] == '#'
        return
    endif
    return split(l:line[5:], ' ')[0]
endfunction

function! s:gitshow()
    let l:hash = s:hash()
    if empty(l:hash)
        return
    endif
    silent exec "!git show --stat -p --color " . s:hash() . " | less -cR" |
    \   redraw!
endfunction

function! s:propen()
    let l:hash = s:hash()
    if empty(l:hash)
        return
    endif
    let l:out = systemlist("git changeset " . l:hash)
    if empty(l:out)
        echo "No changeset associated with this commit."
        return
    endif
    silent exec "!xdg-open " . l:out[2] | redraw!
endfunction

function! s:print_err(msg) abort
    execute 'normal! \<Esc>'
    echohl ErrorMsg
    echomsg a:msg
    echohl None
endfunction

function! s:plancheck()
    silent write
    let l:out = systemlist("git cherry-plan -f " . expand('%') . " check -s")
    if v:shell_error == 0
        echo "Plan applies cleanly"
    elseif v:shell_error == 1
        call search(l:out[0])
        call s:print_err("Conflicting commit, jumping to it")
    elseif v:shell_error == 2
        call s:print_err("Empty commit")
    else
        call s:print_err("Plan check error " . v:shell_error)
    endif
endfunction

function! s:init()
    nmap <buffer> <silent> <NUL>        :call <sid>cycle()<CR>
    nmap <buffer> <silent> <CR>         :call <sid>gitshow()<CR>
    nmap <buffer> <silent> gx           :call <sid>propen()<CR>
    nmap <buffer> <silent> <F8>         :call <sid>plancheck()<CR>
endfunction

autocmd BufNewFile,BufRead *.plan call <sid>init()
