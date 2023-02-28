#INCLUDE 'TOTVS.CH'

User Function AdvPL04()
    // Declaração de variáveis para entrada de dados.
    local nAltura := space(9)
    local nLargura := space(9)

    // Declaração de variáveis para a criação da janela.
    local cTitle := "Simulador Suvinil V2.0"
    private oJanela
    private oTinta, cTinta := ""

    // Criação da janela.
    DEFINE MSDIALOG oJanela TITLE cTitle FROM 000, 000 TO 150, 300 PIXEL

    // Iniciando os gets de entrada das informações.
    @ 010, 015 SAY "Altura"       SIZE 020, 007 OF oJanela PIXEL
    @ 018, 015 MSGET nAltura      SIZE 030, 008 OF oJanela PIXEL

    @ 010, 060 SAY "Largura"      SIZE 020, 007 OF oJanela PIXEL
    @ 018, 060 MSGET nLargura     SIZE 030, 008 OF oJanela PIXEL

    // Botão para calcular as tintas necessárias para pintar a área da parede.
    @ 010, 105 BUTTON "Calcular"  SIZE 030, 019 OF oJanela PIXEL;
    ACTION ( Area(nAltura, nLargura) )

    // Área de exibição dos resultados.
    @ 035, 015 MSGET oTinta VAR cTinta    SIZE 121, 020 OF oJanela PIXEL
    oTinta:lActive := .F.

    // Ativação da janela com os elementos.
    ACTIVATE MSDIALOG oJanela CENTERED

Return 

// Função para o cálculo da área e latas de tintas necessárias.
Static Function Area(nParam1, nParam2)
    // Declaração local de variáveis.
    local cArea  := ""
    local nTinta := 0

    // Aqui é realizado o cálculo da área da parede, e informada a área ao usuário.
    cArea := cvaltochar(val(nParam1) * val(nParam2)) + "m²."
    FwALertInfo("A área da parede é de " + cArea, "Área da Parede")

    // Aqui é feito o cálculo do litro de tinta com a área.
    nTinta := ((val(nParam1) * val(nParam2)) / 2 )// Cada litro de tinta pinta 2m²

    // E por fim, a área de exibição do programa é atualizada com a informação.
    cTinta := "Serão necessários " + cvaltochar(nTinta) + " latas de tinta."
    oTinta:Refresh()

Return 
