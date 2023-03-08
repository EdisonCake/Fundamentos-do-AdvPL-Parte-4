#INCLUDE 'TOTVS.CH'

User Function AdvPL03()
    //Declaração de Variáveis de recepção de dados.
    private oSalario, nSalario  := space(10)
    private oAjuste, nAjuste   := space(9)

    // Declaração de variáveis de criação de janela.
    Private oJanela
    Private oFinal, cFinal := ""

    // Definindo/Criando a janela de exibição.
    DEFINE MSDIALOG oJanela TITLE "Reajuste de Salário" FROM 000, 000 TO 250, 300 PIXEL

    // Solicitando ao usuário o salário atual
    @ 010, 015 SAY "Digite o salário atual do funcionário:"   SIZE 120, 07 OF oJanela PIXEL 
    @ 020, 015 MSGET oSalario VAR nSalario                    SIZE 120, 07 OF oJanela PIXEL

    // Solicitando ao usuário qual o percentual
    @ 040, 015 SAY "Qual o percentual de ajuste?"  SIZE 120, 07 OF oJanela PIXEL 
    @ 050, 015 MSGET oAjuste VAR nAjuste           SIZE 120, 07 OF oJanela PIXEL PICTURE "999"

    // Informando ao usuário qual seu novo salário
    @ 067, 015 SAY "R$ "                   SIZE 120, 07 OF oJanela PIXEL
    @ 065, 025 MSGET oFinal VAR cFinal     SIZE 110, 07 OF oJanela PIXEL
    oFinal:lActive := .F.

    // Criando um botão para realizar a conversão.
    @ 090, 050 BUTTON "AJUSTAR"            SIZE 50, 20 OF oJanela PIXEL;
    ACTION ( Adjust(nSalario, nAjuste) )

    ACTIVATE MSDIALOG oJanela CENTERED
Return 

// Função para o cálculo do novo salário através de dois parâmetros passados.
Static Function Adjust(nValor1, nValor2)

    // Declaração de variáveis da função.
    local cAux      := alltrim(nValor1)
    local nNovo     := 0
    local nCount    := 0
    local nValida   := 0
    local nASC      := 0

    // Iniciado um contador para fazer a validação de entrada. Qualquer coisa diferente de um número ou um "." será barrado.
    For nCount := 1 to len(cAux)
        nASC := ASC(SUBSTR(cAux, nCount))

        if (nASC < 48 .or. nAsc > 57) .and. nAsc != 46
            nValida++
        endif
    Next

    // Se a validação de entrada retornar positivo, o usuário recebe um aviso de entrada inválida, senão, segue com o programa de cálculo.
    if nValida > 0
        MsgStop("Entrada de salário inválida.", "Atenção!")
        cFinal:= ""
        oFinal:Refresh()
    else

        // O novo salário é atribuido ao objeto de exibição e o mesmo é atualizado.
        nNovo := val(nValor1) + ((val(nValor1) * val(nValor2)) / 100)
        cFinal := cvaltochar(noround(nNovo, 2))
        oFinal:Refresh()
    endif

Return
