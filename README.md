# dotfiles

My dotfiles for Neovim, zsh, tmux, and friends, optimized for web development on
macOS (M1) and Linux (Arch).

## Terminal

On macOS I use [iTerm2](https://github.com/gnachman/iTerm2), the sanest (though
not the fastest) terminal emulator for the platform. I use
[Alacritty](https://github.com/alacritty/alacritty) on Linux.

- zsh + a handful of plugins managed with
  [znap](https://github.com/marlonrichert/zsh-snap)

- Neovim on its [master branch](https://github.com/neovim/neovim/commits/master)
  with a functional TypeScript setup for its built-in LSP, written entirely in
  (non-idiomatic) Lua

- [tmux](https://github.com/tmux/tmux) +
  [tmuxp](https://github.com/tmux-python/tmuxp) to manage sessions

- [lazygit](https://github.com/jesseduffield/lazygit), the least painful way to
  use git

- [vifm](https://github.com/vifm/vifm), not the fastest Vim-like file manager,
  but certainly the most Vim-like one

## macOS

- [VS Code Insiders](https://code.visualstudio.com/insiders/) with its solid
  [Vim plugin](https://github.com/VSCodeVim/Vim) for debugging and testing, two
  tasks that Neovim doesn't (yet) excel at

- [Amethyst](https://github.com/ianyh/Amethyst), a decent tiling window manager
  with good M1 support

## Arch Linux

- [bspwm](https://github.com/baskerville/bspwm) +
  [sxhkd](https://github.com/baskerville/sxhkd) for desktop / window management

- [Rofi](https://github.com/davatorium/rofi) as a launcher and window switcher
