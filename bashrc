#export PS1='\W \t $ '

alias python=/usr/bin/python3
alias pip=/usr/bin/pip3

export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.gcp/gcp_credential.json"
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
export PATH=".nodebrew/node/v10.15.3/bin:$PATH"
export PATH="~/google-cloud-sdk/bin:$PATH"
export GOPATH=$HOME/go/

alias ll='ls -alF'
alias lt="ls -Gltr"
alias l='ls -GlFtrh'
alias c='cp -rp'
alias r="rm -rf"
alias e="emacs"

alias sl='screen -ls'
alias sr='screen -r'

alias d='docker'
alias dc='docker container'
alias di='docker image'
alias dl='docker logs'
dstop() { docker container rm $(docker container ls -aq); }
drm() { docker image rm $(docker image ls -aq); }
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)='\(.*\)'/\1 \t=> \2/"| sed "s/'\\\'//g"; }

# source <(kubectl completion bash)
