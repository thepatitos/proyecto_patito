" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    patito_header.vim                                  :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: Patito-entrenador                           +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2026/11/17 23:00:00 by Patito            #+#    #+#              "
"    Updated: 2026/11/17 23:00:00 by Patito           ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

if exists("g:loaded_patito_header")
    finish
endif
let g:loaded_patito_header = 1

let s:ascii_duck = [
      \ "    _      ",
      \ "  >(.)__   ",
      \ "   (___/   ",
      \ "  ~~~~~~~  ",
      \ "           ",
      \ "    _      ",
      \ "  >(.)__   "
      \ ]

function! s:GetUser()
    let l:user = $USER
    if empty(l:user)
        let l:user = "estudiante"
    endif
    let l:user = substitute(l:user, '[^a-zA-Z0-9_-]', '', 'g')
    if empty(l:user)
        let l:user = "estudiante"
    endif
    return strpart(l:user, 0, 12)
endfunction

function! s:GetFileName()
    let l:fname = expand("%:t")
    if empty(l:fname)
        let l:fname = "sin_nombre.c"
    endif
    return strpart(l:fname, 0, 40)
endfunction

function! s:PadLine(left_text, right_art)
    let l:content = "/* " . a:left_text
    let l:target_len = 80 - strlen(a:right_art) - 3
    while strlen(l:content) < l:target_len
        let l:content .= " "
    endwhile
    return strpart(l:content, 0, l:target_len) . a:right_art . " */"
endfunction

function! s:MakeHeader()
    let l:user = s:GetUser()
    let l:mail = l:user . "@patito.local"
    let l:fname = s:GetFileName()
    let l:now = strftime("%Y/%m/%d %H:%M:%S")

    let l:lines = []
    call add(l:lines, "/* ************************************************************************** */")
    call add(l:lines, s:PadLine("", s:ascii_duck[0]))
    call add(l:lines, s:PadLine("", s:ascii_duck[1]))
    call add(l:lines, s:PadLine(l:fname, s:ascii_duck[2]))
    call add(l:lines, s:PadLine("", s:ascii_duck[3]))
    call add(l:lines, s:PadLine("By: " . l:user . " <" . l:mail . ">", s:ascii_duck[4]))
    call add(l:lines, s:PadLine("", s:ascii_duck[5]))
    call add(l:lines, s:PadLine("Created: " . l:now . " by " . l:user, s:ascii_duck[6]))
    call add(l:lines, s:PadLine("Updated: " . l:now . " by " . l:user, "  ~~~~~~~  "))
    call add(l:lines, s:PadLine("", "           "))
    call add(l:lines, "/* ************************************************************************** */")
    return l:lines
endfunction

function! s:IsHeaderPresent()
    if line("$") < 11
        return 0
    endif
    let l:l1 = getline(1)
    let l:l11 = getline(11)
    return (l:l1 =~ '^/\* \*\+ \*/$' && l:l11 =~ '^/\* \*\+ \*/$' && strlen(l:l1) == 80 && strlen(l:l11) == 80)
endfunction

function! PatitoHeader()
    let l:now = strftime("%Y/%m/%d %H:%M:%S")
    let l:user = s:GetUser()
    if s:IsHeaderPresent()
        let l:fname = s:GetFileName()
        call setline(4, s:PadLine(l:fname, s:ascii_duck[2]))
        call setline(9, s:PadLine("Updated: " . l:now . " by " . l:user, "  ~~~~~~~  "))
    else
        let l:header = s:MakeHeader()
        call append(0, l:header)
        if getline(12) != ""
            call append(11, "")
        endif
    endif
endfunction

command! Stdheader call PatitoHeader()
nnoremap <F1> :Stdheader<CR>
