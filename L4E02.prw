#INCLUDE 'TOTVS.CH'

User Function AdvPL02()
    //Declara��o de Vari�veis de recep��o de dados.
    local nCotacao  := space(6)
    local nCarteira := space(9)

    // Declara��o de vari�veis de cria��o de janela.
    local cTitle := "Conversor de Moeda"
    Private oJanela
    Private oReal, cReal := ""

    // Definindo/Criando a janela de exibi��o.
    DEFINE MSDIALOG oJanela TITLE cTitle FROM 000, 000 TO 250, 300 PIXEL

    // Solicitando ao usu�rio a informa��o de cota��o do D�lar.
    @ 010, 015 SAY "Digite a cota��o atual do d�lar:"   SIZE 120, 07 OF oJanela PIXEL 
    @ 020, 015 MSGET nCotacao                           SIZE 120, 07 OF oJanela PIXEL PICTURE "@E 9.99"

    // Solicitando ao usu�rio quantos d�lares o mesmo tem na carteira
    @ 040, 015 SAY "Digite quantos d�lares voc� tem:"   SIZE 120, 07 OF oJanela PIXEL 
    @ 050, 015 MSGET nCarteira                          SIZE 120, 07 OF oJanela PIXEL

    // Informando ao usu�rio a quantia em Reais que ele tem.
    @ 067, 015 SAY "R$ "                                SIZE 120, 07 OF oJanela PIXEL
    @ 065, 025 MSGET oReal VAR cReal                    SIZE 110, 07 OF oJanela PIXEL
    oReal:lActive := .F.

    // Criando um bot�o para realizar a convers�o.
    @ 080, 050 BUTTON "CONVERTER"                       SIZE 50, 20 OF oJanela PIXEL;
    ACTION ( Convert(nCotacao, nCarteira) )

    ACTIVATE MSDIALOG oJanela CENTERED
Return 

Static Function Convert(nValor1, nValor2)
    local nConversao := val(nValor1) * val(nValor2)

    cReal := cvaltochar(noround(nConversao, 2))
    oReal:Refresh()

Return
