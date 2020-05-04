# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /home/roelof/sites/tubber/resources/assets/js/node_modules/tabtab/.completions/serverless.bash ] && . /home/roelof/sites/tubber/resources/assets/js/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /home/roelof/sites/tubber/resources/assets/js/node_modules/tabtab/.completions/sls.bash ] && . /home/roelof/sites/tubber/resources/assets/js/node_modules/tabtab/.completions/sls.bash

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export GOPATH=/home/roelof/go
export PATH=$PATH:$GOPATH/bin
export GOPATH=$GOPATH:/home/roelof/gocode

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

alias ducks='du -cks * | sort -rn | head'

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /home/roelof/sites/tubber-angular/node_modules/tabtab/.completions/slss.bash ] && . /home/roelof/sites/tubber-angular/node_modules/tabtab/.completions/slss.bash

# ------------- MAINTENANCE ALIASES ----------------
alias update='sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt autoremove -y'

# ----------------- SSH ALIASES --------------------
alias conn='cd /home/roelof/sites/tubber/auth && bash connect.sh'
alias conn-dev='cd /home/roelof/sites/tubber/auth && bash connect-dev.sh'
alias connect='ssh root@roelofjanelsinga.com'

# ----------------- DOCKER ALIASES -----------------
alias npa='./scripts/docker-run.sh php artisan'
alias ndr='./scripts/docker-run.sh'
alias ndra='./scripts/docker-run-all.sh'
alias ndl='./scripts/docker-launch.sh'
alias npadebug='./scripts/docker-run.sh php -dxdebug.profiler_enable=1 artisan'

# ----------------- NPM ALIASES --------------------
alias artisan='php artisan'
alias serve='php artisan serve'
alias unit='./vendor/bin/phpunit'
alias unitwatch='./vendor/bin/phpunit-watcher watch'
alias coverage='php -d pcov.enabled=1 ./vendor/bin/phpunit --coverage-html coverage'
alias cov-watcher='php -d pcov.enabled=1 ./vendor/bin/phpunit-watcher watch --coverage-html coverage'
alias prod='npm run prod'
alias dev='npm run dev'
alias watch='npm run watch'

# ----------------- GIT ALIASES --------------------
alias status='git status'
alias add-all='git add .'
alias stage='git add'
alias unstage='git reset --'
alias amend='git commit --amend'
alias commit='git commit -S -m'
alias gpm='git pull origin master'
alias push='git push origin'
alias pull='git pull origin'
alias switch='git checkout'
alias remove='git branch -d'
alias branches='git branch'
alias tags='git tag'
alias create-tag='git tag -sa'
alias logs='git log --pretty=oneline --abbrev-commit'
alias squash='git rebase -i'

# -------------- DIRECTORY ALIASES -----------------
alias gocode='cd ~/gocode/src/github.com/roelofjan-elsinga'
alias web='cd ~/sites'

# ----------------- FILE ALIASES -------------------
alias editrc='nano ~/.bashrc && source ~/.bashrc'

# ----------------- AUDIO ALIASES ------------------
alias audio-hdmi='pacmd set-card-profile 0 output:hdmi-stereo+input:analog-stereo'
alias audio-default='pacmd set-card-profile 0 output:analog-stereo+input:analog-stereo'
