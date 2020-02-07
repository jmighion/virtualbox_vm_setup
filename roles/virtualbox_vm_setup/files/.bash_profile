
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

source ~/.bashrc
#cd ~/

# if [ -f $(brew --prefix)/etc/bash_completion ]; then
# 	. $(brew --prefix)/etc/bash_completion
# fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
# export PATH="/usr/local/opt/gettext/bin:$PATH"
# export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
# export PATH="/usr/local/opt/python/libexec/bin:$PATH"

if which pyenv 2> /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init 2> /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
