"   ~/.vimrc:
"       Arquivo de configuração do vim.
"       Autor: Elder Marco <eldermarco@gmail.com>
"
"      Criado: Qui 24 Jun 2010 14:26:34 BRT
"  Modificado: Dom 23 Set 2012 11:34:05 BRT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Variáveis de uso genérico
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:__autor__      = 'Elder Marco'          " dono da bagaça
let g:__email__      = 'eldermarco@gmail.com' " e-mail do dono
let g:__headerlen__  = 15                     " tamanho do cabeçalho (em linhas)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Configurações gerais
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Habilita o recurso de destaque de sintaxe, detecção automática do tipo de
" arquivo, o uso de plugins e indentação automática de código.
syntax on
filetype on
filetype plugin on
filetype indent on


set nocompatible        " Padrões do Vim e não do Vi
set encoding=utf-8      " Codificação: UTF-8
set laststatus=2        " Sempre mostrar a linha de status
set autochdir           " Entra automaticamente no diretório do arquivo
set expandtab           " Espaço no lugar de tabulações
set smartindent         " Indentação inteligente
set tabstop=4           " Quatro espaços no lugar de uma tabulação
set shiftwidth=4        " Quatro espaços para a indentação
set softtabstop=4       " Tecla backspace apaga uma tabulação
set pastetoggle=<F2>    " Entra no modo de colagem de texto com a tecla F2
set foldmethod=syntax   " Método de dobra baseado em sintaxe
set foldnestmax=1       " Indentação máxima de dobras
set foldlevelstart=0    " Nível de dobra


" Isso faz com que o vim carregue corretamente os plugins relacionados ao
" LaTeX. Faz também com que arquivo .tex vazios sejam tratados como arquivos
" LaTeX desde o começo.
let g:tex_flavor = 'latex'

" Deixa os respectivos arquivos de sintaxe definirem as dobras.
let g:tex_fold_enable    = 1
let g:javaScript_fold    = 1
let g:perl_fold          = 1
let g:php_folding        = 1
let g:r_syntax_folding   = 1
let g:ruby_fold          = 1
let g:sh_fold_enabled    = 1
let g:vimsyn_folding     = 'af'
let g:xml_syntax_folding = 1


" Trata arquivos sh como arquivos do bash. Isso melhora o destaque de sintaxe.
let g:is_bash = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Configurações de aparência
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256                  " Número de cores disponíveis

" solarized
let g:solarized_termcolors = 256
let g:solarized_contrast   = "high"

" molokai
let g:molokai_original = 1

" zenburn
let g:zenburn_high_Contrast = 1

" Esquema de cores
"set background=dark
colorscheme molokai


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        Configurações de plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" pathogen
call pathogen#infect ()


" UltiSnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'snippets']
let g:UltiSnipsEditSplit = 'horizontal'


" SuperTab
let g:SuperTabDefaultCompletionType = "context"


" NERDTree
map <c-t> :NERDTreeToggle <cr>
let NERDTreeIgnore = ['\.pyc', '\.pyo']
let NERDTreeChristmasTree = 1


" Powerline
let g:Powerline_symbols = 'fancy'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Mapeamentos
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Mais conforto ao navegar entre linhas muitos grandes no vim
map   <up>   gk
map   <down> gj
imap  <up>   <c-o>gk
imap  <down> <c-o>gj


" No modo normal, permite a navegação entre as abas utilizando a combinação
" ctrl + setas direcionais.
nnoremap <c-left>  :tabprev<cr>
nnoremap <c-right> :tabnext<cr>


" Permite abrir/fechar uma dobra com a tecla espaço.
nnoremap silent! <space> @=((foldclosed(line(".")) < 0 ) ? 'zc' : 'zo')<cr>


" No modo normal, permite subir ou descer a linha atual em um dado arquivo
" utilizando, repectivamente, a combinação de teclas ctrl + up ou ctrl + down.
" Esta dica foi retirada do site vimcasts.org: http://goo.gl/S2sxK
nmap <c-up>   ddkP
nmap <c-down> ddp

" O mesmo que acima, mas para múltiplas linhas e no modo visual.
vmap <c-up>   xkP`[V`]
vmap <c-down> xp`[V`]


" Habilita o ctrl + c e ctrl + v no modo visual
vmap <c-c> "+y
vmap <c-v> "+gP


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Funções
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Obs: Estas funções são utilizadas ao longo deste arquivo em autocomandos ou
"       outras rotinas de interesse.

" GetLinMax: Retorna "linmax" se o arquivo tem mais do que "linmax" linhas. Caso
"       contrário, retorna o número da última linha do arquivo. Esta função é
"       útil quando se quer limitar a ação de um autocomando até uma dada linha,
"       mas não se sabe se o arquivo chega até essa linha.
function GetLinMax (linmax)
    if line ("$") > a:linmax
        return a:linmax
    else
        return line ("$")
     endif
endfunction

" UpdateLastModification: atualiza a data de modificação de um arquivo que
"       contenha uma linha com a string "Modificado:". Somente o início do
"       arquivo -- linhas 1 a __headerlen__ -- é verificado. A atualização só
"       será feita se o arquivo tiver sido alterado. Caso contrário, esta
"       função não terá qualquer efeito. 
function UpdateLastModification ()
    if &modified == 1
        let l = GetLinMax (g:__headerlen__)

        silent!
        \ execute "1," . l . "g/Modificado:/s/Modificado:.*/Modificado: " .
        \   strftime ("%c")
    endif
endfunction

" ReplaceTag: Substitui o marcador definido por "tag" pela string definida por
"       "rep". Esta substituição somente irá ocorrer se o arquivo tiver sido
"       modificado após a sua abertura. As substituições serão feitas desde
"       a primeira linha até a linha definida por "linmax". Se a última linha
"       do arquivo for menor que linmax, a substituição irá valer para o
"       arquivo inteiro. 
function ReplaceTag (tag, rep, linmax)
    if &modified == 1
        let l = GetLinMax (a:linmax)

        silent!
        \ execute "1," . l . "g/" . a:tag . "/s/" . a:tag . "/" . a:rep
    endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Autocomandos
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has ("autocmd")
    " Ignora os autocomandos do grupo fedora, presente no arquivo /etc/vimrc
    " na distribuição Linux Fedora. Além disso, os autocomandos úteis deste
    " grupo estão presentes abaixo.
    augroup! fedora

    augroup modelos 
        autocmd!

        " Os modelos estão definidos em ~/.vim/skel. É necessário criar um
        " novo neste diretório para que o Vim passe a utilizá-lo. Caso o
        " modelo não exista, o vim irá criar um arquivo vazio, como costuma
        " fazer.
        autocmd BufNewFile * silent!
            \ 0r ~/.vim/skel/skel.%:e|norm G

        " Substitui variáveis especiais nos modelos carregados pelo valores
        " configurados neste arquivo de configuração. Esta substituição é feita
        " quando o arquivo é carregado. A data de modificação é zerada apenas
        " por ajustes estéticos, nada mais. A posição do cursor é salva e
        " restaurada após estas modificações.
        autocmd BufNewFile *
            \ ks|call ReplaceTag ("%AUTOR%", __autor__, __headerlen__)
            \|   call ReplaceTag ("%EMAIL%", __email__, __headerlen__)
            \|   %s/Modificado:.*$/Modificado: /ge |'s

        " Faz o mesmo que a opção acima, mas com a data de criação do arquivo.
        " A substituição é feita quando o arquivo é salvo para que a data de
        " criação do mesmo seja fiel a realidade, se é que isso faz alguma
        " diferença.
        autocmd BufWritePre,FileWritePre *
            \ ks|call ReplaceTag ("%DATA%", strftime ("%c"), __headerlen__)|'s
    augroup end

    " Encerra o vim se sobrar somente o NERDTree aberto.
    autocmd BufEnter *
        \ if winnr ("$") == 1 && exists ("b:NERDTreeType") &&
        \   b:NERDTreeType == "primary"
        \|     quit
        \| endif

    " Atualiza a data de modificação do arquivo. A posição do cursor é salva
    " e restaurada após a atualização.
    autocmd BufWritePre,FileWritePre *
        \ ks| call UpdateLastModification () |'s

    " Restaura a posição do cursor para a última posição conhecida. Útil
    " quando se fecha o arquivo e o abre novamente, querendo voltar para o
    " mesmo lugar onde havia parado.
    autocmd BufReadPost *
        \ if line ("'\"") > 0  && line ("'\"") <= line ("$")
        \|     execute "normal! g`\""
        \| endif

    " Não escreve arquivos de troca em diretórios utilizados na montagem de
    " dispositivos. Retirado das configurações do vim no fedora em /etc/vimrc.
    autocmd BufNewFile,BufReadPre /media/*,/mnt/*
        \ set directory=~/tmp,/var/tmp,/tmp

    " Todos os arquivos texto devem ter no máximo 80 colunas.
    autocmd FileType text
        \ setlocal textwidth=80

    " Utilizar tabulações e não espaços em um Makefile
    autocmd BufEnter Makefile
        \ set noexpandtab

    " Destaca os espaços em branco inúteis no final da linha. Esta
    " configuração foi uma dica do Aurélio: http://goo.gl/zqq6s
    autocmd BufNewFile,BufRead *
        \ syn match brancomala '\s\+$'
        \| hi brancomala ctermbg=red
endif

"vim: ft=vim:expandtab:tabstop=4:shiftwidth=4
