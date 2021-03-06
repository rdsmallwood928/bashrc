gcd() {
  if command -v git &> /dev/null; then
      local STATUS=$(git status 2>/dev/null)
    if [[ -z ${STATUS} ]]; then
      return;
    fi
    local dir="./$( command git rev-parse --show-cdup )/${1}"
    cd "${dir}"
  fi
}

_git_cd() {
  if command -v git &> /dev/null; then
    STATUS=$(git status 2>/dev/null)
    if [[ -z ${STATUS} ]]; then
      return
    fi
    TARGET="./$( command git rev-parse --show-cdup )"
    if [[ -d $TARGET ]]; then
      TARGET="$TARGET/"
    fi
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}$2"
    opts=$(cd "$TARGET"; compgen -d -o dirnames -S / -X '@(*/.git|*/.git/|.git|.git/)' "$2")
    if [[ ${cur} == * ]]; then
      COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
      return 0
    fi
  fi
}

complete -o nospace -F _git_cd gcd
