" Copyright (c) 2014 Junegunn Choi
"
" MIT License
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
" NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
" OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
" WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

if exists('g:loaded_after_object')
  finish
endif
let g:loaded_after_object = 1

let s:cpo_save = &cpo
set cpo&vim

function! s:after(str, cnt, vis, bw)
  let col = a:vis ? col("'<") : col('.')
  let line = getline('.')
  let parts = split(line, '\V'.a:str.'\zs', 1)

  try
    if len(parts) == 1
      throw 'exit'
    endif

    for i in reverse(range(1, a:cnt))
      let len = 0
      let idx = 0
      for part in parts[0 : (a:bw ? -2 : -3)]
        let len += len(part)
        if len > col - 1
          break
        endif
        let idx += 1
      endfor

      if a:bw
        let idx = max([idx - 2, 0])
      endif
      let col = len(join(parts[0 : idx], '')) + (i > 1 && a:cnt > 1)
    endfor

    let rest = line[col : -1]
    if empty(rest)
      throw 'exit'
    else
      let idx = max([match(rest, '\S'), 0])
      execute 'normal! '.(col + idx + 1).'|v$h'
    endif
  catch 'exit'
    if a:vis
      normal! gv
    endif
  endtry
endfunction

function! s:esc(c)
  " TODO: anything else?
  return substitute(substitute(a:c, ' ', '<space>', 'g'), '|', '<bar>', 'g')
endfunction

function! after_object#enable(...)
  for c in a:000
    for [p, b] in items({ 'a': 0, 'aa': 1 })
      for [m, v] in items({ 'x': 1, 'o': 0 })
        execute printf(
        \ '%snoremap <silent> %s%s :<c-u>call <sid>after(%s, v:count1, %d, %d)<cr>',
        \  m, p, s:esc(c), string(s:esc(c)), v, b)
      endfor
    endfor
  endfor
endfunction

function! after_object#disable(...)
  for c in a:000
    for p in ['a', 'aa']
      for m in ['x', 'o']
        execute printf('%sunmap <silent> %s%s', m, p, s:esc(c))
      endfor
    endfor
  endfor
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save

