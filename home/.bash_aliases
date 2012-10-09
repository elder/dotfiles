# ~/.bash_aliases:
#    Arquivo com apelidos (aliases) para comandos utilizando o bash.
#
#      Autor: Elder Marco <eldermarco@gmail.com>
#       Data: Ter 19 Jun 2012 10:00:44 BRT
# Modificado: Seg 08 Out 2012 21:00:00 BRT
#-------------------------------------------------------------------------------

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

alias l='ls -CF'
alias l.='ls -d .*'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias ls='ls --color=auto'

alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'

alias vi='vim'
alias x='atool -x'
alias genpasswd='gpg --gen-random --armor 1'

# vim: ft=sh:expandtab:tabstop=4:shiftwidth=4
