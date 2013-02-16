# ~/.bash_functions:
#     Arquivo com funções para o bash.
#
#      Autor: Elder Marco <eldermarco@gmail.com>
#       Data: Seg 03 Set 2012 22:29:43 BRT
# Modificado: Sáb 16 Fev 2013 16:10:04 BRST
#-------------------------------------------------------------------------------


# Cria o diretório especificado pelo primeiro argumento e entra nele.
function mkcd () { mkdir -p "$1" && cd "$1"; }


# Gera aarquivos .gitignore bem úteis para os mais diferentes ambientes,
# IDES, linguagens de programação, etc.
function gi ()
{
    local API='http://gitignore.io/api'

    if [ $# -ne 1 ]; then
        echo 2>&1 "Uso: $FUNCNAME [SO,][IDE,][linguagem de programação]"
        return 1
    fi

    curl $API/$@
    return $?
}


# Faz o cálculo de uma expressão matemática utilizando o bc. É possível definir
# a precisão (número de casas decimais) utilizada na saída. Por default, se
# utiliza 2 casas decimais depois da vírgula. Esta função foi baseada em um
# script postado na lista shell-script no Yahoo!. Trata-se de uma calculadora
# simples e bastante útil para o terminal do Linux.
function calc () 
{
    local PRECISION=2

    if [ $# -lt 1 ]; then
        echo 1>&2 "Uso: $FUNCNAME [-p|--precision NUM] EXPRESSÃO"
        return 1
    fi

    if [ "$1" = "-p" -o "$1" == "--precision" ]; then
        PRECISION=$2
        shift 2
    fi

    echo "scale=$PRECISION; $@" | bc -l
}


# Um simples truque para ter os diretórios com nome %{name} (literalmente)
# excluídos após a execução do rpmbuild. Essa função substitui uma chamada
# direta do rpmbuild. O problema citado surge quando você se tenta definir
# um diretório personalizado para cada pacote no arquivo ~/.rpmmacros.
function rpmbuild ()
{
    local -a RPMBUILD_ARGS=("$@")
    local -r RPMBUILD_PROG=$(type -P rpmbuild)
    local -r TOPDIR=$(rpm --eval "%_topdir")
    local -r RPMDIR=$(rpm --eval "%_rpmdir")
    local -r SRCRPMDIR=$(rpm --eval "%_srcrpmdir")
    local PACKAGE_NAME ARG RETVAL

    RETVAL=0
    PACKAGE_NAME=

    for ARG in "${RPMBUILD_ARGS[@]}"; do
        if echo "$ARG" | grep -iq '.spec$'; then
            PACKAGE_NAME="${ARG%.spec}"
            break
        fi
    done

    if [ -n "$PACKAGE_NAME" ]; then
        mkdir -p $(echo "$RPMDIR" | \
                        sed "s/%{name}/$PACKAGE_NAME/g")
        mkdir -p $(echo "$SRCRPMDIR" | \
                        sed "s/%{name}/$PACKAGE_NAME/g")
    else
        echo 1>&2 "nenhum arquivo .spec foi passado como argumento"
        exit 1
    fi

    "$RPMBUILD_PROG" "${RPMBUILD_ARGS[@]}" || RETVAL=$?
    find "$TOPDIR" -type d -name "%{name}" | xargs rm -rf

    return $RETVAL
}


# Permite assistir videos do YouTube diretamente pelo terminal, utilizando
# o mplayer e o youtube-dl.
function yt ()
{
    local -r YOUTUBE="http://www.youtube.com/watch?v="
    local -r COOKIE="/tmp/cookie.txt"
    local QUALITY=35
    local RETVAL=0
    local URL ID VIDEOURL

    if [ $# -lt 1 ]; then
        echo 1>&2 "Uso: $FUNCNAME [-q|--quality NUM] <URL do YouTube>"
        return 1
    fi

    # Para uma lista de valores que podem ser passados, acesse:
    #  http://en.wikipedia.org/wiki/YouTube#Quality_and_codecs
    if [ $# -eq 1 ]; then
        URL="$1"
    elif [ "$1" = "-q" -o "$1" = "--quality" ]; then
        QUALITY="$2"; URL="$3"
    else
        echo 1>&2 "$FUNCNAME: opção '$1' desconhecida."
        return 1
    fi

    # Extrai o ID do video para ser utizado em um URL padronizado.
    if echo "$URL" | egrep -iq "^https?://youtu.be"; then
        ID=$(echo "$URL" | egrep -o '[^/]+$')
    elif echo "$URL" | egrep -iq '^https?://(www\.)?youtube.com'; then
        ID=$(echo "$URL" | sed -r 's/.*v=([^&]+).*/\1/g')
    else
        echo 1>&2 "yt: "$URL" não parece ser uma URL do YouTube."
        return 1
    fi
    
    VIDEOURL="$YOUTUBE$ID"; echo "$VIDEOURL"
    mplayer -quiet -cache 4000 -cache-min 30 -cookies -cookies-file "$COOKIE" \
        "$(youtube-dl -gf "$QUALITY" --cookies "$COOKIE" "$VIDEOURL")" ||     \
         RETVAL=$?


    rm -f "$COOKIE"
    return $RETVAL
}


# Converte um arquivo RMVB para AVI com o mencoder
function rmvbavi ()
{

    if [ $# -ne 2 ]; then
        echo 1>&2 "Uso: $FUNCNAME: ARQUIVORMVB"
        exit 1
    fi

    mencoder "$1" -oac mp3lame -lameopts preset=128             \
        cbr:br=64:vol=8 -ovc xvid -xvidencopts fixed_quant=4   \
        -o "$(basename "$1" .rmvb).avi"
}


# Converte um arquivo em MKV para AVI com o mencoder.
function mkvavi ()
{
    if [ $# -ne 2 ]; then
        echo 1>&2 "Uso: $FUNCNAME ARQUIVOMKV"
        exit 1
    fi

    mencoder "$1" -oac mp3lame -lameopts preset=128        \
        -lameopts cbr:br=64:vol=8 -ovc xvid -xvidencopts  \
        fixed_quant=4 -o "$(basename "$1" .mkv).avi"
}

# vim: ft=sh:tw=80:expandtab:tabstop=4:shiftwidth=4
