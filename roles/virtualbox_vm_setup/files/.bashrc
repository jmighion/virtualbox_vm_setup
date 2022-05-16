# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export PS1="[\u@\H \W]\\$ "
# root PS1
# export PS1="\[\e[31m\][\u@\H \W]\\$ \[\e[m\]"

PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export HISTCONTROL=erasedups

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
#export HISTFILE=~/.bash_eternal_history

# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"
shopt -s histappend

# disable XON/XOFF. This allows bash's C-s to forward-search-history
[[ $- == *i* ]] && stty -ixon

# These shopts from https://zwischenzugs.com/2019/04/03/eight-obscure-bash-options-you-might-want-to-know-about/

# Fix mispellings
shopt -s cdspell

# no need for `cd`
shopt -s autocd

# This option stops the shell session from exiting if there are any jobs running in the background that haven’t finished yet.
shopt -s checkjobs

# Allow use of **. If the pattern is followed by a ‘/’, only directories and subdirectories match.
shopt -s globstar

# globbing similar to regex
shopt -s extglob

# allows you to see how bash interprets the command before it actually gets run
shopt -s histverify


alias ll='ls -lahG'
alias tree='tree -aCp'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias build='time flamel.sh --tag asciidoc clean; time flamel.sh --tag asciidoc adoc; time flamel.sh --tag asciidoc '

function rgit () {
    local dir=`pwd`
    cd ~/git
    #cd ~/Documents/git
    for D in */; do cd $D && echo $D && git fa && cd .. || cd ..; done
    cd $dir
}

# git bash completions. Dependent on rhgit
#source /opt/rh-git29/root/usr/share/bash-completion/completions/git
#source /opt/rh/rh-git218/root/usr/share/bash-completion/completions/git

# Change default dir color from dark to light blue
#LS_COLORS=$LS_COLORS:'di=1;94:' ; export LS_COLORS

#source /Users/james/Documents/git-completion.bash
#export COWPATH="/Users/james/.cowsay"

# export PATH="$(brew --prefix git)/bin:$PATH"


# eval $(thefuck --alias)

function check_pr () {
    echo "Update repo data"
    git fa
    echo
    echo "Current checkout : "
    git s
    echo
    echo "Files that are different from origin/master"
    git d upstream/main --name-only
    echo
    echo "How far behind the current branch is from upstream master"
    git rev-list --count HEAD..upstream/main
}


alias spellr="aspell --mode=asciidoc --add-asciidoc-blocks="====" --add-asciidoc-blocks="----" list | sort | uniq -c | so
rt -rn"
alias spellrxml="aspell list | sort | uniq -c | sort -rn"
function spellr_dir {
  if [ -f /tmp/check-spelling-raw.txt ]
  then
    rm -f /tmp/check-spelling-raw.txt
  fi

  for FILE in $(ls)
  do
    echo ${FILE} | sed 's/\(.*\)\.[a-z]\+/\1/' >> /tmp/check-spelling-raw.txt
  done
  cat /tmp/check-spelling-raw.txt | sort | uniq > /tmp/check-spelling.txt

  for FILE in $(cat /tmp/check-spelling.txt)
  do
    if [ -f ${FILE}.adoc ]
    then
      if [ $(cat ${FILE}.adoc | spellr | wc -l) -gt 0 ]
      then
        echo ${FILE}.adoc
        cat ${FILE}.adoc | spellr
      fi
    fi
    if [ -f ${FILE}.xml ]
    then
      if [ $(cat ${FILE}.xml | spellrxml | wc -l) -gt 0 ]
      then
        echo ${FILE}.xml
        cat ${FILE}.xml | spellrxml
      fi
    fi
  done
}

wttr()
{
    local request="wttr.in/${1-97213}"
    [ "$(tput cols)" -lt 125 ]
    curl -H "Accept-Language: ${LANG%_*}" --compressed "$request"
}
