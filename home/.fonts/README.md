## Fontes

As fontes presentes neste diretório são utilizadas nas configurações do GVim,
Conky, etc. Algumas delas não correspondem a uma cópia fiel das fontes
fornecidas pelos seus respectivos autores, uma vez que se utilizou o
`fontpatcher` (disponibilizado junto com o plugin Powerline, do Vim) para
realizar pequenas correções nas mesmas e poder utilizá-las no plugin _Powerline_
do Vim. Para ser mais exato, a definição

    let g:Powerline_symbols = 'fancy'

no arquivo `~/.vimrc` leva a necessidade de se aplicar essas correções na fonte
utilizada tanto em modo gráfico quanto pelo terminal, já que sem elas, a barra de
status poderá exibir alguns símbolos estranhos no lugar dos símbolos corretos.

Após colocá-las no diretório correspondente, é necessário rodar o comando
`fc-cache`:

    $ fc-cache -vf
