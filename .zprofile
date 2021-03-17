if uname | grep -q Darwin &> /dev/null; then
  eval $(/opt/homebrew/bin/brew shellenv)
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

if uname | grep -q Linux &> /dev/null; then
  [[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &> /dev/null
fi
