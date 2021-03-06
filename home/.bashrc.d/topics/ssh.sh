# Keep my .ssh stuff private.
chmod 700 "${HOMESICK}/bashrc/home/.ssh"

case ${PLATFORM} in
  darwin)
    # Setup ssh stuff.
    if [[ -z ${SSH_AUTH_SOCK} ]]; then
      ssh-add -K
    else
      echo "SSH agent using key in OSX keychain."
    fi
    ;;
  *)
    # Setup ssh agent.
    if [[ -z ${SSH_AUTH_SOCK} ]]; then
      export SSH_ENV=${HOME}/.ssh/env-${HOSTNAME}
      export SSH_CONFIG=${HOME}/.ssh/config
      ssh-login
    else
      echo "SSH agent already active from another session or host."
    fi
    ;;
esac
