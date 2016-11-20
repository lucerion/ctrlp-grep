" ==============================================================
" Description:  CtrlP grep extension
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/ctrlp-grep
" Version:      1.2
" Licence:      BSD-3-Clause
" ==============================================================

if !exists('g:ctrlp_grep_command')
  let g:ctrlp_grep_command = 'grep -rins'
endif

comm! -nargs=* -complete=dir CtrlPGrep call ctrlp#grep#run(<f-args>)
