function chpwd() {
    emulate -L zsh
    exa
}

function mkcd() {
  if [[ -d $1 ]]; then
    cd $1
  else
    mkdir -p $1 && cd $1
  fi
}
