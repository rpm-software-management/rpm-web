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

function! s:gitshow()
    let l:hash = split(getline('.')[5:], ' ')[0]
    silent exec "!git show --color " . l:hash . " | less -cR" | redraw!
endfunction

function! s:initplan()
    nmap <buffer> <silent> <C-A>    :call <sid>cycle()<CR>
    nmap <buffer> <silent> <CR>     :call <sid>gitshow()<CR>
endfunction

autocmd BufNewFile,BufRead *.plan call <sid>initplan()
