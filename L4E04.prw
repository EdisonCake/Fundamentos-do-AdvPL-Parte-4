#INCLUDE 'TOTVS.CH'

User Function AdvPL04()
    // Declara��o de vari�veis para entrada de dados.
    local nAltura := space(9)
    local nLargura := space(9)

    // Declara��o de vari�veis para a cria��o da janela.
    local cTitle := "Simulador Suvinil V2.0"
    private oJanela
    private oTinta, cTinta := ""

    // Cria��o da janela.
    DEFINE MSDIALOG oJanela TITLE cTitle FROM 000, 000 TO 150, 300 PIXEL

    // Iniciando os gets de entrada das informa��es.
    @ 010, 015 SAY "Altura"       SIZE 020, 007 OF oJanela PIXEL
    @ 018, 015 MSGET nAltura      SIZE 030, 008 OF oJanela PIXEL

    @ 010, 060 SAY "Largura"      SIZE 020, 007 OF oJanela PIXEL
    @ 018, 060 MSGET nLargura     SIZE 030, 008 OF oJanela PIXEL

    // Bot�o para calcular as tintas necess�rias para pintar a �rea da parede.
    @ 010, 105 BUTTON "Calcular"  SIZE 030, 019 OF oJanela PIXEL;
    ACTION ( Area(nAltura, nLargura) )

    // �rea de exibi��o dos resultados.
    @ 035, 015 MSGET oTinta VAR cTinta    SIZE 121, 020 OF oJanela PIXEL
    oTinta:lActive := .F.

    // Ativa��o da janela com os elementos.
    ACTIVATE MSDIALOG oJanela CENTERED

Return 

// Fun��o para o c�lculo da �rea e latas de tintas necess�rias.
Static Function Area(nParam1, nParam2)
    // Declara��o local de vari�veis.
    local cArea  := ""
    local nTinta := 0

    // Aqui � realizado o c�lculo da �rea da parede, e informada a �rea ao usu�rio.
    cArea := cvaltochar(val(nParam1) * val(nParam2)) + "m�."
    FwALertInfo("A �rea da parede � de " + cArea, "�rea da Parede")

    // Aqui � feito o c�lculo do litro de tinta com a �rea.
    nTinta := ((val(nParam1) * val(nParam2)) / 2 )// Cada litro de tinta pinta 2m�

    // E por fim, a �rea de exibi��o do programa � atualizada com a informa��o.
    cTinta := "Ser�o necess�rios " + cvaltochar(nTinta) + " latas de tinta."
    oTinta:Refresh()

Return 
