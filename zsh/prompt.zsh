# Shell prompt based on the Solarized Dark theme.
# Heavily inspired by @mathiasbyens prompt: https://github.com/mathiasbynens/dotfiles

autoload colors && colors


if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

prompt_git() {
  local s='';
  local branchName='';
# Check if the current directory is in a Git repository.
  if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") '==' '0' ]; then

    # check if the current directory is in .git before running git checks
    if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" '==' 'false' ]; then

      # Ensure the index is up to date.
      git update-index --really-refresh -q &>/dev/null;

      # Check for uncommitted changes in the index.
      if ! $(git diff --quiet --ignore-submodules --cached); then
        s+='+';
      fi;

      # Check for unstaged changes.
      if ! $(git diff-files --quiet --ignore-submodules --); then
        s+='!';
      fi;

      # Check for untracked files.
      if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        s+='?';
      fi;

      # Check for stashed files.
      if $(git rev-parse --verify refs/stash &>/dev/null); then
        s+='$';
      fi;

    fi;

    # Get the short symbolic ref.
    # If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
    # Otherwise, just give up.
    branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
      git rev-parse --short HEAD 2> /dev/null || \
      echo '(unknown)')";

    [ -n "${s}" ] && s=" [${s}]";

    echo "%F{white}on%f %F{blue}%{\x1b[3m%}${1}${branchName}%{\x1b[0m%}%f%F{white}${s}%";
  else
    return;
  fi;
}

NEWLINE=$'\n';
PROMPT='%F{202}%n%f %F{white}on%f %F{yellow}%m%f %F{white}in%f %F{green}%~%f $(prompt_git) ${NEWLINE}%F{white}%(!.#.$)%f '


# Set the terminal title to the current working directory.

export PROMPT;
