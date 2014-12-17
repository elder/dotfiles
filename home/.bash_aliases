# ~/.bash_aliases:
#    Arquivo com apelidos (aliases) para comandos utilizando o bash.
#
#      Autor: Elder Marco <eldermarco@gmail.com>
#       Data: Ter 19 Jun 2012 10:00:44 BRT
# Modificado: Qua 17 Dez 2014 18:00:58 BRST
#-------------------------------------------------------------------------------

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias grep='grep --color=auto'

alias l='ls -CF'
alias l.='ls -d .*'
alias ll='ls -l'
alias lr='ls -R'
alias la='ls -A'
alias lla='ls -lA'
alias ls='ls --color=auto'

alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias -- -='cd -'

alias vi='vim'
alias genpasswd='gpg --gen-random --armor 1'

# Aliases para a compactação e descomptação de arquivos em diversos formatos.
# Para fazer a compactação, deve-se passar primeiramente o arquivo compactado
# que deve ser salvo e então os arquivos que irão fazer parte dele.
alias mkzip='atool --add --format .zip'
alias mkrar='atool --add --format .rar'
alias mktargz='atool --add --format .tar.gz'
alias mktarxz='atool --add --format .tar.xz'
alias mktarbz2='atool --add --format .tar.bz2'


# vim: ft=sh:expandtab:tabstop=4:shiftwidth=4
