# starship
eval "$(starship init zsh)"

# fnm
export PATH="/Users/dispy/Library/Application Support/fnm:$PATH"

eval "$(fnm env --use-on-cd)"

# rbenv
eval "$(rbenv init -)"

# 1password
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# fzf git
source ~/fzf-git.sh/fzf-git.sh

# zsh_profile
source ~/.zsh_profile
