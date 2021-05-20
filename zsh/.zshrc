alias rspec="bundle exec rspec"
alias rake="bundle exec rake"

alias k=kubectl

alias gcane="git commit --amend --no-edit"

if [ -f "/Applications/Emacs.app/Contents/MacOS/Emacs" ]; then
  export EMACS="/Applications/Emacs.app/Contents/MacOS/Emacs"
  alias emacs="$EMACS"
fi

if [ -f "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient" ]; then
  alias emacsclient="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"
fi

replace_recursively() {
  local search_term replace_term
  search_term="$1"
  replace_term="$2"
  shift
  shift
  rg "$search_term" "$@" -l | xargs -n1 -I{} sed -i '' "s/$search_term/$replace_term/g" {}
}

ZSH_THEME="agnoster"

BUNDLED_COMMANDS=(rubocop)
plugins=(git emacs docker)
gcrebase() {
  local current_branch=$(git rev-parse --abbrev-ref HEAD)
  git checkout "$1" && git pull && git checkout $current_branch && git rebase "$1"
}
# export MANPATH="/usr/local/man:$MANPATH"
source $ZSH/oh-my-zsh.sh

restart_nginx () {
  local path_to_config
  path_to_config="$1"
  sudo kill $(ps aux | grep "nginx: master process" | grep root | awk '{print $2}')
  set -x
  sudo nginx -tc "$path_to_config"
  sudo nginx -c "$path_to_config"
}

if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
    PS1='$ '
fi


