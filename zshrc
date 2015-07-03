export ZSH=$HOME/.zsh
export ZSH_THEME="robbyrussell"
export TERM=xterm-256color
export BUNDLER_EDITOR=vim
export CPPFLAGS=-I/opt/X11/include
export DISABLE_AUTO_UPDATE="true"
export LANG="ru_RU.UTF-8"
export LC_ALL="ru_RU.UTF-8"
export PATH=/usr/local/bin:$PATH
export EDITOR=vim

source $ZSH/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle robbyrussell/oh-my-zsh plugins/ruby
antigen theme robbyrussell
antigen apply

# Customize to your needs...
setopt correct
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

alias l="ls"
alias :q="exit"
alias memtop="ps aux |tail -n+2 |sort -nrk4 |head -$(($(tput lines)-1)) |cut -c 1-$(tput cols)"
alias cputop="ps aux|head -1;ps aux |tail -n+2 |sort -nrk4 |head -$(($(tput lines)-2)) |cut -c 1-$(tput cols)"
alias tmux="tmux -2"
alias vim='reattach-to-user-namespace vim'

# make rails faster:
export RUBY_HEAP_SLOTS_INCREMENT=500000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=70000000
export RUBY_GC_HEAP_FREE_SLOTS=100000
export RUBY_GC_HEAP_INIT_SLOTS=2000000

# docker
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=$HOME/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

# functions
function unpack() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xjf $1 ;;
      *.tar.gz) tar xzf $1 ;;
      *.bz2) bunzip2 $1 ;;
      *.rar) unrar x $1 ;;
      *.gz) gunzip $1 ;;
      *.tar) tar xf $1 ;;
      *.tbz2) tar xjf $1 ;;
      *.tgz) tar xzf $1 ;;
      *.zip) unzip $1 ;;
      *.Z) uncompress $1 ;;
      *.7z) 7z x $1 ;;
      *.tbz) tar xjvf ;;
      *.xz) xz -dk $1 ;;
      *) echo "error '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
} 

function pack() {
  if [ $1 ] ; then
    case $1 in
      tbz) tar cjvf $2.tar.bz2 $2 ;;
      tgz) tar czvf $2.tar.gz $2 ;;
      tar) tar cpvf $2.tar $2 ;;
      bz2) bzip $2 ;;
      gz) gzip -c -9 -n $2 > $2.gz ;;
      zip) zip -r $2.zip $2 ;;
      7z) 7z a $2.7z $2 ;;
      xz) xz -zk $2 ;;      
      *) echo "'$1' cannot be packed via pack()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# ZSH VI MODE
set -o vi
if (( ${+widgets[.history-incremental-pattern-search-backward]} )); then
  bindkey -M viins '^r' history-incremental-pattern-search-backward
  bindkey -M vicmd '^r' history-incremental-pattern-search-backward
else
  bindkey -M viins '^r' history-incremental-search-backward
  bindkey -M vicmd '^r' history-incremental-search-backward
fi
if (( ${+widgets[.history-incremental-pattern-search-forward]} )); then
  bindkey -M viins '^s' history-incremental-pattern-search-forward
  bindkey -M vicmd '^s' history-incremental-pattern-search-forward
else
  bindkey -M viins '^s' history-incremental-search-forward
  bindkey -M vicmd '^s' history-incremental-search-forward
fi
bindkey -M vicmd '^[h' run-help
bindkey -M viins '^[h' run-help
bindkey -M viins '^p'  up-line-or-history
bindkey -M viins '^n'  down-line-or-history
bindkey -M viins '^w'  backward-kill-word
bindkey -M viins '^h'  backward-delete-char
bindkey -M viins '^?'  backward-delete-char

# Show indicator with the RPROMPT='${vim_mode}' in any place you want
vim_ins_mode="%{$fg[cyan]%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$fg[green]%}[CMD]%{$reset_color%}"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

unsetopt auto_name_dirs

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Up-down search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[OA" up-line-or-beginning-search # Up
bindkey "^[OB" down-line-or-beginning-search # Down
