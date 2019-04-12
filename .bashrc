
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# log every command run by date, under ~/.logs
# do not use on production machines, or machines that will be exposed
#export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color) color_prompt=yes;;
esac

# Avoid logging out by Ctrl-D
set -o ignoreeof

# Default editor for everything, mainly git commit messages
export EDITOR="vim"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Custom aliases
alias vi="vim"
alias psgrep="ps aux | grep -i"

# Custom functions
lsproc()
{
    if [[ "${1}" == "--help" ]]; then
		echo "Runs `ps aux | grep -i \$1` and prints all matching \$PIDs."
		echo "Careful because you *will* kill some process you didn't mean to :P"
        echo "";
        return;
    fi;
    echo "=========== $1 ============";
	ps aux | grep -i $1 | awk '{ print $2 }'
}



