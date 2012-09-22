#   ~/.bashrc:
#       Arquivo de configuração do bash.
#
#       Autor: Elder Marco <eldermarco@gmail.com>
#      Criado: Tue 10 Apr 2007 17:15:36 BRT
#  Modificado: Sáb 22 Set 2012 10:52:28 BRT
#-------------------------------------------------------------------------------

test -f /etc/bashrc    && \
    source /etc/bashrc || \
    source /etc/bash.bashrc


#-------------------------------------------------------------------------------
# opções úteis do interpretador bash
#-------------------------------------------------------------------------------
shopt -s cdspell
shopt -s checkwinsize


#-------------------------------------------------------------------------------
# apelidos para comandos (aliases)
#-------------------------------------------------------------------------------
test -f $HOME/.bash_aliases && source $HOME/.bash_aliases


#-------------------------------------------------------------------------------
# funções
#-------------------------------------------------------------------------------
test -f $HOME/.bash_functions && source $HOME/.bash_functions


#-------------------------------------------------------------------------------
# cores úteis em customizações do prompt
#-------------------------------------------------------------------------------
normal='\e[0m'          # volta tudo ao normal

# cores com o texto normal.
preto='\e[0;30m'        # preto
vermelho='\e[0;31m'     # vermelho
verde='\e[0;32m'        # verde
amarelo='\e[0;33m'      # amarelo
azul='\e[0;34m'         # azul
roxo='\e[0;35m'         # roxo
ciano='\e[0;36m'        # ciano
branco='\e[0;37m'       # branco

# cores com texto em negrito
npreto='\e[1;30m'       # preto
nvermelho='\e[1;31m'    # vermelho
nverde='\e[1;32m'       # verde
namarelo='\e[1;33m'     # amarelo
nazul='\e[1;34m'        # azul
nroxo='\e[1;35m'        # roxo
nciano='\e[1;36m'       # ciano
nbranco='\e[1;37m'      # branco

# cores com texto sublinhado
spreto='\e[4;30m'       # preto
svermelho='\e[4;31m'    # vermelho
sverde='\e[4;32m'       # verde
smarelo='\e[4;33m'      # amarelo
sazul='\e[4;34m'        # azul
sroxoe='\e[4;35m'       # roxo
sciano='\e[4;36m'       # ciano
sbranco='\e[4;37m'      # branco

# cores de fundo
fpreto='\e[40m'         # preto
fvermelho='\e[41m'      # vermelho
fverde='\e[42m'         # verde
fmarelo='\e[43m'        # amarelo
fazul='\e[44m'          # azul
froxo='\e[45m'          # roxo
fciano='\e[46m'         # ciano
fbranco='\e[47m'        # branco


#------------------------------------------------------------------------------
# configurações gerais
#------------------------------------------------------------------------------
test ! -f /etc/bash_completion.d/git -a ! -d /usr/share/bash-completion && \
    export PS1="[\[$namarelo\]\u@\h\[$normal\]: \W ]\\$ " || \
    export PS1="[\[$namarelo\]\u@\h\[$normal\]: \W\$(__git_ps1 \" (%s)\") ]\\$ "

# vim: ft=sh:tw=80:expandtab:tabstop=4:shiftwidth=4
