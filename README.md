# dotfiles

My dotfiles for Neovim, fish, tmux, and friends, optimized for web development on
macOS (M1) and Linux (Arch).

## Terminal

On macOS, I use [iTerm2](https://github.com/gnachman/iTerm2), the sanest (though
not the fastest) terminal emulator for the platform. On Linux, I use
[Alacritty](https://github.com/alacritty/alacritty).

- [fish](https://github.com/fish-shell/fish-shell) with a vanilla (but
  evolving!) config

- Neovim on its [master branch](https://github.com/neovim/neovim/commits/master)
  with a functional TypeScript setup for its built-in LSP, written entirely in
  (non-idiomatic) Lua

- [tmux](https://github.com/tmux/tmux) +
  [tmuxp](https://github.com/tmux-python/tmuxp) to manage sessions

- [lazygit](https://github.com/jesseduffield/lazygit), the least painful way to
  use git

- [nnn](https://github.com/jarun/nnn), a leaner vifm alternative

## GUI

- Firefox with [Tridactyl](https://github.com/tridactyl/tridactyl), the most
  reasonable compromise I've found between having to use (and develop) modern
  websites and wanting keyboard control

- VS Code with its solid [Vim plugin](https://github.com/VSCodeVim/Vim) for
  debugging and testing, two tasks that Neovim doesn't (yet) excel at

- [bspwm](https://github.com/baskerville/bspwm) +
  [sxhkd](https://github.com/baskerville/sxhkd) for desktop / window management

- [Rofi](https://github.com/davatorium/rofi) as a launcher and window switcher
