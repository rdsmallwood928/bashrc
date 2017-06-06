#Set up the PATH
export ANDROID_HOME=${HOME}/Development/android
#appending .local to path so that pip --user installs are found
export PATH="${HOME}/.linuxbrew/bin::/usr/local/bin:${HOME}/bin:${PATH}:${HOME}/.local/bin:${ANDROID_HOME}/tools"

export EDITOR="vim"
export VISUAL="${EDITOR}"
export LANG=en_US.UTF-8
# ${HOME}/.bashrc: executed by bash(1) for non-login shells.  If not running
# interactively, don't do anything
[[ -z "${PS1}" ]] && retudefault
# Load the shell dotfiles, and then some:
# # * ~/.path can be used to extend `$PATH`.
# # * ~/.extra can be used for other settings you don't want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,bash_functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

# Source my functions and start setting up my PATH
source "${HOME}/.bash_functions.sh"
source_dir functions
path-prepend "${HOME}/bin"

# Source platform dependent stuff first to help with paths, etc.
source_platform

# Source the rest of the things.
source_dir topics

switch_aws default us-west-2

# init nvm if it exists
if command_exists brew ; then
  export NVM_DIR=~/.nvm
  source "$(brew --prefix nvm)/nvm.sh"
else
  if command_exists "$HOME/.nvm/nvm.sh" ; then
    export NVM_DIR=~/.nvm
    source "$HOME/.nvm/nvm.sh"
  fi
fi

if [ "${PLATFORM}" = "darwin" ] ; then
  export ECLIPSE_HOME="/Applications/Eclipse Java.app/Contents/Eclipse";
else
  export ECLIPSE_HOME=/opt/eclipse
fi

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    SESSION_TYPE=remote/ssh
    # many other tests omitted
else
  case $(ps -o comm= -p $PPID) in
    sshd|*/sshd) SESSION_TYPE=remote/ssh;;
  esac
fi

if [ "$SESSION_TYPE" != "remote/ssh" ]; then
  if [ "$(tmux ls | grep main -c)" -gt "0" ] ; then
    tmux a -t main
  else
    tmux new -s main
  fi
fi

#ALIASES
if [ "${PLATFORM}" = "linux" ] ; then
  alias tmux="TERM=xterm-256color tmux"
fi

alias setJdk7='export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)'
alias setJdk8='export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)'
alias ogc='open -a Google\ Chrome'

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/robert.smallwood/.gvm/bin/gvm-init.sh" ]] && source "/Users/robert.smallwood/.gvm/bin/gvm-init.sh"
