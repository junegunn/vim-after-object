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

vim-after-object does not define any mappings by default.
You have to enable mappings that you want.

```vim
" Define 'after text objects' on VimEnter
autocmd VimEnter * call after_object#enable('=', '-', ':', '#', ' ')
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

When the line contains multiple occurrences of the characters, you can forward
the visual selection by repeating `a=`, or move backward with `aa=`. Both
mappings can be preceded by a count. Refer to the test cases for the details.

To define mappings with different prefixes other than `a` and `aa`, you can
pass an optional list containing forward prefix and backward prefix to
`after_object#enable` call as follows:

```vim
autocmd VimEnter * call after_object#enable([']', '['], '=', ':')
```

