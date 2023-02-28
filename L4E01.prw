#INCLUDE 'TOTVS.CH'

User Function AdvPL01()
    //Declara��o de Vari�veis de recep��o de dados.
    local nUser1 := space(25)
    local nUser2 := space(25)

    // Declara��o de vari�veis de cria��o de janela.
    local cTitle := "Quatro Opera��es"
    Private oJanela
    Private oResult1, cResult1 := ""
    Private oResult2, cResult2 := ""
    Private oResult3, cResult3 := ""
    Private oResult4, cResult4 := ""

    // Definindo/Criando a janela de exibi��o.
    DEFINE MSDIALOG oJanela TITLE cTitle FROM 000, 000 TO 350, 300 PIXEL

    //Definindo posicionamento e tamanho do elemento e solicitando o primeiro n�mero ao usu�rio.
    @ 010, 015 SAY "Digite o primeiro n�mero:"  SIZE 120, 07 OF oJanela PIXEL
    @ 020, 015 MSGET nUser1                     SIZE 120, 07 OF oJanela PIXEL PICTURE "9999999999"

    //Definindo posicionamento e tamanho do elemento e solicitando o segundo n�mero ao usu�rio.
    @ 040, 015 SAY "Digite o segundo n�mero:"   SIZE 120, 07 OF oJanela PIXEL
    @ 050, 015 MSGET nUser2                     SIZE 120, 07 OF oJanela PIXEL PICTURE "9999999999"

    // Definindo posicionamento e tamanho do bot�o a executar a a��o das quatro opera��es.
    @ 070, 015 BUTTON "Pressione aqui para as quatro opera��es!" SIZE 120, 15 OF oJanela PIXEL;
    ACTION ( OP(nUser1, nUser2) )

    // Bloco definindo a �rea de exibi��o das quatro opera��es.
    @ 100, 015 MSGET oResult1 VAR cResult1       SIZE 120, 07 OF oJanela PIXEL
    oResult1:lActive := .F.

    @ 115, 015 MSGET oResult2 VAR cResult2       SIZE 120, 07 OF oJanela PIXEL
    oResult2:lActive := .F.

    @ 130, 015 MSGET oResult3 VAR cResult3       SIZE 120, 07 OF oJanela PIXEL
    oResult3:lActive := .F.

    @ 145, 015 MSGET oResult4 VAR cResult4       SIZE 120, 07 OF oJanela PIXEL
    oResult4:lActive := .F.

    //Bot�o de encerramento do programa.
    @ 160, 015 BUTTON "Encerrar" SIZE   120, 10 OF oJanela PIXEL;
    ACTION ( oJanela:End() )
    
    // Por fim, � ativada a janela com todos os elementos.
    ACTIVATE MSDIALOG oJanela CENTERED

Return 

// Fun��o para as quatro opera��es.
Static Function OP(nValor1, nValor2)
    // Declara��o de vari�veis de opera��o matem�tica.
    local nSoma         := 0
    local nDivisao      := 0
    local nMulti        := 0
    local nSubtracao    := 0

    // Aqui � atribu�do cada opera��o � sua vari�vel.
    nSoma      := (val(nValor1) + val(nValor2))
    nDivisao   := (val(nValor1) / val(nValor2))
    nMulti     := (val(nValor1) * val(nValor2))
    nSubtracao := (val(nValor1) - val(nValor2))

    // E aqui, � enviada a informa��o para o nosso prompt de exibi��o
    cResult1 := alltrim(cvaltochar(nValor1)) + " + " + alltrim(cvaltochar(nValor2)) + " = " + alltrim(cvaltochar(nSoma))

    cResult2 := alltrim(cvaltochar(nValor1)) + " / " + alltrim(cvaltochar(nValor2)) + " = " + alltrim(cvaltochar(nDivisao))
        oResult2:Refresh()
        
    cResult3 := alltrim(cvaltochar(nValor1)) + " * " + alltrim(cvaltochar(nValor2)) + " = " + alltrim(cvaltochar(nMulti))
        oResult3:Refresh()

    cResult4 := alltrim(cvaltochar(nValor1)) + " - " + alltrim(cvaltochar(nValor2)) + " = " + alltrim(cvaltochar(nSubtracao))
        oResult4:Refresh()

Return 
