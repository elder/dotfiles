# ~/.bash_profile:
#       Arquivo de configuração do bash, carregado durante o login.
#
#      Autor: Elder Marco <eldermarco@gmail.com>
#       Data: Sáb 01 Set 2012 16:05:11 BRT
# Modificado: Sáb 22 Set 2012 10:51:16 BRT
#-------------------------------------------------------------------------------

test -e  "$HOME/.bashrc" && source "$HOME/.bashrc"


#-------------------------------------------------------------------------------
# configurações gerais
#-------------------------------------------------------------------------------
export EDITOR='vim'
export MANPAGER='most -s'
export GREP_OPTIONS='--color=auto'
export PATH=$PATH:$HOME/bin
export CDPATH=$CDPATH:$HOME:$HOME/Vídeos:$HOME/Músicas
test -e /usr/share/terminfo/r/rxvt-256color && \
    export TERM='rxvt-256color'             || \
    export TERM='rxvt'
eval "$(dircolors -b)"


#------------------------------------------------------------------------------
# configurações relativas ao git
#------------------------------------------------------------------------------
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

# vim: ft=sh:tw=80:expandtab:tabstop=4:shiftwidth=4
