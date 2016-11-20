" ==============================================================
" Description:  CtrlP grep extension
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/ctrlp-grep
" Version:      1.2
" Licence:      BSD-3-Clause
" ==============================================================

if (exists('g:loaded_ctrlp_grep') && g:loaded_ctrlp_grep) ||
    \ (v:version < 700) || &compatible
  finish
endif

call add(g:ctrlp_ext_vars, {
  \ 'init': 'ctrlp#grep#init()',
  \ 'accept': 'ctrlp#grep#accept',
  \ 'lname': 'grep',
  \ 'sname': 'grep',
  \ 'type': 'line',
  \ 'opmul': 1
  \ })

func! ctrlp#grep#run(...)
  let l:pattern = get(a:000, 0, expand('<cword>'))
  let l:dirs = a:0 > 1 ? join(a:000[1:-1]) : '.'
  let s:result = system(g:ctrlp_grep_command . ' ' . l:pattern . ' ' . l:dirs)
  call ctrlp#init(ctrlp#grep#id())
endfunc

func! ctrlp#grep#init()
  return split(s:result, "\n")
endfunc

func! ctrlp#grep#id()
  return g:ctrlp_builtins + len(g:ctrlp_ext_vars)
endfunc

func! ctrlp#grep#accept(mode, str)
  let l:marked_list = ctrlp#getmarkedlist()

  if empty(l:marked_list)
    let l:marked_list = [a:str]
  endif

  for l:marked in l:marked_list
    call ctrlp#acceptfile(a:mode, l:marked)
  endfor
endfunc

let g:loaded_ctrlp_grep = 1
