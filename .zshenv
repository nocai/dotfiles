export EDITOR="nvim"
export LC_ALL="en_US.UTF-8"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# pip
export PATH="$HOME/.local/bin:$PATH"

# homebrew
export PATH="/usr/local/sbin:$PATH"
alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin brew"

# ruby (homebrew)
export PATH="/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

# rust
export PATH="$HOME/.cargo/bin:$PATH"
