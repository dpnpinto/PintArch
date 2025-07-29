#
# ~/.bashrc
#
# by https://dpnpinto.github.io

# The best Terminal Emu

export PATH=$PATH:~/.local/bin 
export TERM=st

# Get some nie  aliases for colors and stuff

alias ls='ls --color=auto'
alias la='eza -alh --icons --git --group --color-scale --group-directories-first'
alias ll='eza --icons'
alias rm='rm -i'
alias grep='grep --color=always'
alias tree='tree -C'
alias diff='diff --color=always'
alias ip='ip --color=always'
alias dmesg='dmesg --color=always'
alias ..='cd ..'
alias v='vim'
alias code='code-oss'
alias cat='bat'
alias df='dysk'
alias du='ncdu --color dark'

# Get some nice colors in man pages and use most as the pager

export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"

#  Get git info in terminal

function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
}

PS1='\[$(tput setaf 2)\]\u\[$(tput setaf 1)\]@\[$(tput setaf 3)\]\h \[$(tput setaf 6)\]\w\[$(tput sgr0)\] $(parse_git_branch)'
