function! detectindent#is_comment_line(line) abort
    return a:line =~ '^\s*#'
endfunction

function! detectindent#detect() abort
    let l:has_leading_tabs            = 0
    let l:has_leading_spaces          = 0
    let l:shortest_leading_spaces_run = 0
    let l:shortest_leading_spaces_idx = 0
    let l:longest_leading_spaces_run  = 0
    let l:max_lines                   = 512

    let l:idx_end = line("$")
    let l:idx = 1
    while l:idx <= l:idx_end
        let l:line = getline(l:idx)

        " Skip comment lines
        if detectindent#is_comment_line(l:line)
            let l:idx = l:idx + 1
            continue
        endif

        " Skip lines that are solely whitespace, since they're less likely to
        " be properly constructed.
        if l:line !~ '\S'
            let l:idx = l:idx + 1
            continue
        endif

        let l:leading_char = strpart(l:line, 0, 1)

        if l:leading_char == "\t"
            let l:has_leading_tabs = 1

        elseif l:leading_char == " "
            " only interested if we don't have a run of spaces followed by a tab.
            if match(l:line, '^ \+\t') == -1
                let l:has_leading_spaces = 1
                let l:spaces = strlen(matchstr(l:line, '^ \+'))
                if l:shortest_leading_spaces_run == 0 || l:spaces < l:shortest_leading_spaces_run
                    let l:shortest_leading_spaces_run = l:spaces
                    let l:shortest_leading_spaces_idx = l:idx
                endif
                if l:spaces > l:longest_leading_spaces_run
                    let l:longest_leading_spaces_run = l:spaces
                endif
            endif
        endif

        let l:idx = l:idx + 1
        let l:max_lines = l:max_lines - 1
        if l:max_lines == 0
            let l:idx = l:idx_end + 1
        endif

    endwhile

    if l:has_leading_tabs && ! l:has_leading_spaces
        " tabs only, no spaces
        setl noexpandtab

    elseif l:has_leading_spaces && ! l:has_leading_tabs
        " spaces only, no tabs
        setl expandtab
        let &l:shiftwidth  = l:shortest_leading_spaces_run
        let &l:softtabstop = l:shortest_leading_spaces_run
        let &l:tabstop = l:shortest_leading_spaces_run

    elseif l:has_leading_spaces && l:has_leading_tabs
        " spaces and tabs
        setl noexpandtab
        let &l:shiftwidth = l:shortest_leading_spaces_run

        " mmmm, time to guess how big tabs are
        if l:longest_leading_spaces_run <= 2
            let &l:tabstop = 2
            let &l:softtabstop = 2
        else
            let &l:tabstop = 4
            let &l:softtabstop = 4
        endif
    endif
endfunction

