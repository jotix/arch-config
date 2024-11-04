#
# ~/.bashrc
#

test -s ~/.alias && . ~/.alias || true

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=helix
export VISUAL=helix
export PATH=$PATH:~/.local/bin:~/.scripts
export GOPATH=~/go

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias exa='exa --icons'
alias la='exa -lha'
alias l=la
alias ll='exa -l'
alias ls=exa
alias lt='exa --tree'

### cd to config folder
alias cdc='cd ~/arch-config'

### alias vim to emacs -nw
alias vim=helix
alias vi=helix
alias hx=helix

function _update_ps1() {
    PS1="$($GOPATH/bin/powerline-go -error $? -jobs $(jobs -p | wc -l))"

    # Uncomment the following line to automatically clear errors after showing
    # them once. This not only clears the error for powerline-go, but also for
    # everything else you run in that shell. Don't enable this if you're not
    # sure this is what you want.

    #set "?"
}

if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

fastfetch
