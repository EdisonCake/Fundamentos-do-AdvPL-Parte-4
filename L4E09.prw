#INCLUDE 'TOTVS.CH'

User Function AdvPL09()
    // Declaração de variáveis.
    local nPeso     := space(15)
    local nAltura   := space(15)
    local nIdade    := space(2)
    local cSexo     := space(1)

    local cTitle := "Taxa Metabólica Basal"
    Private oJanela

    // Criação da janela
    DEFINE MSDIALOG oJanela TITLE cTitle FROM 000, 000 TO 300, 300 PIXEL

    // Label e get de peso, idade, altura e sexo do usuário.
    @ 010, 015 SAY "Peso (KG):"                 SIZE 060, 07 OF oJanela PIXEL
    @ 020, 015 MSGET oPeso VAR nPeso            SIZE 060, 07 OF oJanela PIXEL

    @ 010, 075 SAY "Idade:"                     SIZE 060, 07 OF oJanela PIXEL
    @ 020, 075 MSGET nIdade                     SIZE 060, 07 OF oJanela PIXEL PICTURE "99"

    @ 040, 015 SAY "Digite sua altura (CM):"    SIZE 120, 07 OF oJanela PIXEL
    @ 050, 015 MSGET oAltura VAR nAltura        SIZE 120, 07 OF oJanela PIXEL PICTURE "999"

    @ 070, 015 SAY "Digite seu sexo (M/F):"     SIZE 120, 07 OF oJanela PIXEL
    @ 080, 015 MSGET cSexo                      SIZE 120, 07 OF oJanela PIXEL PICTURE "!"

    // Botão para realizar o cálculo do TMB
    @ 100, 035 BUTTON "TMB"                     SIZE 080, 15 OF oJanela PIXEL;
    ACTION ( CalcTMB(nPeso, nAltura, cSexo, nIdade) )

    // Botão extra para finalizar o programa.
    @ 120, 045 BUTTON "Finalizar"               SIZE 060, 15 OF oJanela PIXEL;
    ACTION ( oJanela:End() )

    ACTIVATE MSDIALOG oJanela CENTERED

Return 

// Função para fazer o cálculo do TMB
Static Function CalcTMB(nPeso, nAltura, cSexo, nIdade)
    local nTMB := 0

    // Bloco condicional que, de acordo com o sexo do usuário, faz o cálculo do valor do TMB.
    do case
        case alltrim(cSexo) == "M"
            nTMB := 66.5 + (13.75 * val(nPeso)) + (5.003 * val(nAltura)) - (6.75 * val(nIdade))
        case alltrim(cSexo) == "F"
            nTMB := 655.1 + (9.563 * vanl(nPeso)) + (1.850 * val(nAltura)) - (4.676 * val(nIdade))
        otherwise
            MsgStop("Entrada de informação inválida!", "Atenção!")
    end case

    // Mensagem de alerta para a exibição do cálculo.
    FwAlertInfo(cvaltochar(noround(nTMB, 2)), "Taxa Metabólica Basal")

Return 
