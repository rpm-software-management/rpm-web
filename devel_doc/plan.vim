let s:gitchset = trim(system("git config --get cherryPlan.changesetCmd"))

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
    silent exec "!git show --color " . s:hash() . " | less -cR" | redraw!
endfunction

function! s:propen()
    let l:hash = s:hash()
    if empty(l:hash)
        return
    endif
    let l:url = systemlist(s:gitchset . " " . l:hash)
    if empty(l:url)
        echo "No changeset associated with this commit."
        return
    endif
    silent exec "!xdg-open " . l:url[1] | redraw!
endfunction

function! s:init()
    nmap <buffer> <silent> <C-SPACE>    :call <sid>cycle()<CR>
    nmap <buffer> <silent> <CR>         :call <sid>gitshow()<CR>
    nmap <buffer> <silent> gx           :call <sid>propen()<CR>
endfunction

autocmd BufNewFile,BufRead *.plan call <sid>init()
