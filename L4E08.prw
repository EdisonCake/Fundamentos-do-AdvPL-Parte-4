#INCLUDE 'TOTVS.CH'

User Function AdvPl08()
    // Declara��o de vari�veis.
    local nPeso   := space(30)
    local nAltura := space(30)

    // Informa��es para a defini��o da janela
    local cTitle := "C�lculo de IMC"
    Private oJanela, oPeso, oAtltura

    // Cria��o da janela
    DEFINE MSDIALOG oJanela TITLE cTitle FROM 000, 000 TO 250, 300 PIXEL

    // Label e get do peso e altura do usu�rio para o c�lculo.
    @ 010, 015 SAY "Digite seu peso"             SIZE 120, 07 OF oJanela PIXEL
    @ 020, 015 MSGET oPeso VAR nPeso             SIZE 120, 07 OF oJanela PIXEL
    oPeso:cPlaceHold := "Digite o seu peso"

    @ 040, 015 SAY "Digite sua altura"           SIZE 120, 07 OF oJanela PIXEL
    @ 050, 015 msget oAltura VAR nAltura         SIZE 120, 07 OF oJanela PIXEL
    oAltura:cPlaceHold := "Digite sua altura"

    // Bot�o para chamar a fun��o de c�lculo do IMC passando os par�metros do usu�rio
    @ 070, 015 BUTTON "C�lculo IMC"              SIZE 120, 15 OF oJanela PIXEL;
    ACTION ( IMC(nPeso, nAltura) )

    // Bot�o extra para encerramento do programa apenas.
    @ 090, 035 BUTTON "Finalizar"                SIZE 080, 15 OF oJanela PIXEL;
    ACTION ( oJanela:End() )

    ACTIVATE MSDIALOG oJanela CENTERED

Return 

// Fun��o de c�lculo do IMC.
Static Function IMC(nPeso, nAltura)
    local nIMC     := val(nPeso) / (val(nAltura) ^ 2)
    local nCount   := 0
    local nValida1 := 0
    local nValida2 := 0
    local nASC     := 0
    local cAux1    := alltrim(nPeso)
    local cAux2    := alltrim(nAltura)
    
    // Contador para fazer a valida��o de entrada do usu�rio.
    // Se qualquer coisa que n�o seja um n�mero ou um "." for digitado, ser� recusado.
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

    // Se a valida��o for positiva, o usu�rio recebe um aviso, sen�o, � informado o IMC com base em alguns par�metros.
    If (nValida1 > 0) .or. (nValida2 > 0) .or. (nValida1 > 0 .and. nValida2 > 0)
        MsgStop("Entrada(s) inv�lida(s).", "Aten��o!")
    elseif cAux1 == "" .or. cAux2 == "" .or. (cAux1 == "" .and. cAux2 == "")
        MsgStop("H� informa��es em branco!", "Aten��o")
    Else
        Do CASE

            // Com base no resultado do IMC do usu�rio, � exibida uma mensagem de acordo.
            Case nIMC < 18.5 
                FwAlertInfo("N�vel de IMC: " + cvaltochar(round(nIMC, 1)) + " - Magreza. Obesidade (Grau): 0")
            Case nIMC >= 18.5 .and. nIMC < 24.9 
                FwAlertInfo("N�vel de IMC: " + cvaltochar(round(nIMC, 1)) + " - Normal. Obesidade (Grau): 0")
            Case nIMC >= 25 .and. nIMC <= 29.9 
                FwAlertError("N�vel de IMC: " + cvaltochar(round(nIMC, 1)) + " - Sobrepeso. Obesidade (Grau): I")
            Case nIMC >= 30 .and. nIMC <= 39.9
                FwAlertError("N�vel de IMC: " + cvaltochar(round(nIMC, 1)) + " - Obesidade. Obesidade (Grau): II")
            Case nIMC >= 40
                FwAlertError("N�vel de IMC: " + cvaltochar(round(nIMC, 1)) + " - Obesidade Grave. Obesidade (Grau): III")
        End Case
    Endif

Return
