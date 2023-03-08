#INCLUDE 'TOTVS.CH'

User Function AdvPL03()
    //Declara��o de Vari�veis de recep��o de dados.
    private oSalario, nSalario  := space(10)
    private oAjuste, nAjuste   := space(9)

    // Declara��o de vari�veis de cria��o de janela.
    Private oJanela
    Private oFinal, cFinal := ""

    // Definindo/Criando a janela de exibi��o.
    DEFINE MSDIALOG oJanela TITLE "Reajuste de Sal�rio" FROM 000, 000 TO 250, 300 PIXEL

    // Solicitando ao usu�rio o sal�rio atual
    @ 010, 015 SAY "Digite o sal�rio atual do funcion�rio:"   SIZE 120, 07 OF oJanela PIXEL 
    @ 020, 015 MSGET oSalario VAR nSalario                    SIZE 120, 07 OF oJanela PIXEL

    // Solicitando ao usu�rio qual o percentual
    @ 040, 015 SAY "Qual o percentual de ajuste?"  SIZE 120, 07 OF oJanela PIXEL 
    @ 050, 015 MSGET oAjuste VAR nAjuste           SIZE 120, 07 OF oJanela PIXEL PICTURE "999"

    // Informando ao usu�rio qual seu novo sal�rio
    @ 067, 015 SAY "R$ "                   SIZE 120, 07 OF oJanela PIXEL
    @ 065, 025 MSGET oFinal VAR cFinal     SIZE 110, 07 OF oJanela PIXEL
    oFinal:lActive := .F.

    // Criando um bot�o para realizar a convers�o.
    @ 090, 050 BUTTON "AJUSTAR"            SIZE 50, 20 OF oJanela PIXEL;
    ACTION ( Adjust(nSalario, nAjuste) )

    ACTIVATE MSDIALOG oJanela CENTERED
Return 

// Fun��o para o c�lculo do novo sal�rio atrav�s de dois par�metros passados.
Static Function Adjust(nValor1, nValor2)

    // Declara��o de vari�veis da fun��o.
    local cAux      := alltrim(nValor1)
    local nNovo     := 0
    local nCount    := 0
    local nValida   := 0
    local nASC      := 0

    // Iniciado um contador para fazer a valida��o de entrada. Qualquer coisa diferente de um n�mero ou um "." ser� barrado.
    For nCount := 1 to len(cAux)
        nASC := ASC(SUBSTR(cAux, nCount))

        if (nASC < 48 .or. nAsc > 57) .and. nAsc != 46
            nValida++
        endif
    Next

    // Se a valida��o de entrada retornar positivo, o usu�rio recebe um aviso de entrada inv�lida, sen�o, segue com o programa de c�lculo.
    if nValida > 0
        MsgStop("Entrada de sal�rio inv�lida.", "Aten��o!")
        cFinal:= ""
        oFinal:Refresh()
    else

        // O novo sal�rio � atribuido ao objeto de exibi��o e o mesmo � atualizado.
        nNovo := val(nValor1) + ((val(nValor1) * val(nValor2)) / 100)
        cFinal := cvaltochar(noround(nNovo, 2))
        oFinal:Refresh()
    endif

Return
