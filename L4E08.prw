#INCLUDE 'TOTVS.CH'

User Function AdvPl08()
    local nPeso   := space(30)
    local nAltura := space(30)

    local cTitle := "Cálculo de IMC"
    Private oJanela, oPeso, oAtltura

    DEFINE MSDIALOG oJanela TITLE cTitle FROM 000, 000 TO 250, 300 PIXEL

    @ 010, 015 SAY "Digite seu peso"             SIZE 120, 07 OF oJanela PIXEL
    @ 020, 015 MSGET oPeso VAR nPeso             SIZE 120, 07 OF oJanela PIXEL
    oPeso:cPlaceHold := "Digite o seu peso"

    @ 040, 015 SAY "Digite sua altura"           SIZE 120, 07 OF oJanela PIXEL
    @ 050, 015 msget oAltura VAR nAltura         SIZE 120, 07 OF oJanela PIXEL
    oAltura:cPlaceHold := "Digite sua altura"

    @ 070, 015 BUTTON "Cálculo IMC"              SIZE 120, 15 OF oJanela PIXEL;
    ACTION ( IMC(nPeso, nAltura) )

    @ 090, 035 BUTTON "Finalizar"                SIZE 080, 15 OF oJanela PIXEL;
    ACTION ( oJanela:End() )

    ACTIVATE MSDIALOG oJanela CENTERED

Return 

Static Function IMC(nPeso, nAltura)
    local nIMC     := val(nPeso) / (val(nAltura) ^ 2)
    local nCount   := 0
    local nValida1 := 0
    local nValida2 := 0
    local nASC     := 0
    local cAux1    := alltrim(nPeso)
    local cAux2    := alltrim(nAltura)
    
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
        MsgStop("Entrada(s) inválida(s).", "Atenção!")
    elseif cAux1 == "" .or. cAux2 == "" .or. (cAux1 == "" .and. cAux2 == "")
        MsgStop("Há informações em branco!", "Atenção")
    Else
        Do CASE
            Case nIMC < 18.5 
                FwAlertInfo("Nível de IMC: " + cvaltochar(round(nIMC, 1)) + " - Magreza. Obesidade (Grau): 0")
            Case nIMC >= 18.5 .and. nIMC < 24.9 
                FwAlertInfo("Nível de IMC: " + cvaltochar(round(nIMC, 1)) + " - Normal. Obesidade (Grau): 0")
            Case nIMC >= 25 .and. nIMC <= 29.9 
                FwAlertError("Nível de IMC: " + cvaltochar(round(nIMC, 1)) + " - Sobrepeso. Obesidade (Grau): I")
            Case nIMC >= 30 .and. nIMC <= 39.9
                FwAlertError("Nível de IMC: " + cvaltochar(round(nIMC, 1)) + " - Obesidade. Obesidade (Grau): II")
            Case nIMC >= 40
                FwAlertError("Nível de IMC: " + cvaltochar(round(nIMC, 1)) + " - Obesidade Grave. Obesidade (Grau): III")
        End Case
    Endif

Return
