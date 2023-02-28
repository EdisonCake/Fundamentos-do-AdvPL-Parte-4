#INCLUDE 'TOTVS.CH'

User Function AdvPL02()
    //Declaração de Variáveis de recepção de dados.
    local nCotacao  := space(6)
    local nCarteira := space(9)

    // Declaração de variáveis de criação de janela.
    local cTitle := "Conversor de Moeda"
    Private oJanela
    Private oReal, cReal := ""

    // Definindo/Criando a janela de exibição.
    DEFINE MSDIALOG oJanela TITLE cTitle FROM 000, 000 TO 250, 300 PIXEL

    // Solicitando ao usuário a informação de cotação do Dólar.
    @ 010, 015 SAY "Digite a cotação atual do dólar:"   SIZE 120, 07 OF oJanela PIXEL 
    @ 020, 015 MSGET nCotacao                           SIZE 120, 07 OF oJanela PIXEL PICTURE "@E 9.99"

    // Solicitando ao usuário quantos dólares o mesmo tem na carteira
    @ 040, 015 SAY "Digite quantos dólares você tem:"   SIZE 120, 07 OF oJanela PIXEL 
    @ 050, 015 MSGET nCarteira                          SIZE 120, 07 OF oJanela PIXEL

    // Informando ao usuário a quantia em Reais que ele tem.
    @ 067, 015 SAY "R$ "                                SIZE 120, 07 OF oJanela PIXEL
    @ 065, 025 MSGET oReal VAR cReal                    SIZE 110, 07 OF oJanela PIXEL
    oReal:lActive := .F.

    // Criando um botão para realizar a conversão.
    @ 080, 050 BUTTON "CONVERTER"                       SIZE 50, 20 OF oJanela PIXEL;
    ACTION ( Convert(nCotacao, nCarteira) )

    ACTIVATE MSDIALOG oJanela CENTERED
Return 

Static Function Convert(nValor1, nValor2)
    local nConversao := val(nValor1) * val(nValor2)

    cReal := cvaltochar(noround(nConversao, 2))
    oReal:Refresh()

Return
