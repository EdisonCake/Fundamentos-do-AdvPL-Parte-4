#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function AdvPl14()
    local cTitle := "Pesquisa de Pedido por Produto"
    Private oJanela, oGrp
    Private cProduto := space(30)

    private nJanAlt  := 130
    private nJanLarg := 300

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    DEFINE MSDIALOG oJanela TITLE cTitle FROM 000, 000 TO nJanAlt, nJanLarg PIXEL

        @ 003, 003 GROUP oGrp TO (nJanAlt / 2) - 3 , (nJanLarg / 2) - 3 PROMPT "Busca de Produtos: " OF oJanela PIXEL

        @ 015, 015 SAY "C�digo do Produto: "  SIZE 057, 007 OF oJanela PIXEL
        @ 025, 015 MSGET cProduto             SIZE 120, 008 OF oJanela PIXEL F3 "SB1"

        @ 040, 015 BUTTON "Pesquisar"         SIZE 120, 010 OF oJanela PIXEL;
        ACTION ( BuscCPV1() )

    ACTIVATE MSDIALOG oJanela CENTERED

Return

Static Function BuscCPV1()
    // Declara��o de vari�veis.
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cDesc     := ""
    
    // Aqui � preparado o ambiente com base na empresa, filial, tabela e m�dulo referentes.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC6' MODULO 'COM'

    // Aqui � passada a informa��o ao c�digo da pesquisa a ser realizada no banco de dados.
    cQuery := "SELECT PED.C5_NUM, PROD.C6_PRODUTO FROM " + RetSqlName('SC6') + " PROD INNER JOIN " + RetSqlName('SC5') + " PED ON PROD.C6_NUM = PED.C5_NUM WHERE PROD.C6_PRODUTO = '" + cProduto + "' AND PROD.D_E_L_E_T_ = ' '"

    // E aqui � feita a pesquisa, posicionando, em seguida, o ponteiro no topo da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro n�o atingir o final da tabela, ser� concatenado o n�mero do pedido com um separador de v�rgula.
    While &(cAlias)->(!EOF())

        cDesc += alltrim(&(cAlias)->(C5_NUM)) + ", "       
        &(cAlias)->(DbSkip())

    End

    // Ao final, ser� exibido ao usu�rio a informa��o solicitada, por�m, utilizando uma fun��o STUFF() que substituir� a �ltima v�rgula por um ponto final.
    FwAlertInfo("O produto pesquisado se encontra nos pedidos:" + CRLF +;
                stuff(cDesc, len(cDesc) - 1, 2, ".") , "Pesquisa de Produto")

    // Aqui a tabela � fechada e a �rea restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
