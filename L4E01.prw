#INCLUDE 'TOTVS.CH'

User Function AdvPL01()
    //Declaração de Variáveis de recepção de dados.
    local nUser1 := space(25)
    local nUser2 := space(25)

    // Declaração de variáveis de criação de janela.
    local cTitle := "Quatro Operações"
    Private oJanela
    Private oResult1, cResult1 := ""
    Private oResult2, cResult2 := ""
    Private oResult3, cResult3 := ""
    Private oResult4, cResult4 := ""

    // Definindo/Criando a janela de exibição.
    DEFINE MSDIALOG oJanela TITLE cTitle FROM 000, 000 TO 350, 300 PIXEL

    //Definindo posicionamento e tamanho do elemento e solicitando o primeiro número ao usuário.
    @ 010, 015 SAY "Digite o primeiro número:"  SIZE 120, 07 OF oJanela PIXEL
    @ 020, 015 MSGET nUser1                     SIZE 120, 07 OF oJanela PIXEL PICTURE "9999999999"

    //Definindo posicionamento e tamanho do elemento e solicitando o segundo número ao usuário.
    @ 040, 015 SAY "Digite o segundo número:"   SIZE 120, 07 OF oJanela PIXEL
    @ 050, 015 MSGET nUser2                     SIZE 120, 07 OF oJanela PIXEL PICTURE "9999999999"

    // Definindo posicionamento e tamanho do botão a executar a ação das quatro operações.
    @ 070, 015 BUTTON "Pressione aqui para as quatro operações!" SIZE 120, 15 OF oJanela PIXEL;
    ACTION ( OP(nUser1, nUser2) )

    // Bloco definindo a área de exibição das quatro operações.
    @ 100, 015 MSGET oResult1 VAR cResult1       SIZE 120, 07 OF oJanela PIXEL
    oResult1:lActive := .F.

    @ 115, 015 MSGET oResult2 VAR cResult2       SIZE 120, 07 OF oJanela PIXEL
    oResult2:lActive := .F.

    @ 130, 015 MSGET oResult3 VAR cResult3       SIZE 120, 07 OF oJanela PIXEL
    oResult3:lActive := .F.

    @ 145, 015 MSGET oResult4 VAR cResult4       SIZE 120, 07 OF oJanela PIXEL
    oResult4:lActive := .F.

    //Botão de encerramento do programa.
    @ 160, 015 BUTTON "Encerrar" SIZE   120, 10 OF oJanela PIXEL;
    ACTION ( oJanela:End() )
    
    // Por fim, é ativada a janela com todos os elementos.
    ACTIVATE MSDIALOG oJanela CENTERED

Return 

// Função para as quatro operações.
Static Function OP(nValor1, nValor2)
    // Declaração de variáveis de operação matemática.
    local nSoma         := 0
    local nDivisao      := 0
    local nMulti        := 0
    local nSubtracao    := 0

    // Aqui é atribuído cada operação à sua variável.
    nSoma      := (val(nValor1) + val(nValor2))
    nDivisao   := (val(nValor1) / val(nValor2))
    nMulti     := (val(nValor1) * val(nValor2))
    nSubtracao := (val(nValor1) - val(nValor2))

    // E aqui, é enviada a informação para o nosso prompt de exibição
    cResult1 := alltrim(cvaltochar(nValor1)) + " + " + alltrim(cvaltochar(nValor2)) + " = " + alltrim(cvaltochar(nSoma))

    cResult2 := alltrim(cvaltochar(nValor1)) + " / " + alltrim(cvaltochar(nValor2)) + " = " + alltrim(cvaltochar(nDivisao))
        oResult2:Refresh()
        
    cResult3 := alltrim(cvaltochar(nValor1)) + " * " + alltrim(cvaltochar(nValor2)) + " = " + alltrim(cvaltochar(nMulti))
        oResult3:Refresh()

    cResult4 := alltrim(cvaltochar(nValor1)) + " - " + alltrim(cvaltochar(nValor2)) + " = " + alltrim(cvaltochar(nSubtracao))
        oResult4:Refresh()

Return 
