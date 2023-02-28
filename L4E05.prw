#INCLUDE 'TOTVS.CH'

User Function AdvPL05()
    // Declara��o de vari�veis de entrada
    Local nQuil := space(10) // Entrada da quilometragem
    Local nDay  := space(10) // Entrada dos dias utilizados.

    // Cria��o da Janela.
    Local cTitle := "Localiza a�! Ve�culos el�tricos ou n�o..."
    Private oValor, cValor := ""
    Private oQuilometro

    // Definindo as dimens�es da janela de exibi��o.
    DEFINE MSDIALOG oJanela TITLE cTitle FROM 000, 000 TO 209, 263 PIXEL

    // Definindo o posicionamento dos elementos na tela
    @ 007, 012 SAY "Quil�metros"                SIZE 030, 005 OF oJanela PIXEL
    @ 015, 010 MSGET oQuilometro VAR nQuil      SIZE 050, 012 OF oJanela PIXEL
    oQuilometro:cPlaceHold := "KMs"

    @ 032, 012 SAY "Dias alugados"              SIZE 025, 005 OF oJanela PIXEL
    @ 040, 010 MSGET nDay                     SIZE 050, 012 OF oJanela PIXEL


    // Bot�o para execu��o da a��o
    @ 007, 070 BUTTON "Calcular"                SIZE 050, 047 OF oJanela PIXEl;
    ACTION ( Calcula1(nQuil, nDay) )

    // �rea de Exibi��o dos Resultados
    @ 067, 010 MSGET oValor VAR cValor          SIZE 110, 020 OF oJanela PIXEL
    oValor:lActive := .F.

    // Ativando a caixa de di�logo.
    ACTIVATE MSDIALOG oJanela CENTERED

Return 

// Fun��o para o c�lculo do valor do aluguel do ve�culo.
Static Function Calcula1(nValor1, nValor2)
    local nQuilometro := (val(nValor1) * 0,15) // Cada quil�metro custa  R$0.15
    local nDias       := (val(nValor2) * 60) // Cada dia de aluguel custa R$ 60,00
    local nCount      := 0
    local cAux1       := alltrim(nValor1)
    local cAux2       := alltrim(nValor2)
    local nValida1    := 0
    local nValida2    := 0
    local nASC        := 0

    For nCount := 1 to len(cAux1)
        nASC := ASC(SUBSTR(cAux1, nCount))

        if (nASC < 48 .or. nAsc > 57) .and. nAsc != 46
            nValida1++
        endif
    Next

    For nCount := 1 to len(cAux2)
        nASC := ASC(SUBSTR(cAux2, nCount))

        if (nASC < 48 .or. nAsc > 57) .and. nAsc != 46
            nValida2++
        endif
    Next

    If (nValida1 > 0) .or. (nValida2 > 0) .or. (nValida1 > 0 .and. nValida2 > 0)
        MsgStop("Entrada(s) inv�lida(s).", "Aten��o!")
        cValor := " "
        oValor:Refresh()
    else
        // Aqui, a vari�vel de valor recebe a soma das unidades.
        cValor := "Valor a pagar: R$ " + cvaltochar(noround(nQuilometro + nDias, 2))
        oValor:Refresh()
    End if


Return
