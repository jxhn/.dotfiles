# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls='gls -F --color'
  alias l='gls -lAh --color'
  alias ll='gls -l --color'
  alias la='gls -A --color'
fi

# When using sudo, use alias expansion (otherwise sudo ignores your aliases)
alias sudo='sudo '

# Stops me getting distracted sometimes
alias hosts='sudo vim /etc/hosts'
