" ==============================================================
" Description:  CtrlP grep extension
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/ctrlp-grep
" Version:      1.1
" Licence:      BSD-3-Clause
" ==============================================================

if (exists('g:loaded_ctrlp_grep') && g:loaded_ctrlp_grep) ||
    \ (v:version < 700) || &compatible
  finish
endif

call add(g:ctrlp_ext_vars, {
  \ 'init': 'ctrlp#grep#init()',
  \ 'accept': 'ctrlp#acceptfile',
  \ 'lname': 'grep',
  \ 'sname': 'grep',
  \ 'type': 'line'
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

let g:loaded_ctrlp_grep = 1
