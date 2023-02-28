#INCLUDE 'TOTVS.CH'

User Function AdvPl10()
    local nHora     := Space(3)
    local nValHora  := Space(7)
    
    local cTitle    := "Folha de Pagamento"
    Private oJanela, oGrp1, oGrp2
    Private oSalBru, cSalBru := ""
    Private oSalLiq, cSalLiq := ""
    Private oIR, cIR         := ""
    Private oINSS, cINSS     := ""
    Private oFGTS, cFGTS     := ""
    Private oTot, cTot       := ""

    Private nJanLarg := 300
    Private nJanAlt  := 300

    DEFINE MSDIALOG oJanela TITLE cTitle FROM 000, 000 TO nJanAlt, nJanLarg PIXEL

    // Definindo o grupo de preenchimento.
    @ 003, 003 GROUP oGrp1 TO (nJanAlt/6)-1, (nJanLarg/2)-3 PROMPT "Informa��es: " OF oJanela PIXEL

    @ 015, 015 SAY "Horas Trabalhadas: "        SIZE (nJanLarg / 4) - 3, 007 OF oJanela PIXEL
    @ 022, 015 MSGET nHora                      SIZE (nJanLarg / 5) - 3, 007 OF oJanela PIXEL

    @ 015, (nJanLArg / 4) + 3 SAY "Valor da Hora:"  SIZE (nJanLarg / 4) - 3, 007 OF oJanela PIXEL
    @ 022, (nJanLarg / 4) + 3 MSGET nValHora        SIZE (nJanLarg / 5) - 3, 007 OF oJanela PIXEL

    // Bot�o para chamar a fun��o de c�lculo da folha de pagamento
    @ 035, 035 BUTTON "Calcular"                    SIZE 080, 10 OF oJanela PIXEL; 
    ACTION ( Folha(nHora, nValHora) )

    // Definindo um grupo de exibi��o
    @ (nJanAlt / 6) + 1, 003 GROUP oGrp2 to (nJanAlt / 2) -1, (nJanLarg / 2) - 3 PROMPT "Folha de Pagamento: " OF oJanela PIXEL

    @ 060, 015 MSGET oSalBru VAR cSalBru    SIZE 120, 07 OF oJanela PIXEL
    oSalBru:lActive := .F.

    @ 072, 016 SAY "Imposto de Renda "       SIZE (nJanLarg / 5) - 3, 007 OF oJanela PIXEL
    @ 070, (nJanLarg / 4) + 3 MSGET oIR VAR cIR            SIZE (nJanLarg / 5) - 3, 007 OF oJanela PIXEL
    oIR:lActive := .F.

    @ 082, 016 SAY "INSS: "       SIZE (nJanLarg / 5) - 3, 007 OF oJanela PIXEL
    @ 080, (nJanLarg / 4) + 3 MSGET oINSS VAR cINSS        SIZE (nJanLarg / 5) - 3, 007 OF oJanela PIXEL
    oINSS:lActive := .F.

    @ 092, 016 SAY "FGTS: "       SIZE (nJanLarg / 5) - 3, 007 OF oJanela PIXEL
    @ 090, (nJanLarg / 4) + 3 MSGET oFGTS VAR cFGTS        SIZE (nJanLarg / 5) - 3, 007 OF oJanela PIXEL
    oFGTS:lActive := .F.

    @ 102, 016 SAY "Total de Descontos:"       SIZE (nJanLarg / 5) - 3, 007 OF oJanela PIXEL
    @ 100, (nJanLarg / 4) + 3 MSGET oTot VAR cTot        SIZE (nJanLarg / 5) - 3, 007 OF oJanela PIXEL
    oTot:lActive := .F.

    @ 110, 015 MSGET oSalLiq VAR cSalLiq    SIZE 120, 07 OF oJanela PIXEL
    oSalLiq:lActive := .F.

    DEFINE SBUTTON FROM 130, 110 TYPE 2 ACTION (oJanela:End()) ENABLE OF oJanela

    ACTIVATE MSDIALOG oJanela CENTERED
Return 

Static Function Folha(nHora, nValHora)
    local nBruto := val(nHora) * val(nValHora)
    local nLiq   := 0
    local nIR    := 0
    local nINSS  := 0
    local nFGTS  := 0
    local nTot   := 0

    cSalBru := "Sal�rio Bruto: " + cvaltochar(nHora) + " * " + cvaltochar(nValHora) + " = R$ " + cvaltochar(noround(nBruto, 2))
    oSalBru:Refresh()

    Do Case
        Case nBruto < 1200
            cIR := "Isento"
            oIR:Refresh()
        Case nBruto >= 1200 .and. nBruto <= 1799
            nIR := (nBruto * 5) / 100
            cIr := " - R$ " + cvaltochar(nIR)
            oIR:Refresh()
        Case nBruto >= 1799 .and. nBruto <= 2499
            nIR := (nBruto * 10) / 100
            cIr := " - R$ " + cvaltochar(nIR)
            oIR:Refresh()
        Case nBruto >= 2500
            nIR := (nBruto * 20) / 100
            cIr := " - R$ " + cvaltochar(nIR)
            oIR:Refresh()
    end case

    nINSS := (nBruto * 10) / 100
    cINSS := " - R$ " + cvaltochar(noround(nINSS, 2))
    oINSS:Refresh()

    nFGTS := (nBruto * 11) / 100
    cFGTS := " - R$ " + cvaltochar(noround(nFGTS, 2))
    oFGTS:Refresh()

    nTot := nIR + nINSS
    cTot := " R$ " + cvaltochar(noround(nTot, 2))
    oTot:Refresh()

    nLiq := nBruto - nTot
    cSalLiq := "Sal�rio Liquido: R$ " + cvaltochar(noround(nLiq, 2))
    oSalLiq:Refresh()

Return
