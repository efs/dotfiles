export EDITOR="vim"
export PAGER="vimpager"
export BROWSER="chromium"
export PATH="${PATH}:${HOME}/bin"
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
export CLASSPATH=.:/usr/share/java/junit.jar

# Vi mode
bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

autoload -U compinit
compinit

autoload colors zsh/terminfo
#if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
#fi
# Show a fortune when starting a new session.
echo
/usr/bin/fortune -a
echo

# The prompt #{{{

# Define some colors.
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval $color='%{$fg[${(L)color}]%}'
done

NO_COLOUR="%{$terminfo[sgr0]%}"


setprompt() {
    setopt prompt_subst

    # Set color of the hostname according to the hostname.
    if [[ `hostname` = "lovelace" ]]; then
        PR_HOST='${MAGENTA}%m${NO_COLOUR}'
    elif [[ `hostname` = "ballmer" ]]; then
        PR_HOST='${YELLOW}%m${NO_COLOUR}'
    else PR_HOST='${CYAN}%m${NO_COLOUR}'
    fi

    # Color the username red if the user is privileged
    PR_USER='%(!.${RED}.${GREEN})%n${NO_COLOUR}'

    # Color the prompt green if the return value of the last command was 0,
    # and red otherwise.
    PR_RETURN='%(0?.${GREEN}.${RED})%#${NO_COLOUR}'

    PR_PATH='%~'

PROMPT="${PR_USER}@${PR_HOST}:${PR_PATH}
${PR_RETURN} "
RPROMPT="%T"

}
setprompt
#}}}

# Aliases #{{{

alias df='df -h'
alias du='du -h'
alias ls='ls --color=auto'
alias l='ls'
alias ll='ls -lh'
alias cd..='cd ..'
alias pi='powerpill -S'
alias pu='powerpill -Syu'
alias y='yaourt'
alias yi='yaourt -S'
alias yu='yaourt -Syu --aur'
alias ncmpc='ncmpc --colors'
alias wifi='wicd-curses'
alias wimi="curl -s http://whatismyip.org; echo"
alias mtr="mtr -t"
alias vp="vimpager"
alias wpa="sudo wpa_supplicant -B -Dwext -iwlan0 -c /etc/wpa_supplicant.conf"
alias pdf="xpdf -fullscreen"

# GIt stuff
alias gp='git push'
alias gb='git branch'
alias gc='git checkout'
alias gm='git commit -m'
alias gma='git commit -am'
alias gd='git diff'
alias gs='git status'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gl='git log'
alias ga='git add'
alias gcl='git clone'
#}}}

# vim:foldmethod=marker:foldlevel=0
