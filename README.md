# dotfiles

My dotfiles for Neovim, zsh, tmux, and friends, optimized for web development on
macOS (M1) and Linux (Arch).

## Terminal

I use [iTerm2](https://github.com/gnachman/iTerm2), the sanest (though not the
fastest) terminal emulator on macOS and
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
