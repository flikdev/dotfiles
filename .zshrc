# Zsh configuration

### vars
DOTFILES=$HOME/.dotfiles
EMACSD=$HOME/.emacs.d

### alias
alias re='exec $SHELL -l'
alias ll='ls -alF'
alias l='ls -GlFtrh'
alias c='cp -rp'
alias r='rm -rf'
alias rge='ripgrep -e'

alias e="emacs"
alias mte="emacs -Q -nw -l $EMACSD/init-mini.el" # mini terminal

alias d='docker'
alias dc='docker container'
alias di='docker image'
alias dl='docker logs'
dstop() { docker container rm $(docker container ls -aq); }
drm() { docker image rm $(docker image ls -aq); }
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)='\(.*\)'/\1 \t=> \2/"| sed "s/'\\\'//g"; }

alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'

alias s='screen'
alias sl='screen -ls'
alias sr='screen -r'

alias python='/usr/local/bin/python3'
alias pip='/usr/local/bin/pip3'
alias pip-upgrade-all="pip list -o | tail -n +3 | awk '{ print \$1 }' | xargs pip install -U"

alias awss3cp='aws s3 cp --recursive --exclude "*" --include'
alias awsprofile='export AWS_DEFAULT_PROFILE'


### prompt
function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh $?)
%% "
}

function install_powerline_precmd() {
    for s in "${precmd_functions[@]}"; do
        if [ "$s" = "powerline_precmd" ]; then
            return
        fi
    done
    precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi


### completion
# The next line updates PATH for the Google Cloud SDK.
source ${HOME}'/google-cloud-sdk/path.zsh.inc'

# The next line enables bash completion for gcloud.
source ${HOME}'/google-cloud-sdk/completion.zsh.inc'

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# AWS
complete -C '/usr/local/bin/aws_completer' aws
