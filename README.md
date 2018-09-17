vim-after-object ![travis-ci](https://travis-ci.org/junegunn/vim-after-object.svg?branch=master)
================

Defines text objects to target text *after* the designated characters.

Installation
------------

Using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'junegunn/vim-after-object'
```

Setting up
----------

vim-after-object does not define any mappings by default. You have to enable
mappings you want.

```vim
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')
```

For each character in the argument list, a pair of mappings is defined; the
default mapping with `a`-prefix (mnemonic for *after*) and the one with
`aa`-prefix for backward search. The latter is only useful when the character
appears more than once in the line.

To use different prefixes, pass an optional list to `after_object#enable`:

```vim
" ]= and [= instead of a= and aa=
autocmd VimEnter * call after_object#enable([']', '['], '=', ':')
```

Usage
-----

```ruby
# va=  visual after =
# ca=  change after =
# da=  delete after =
# ya=  yank after =
apple = 'juice'
```

When the line contains multiple occurrences of the character, you can move the
visual selection forward by repeating `a=`, or backward with `aa=`. Both
mappings can be preceded by a count. Refer to the test cases for the details.
