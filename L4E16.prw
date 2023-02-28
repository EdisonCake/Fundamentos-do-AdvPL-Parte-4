#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function AdvPl16()
    local cTitle := "Pesquisa de Fornecedor por Estado"
    Private oJanela, oGrp
    Private cEstado := space(2)

    private nJanAlt  := 130
    private nJanLarg := 300

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SA2' MODULO 'COM'

    DEFINE MSDIALOG oJanela TITLE cTitle FROM 000, 000 TO nJanAlt, nJanLarg PIXEL

        @ 003, 003 GROUP oGrp TO (nJanAlt / 2) - 3 , (nJanLarg / 2) - 3 PROMPT "Busca de Produtos: " OF oJanela PIXEL

        @ 015, 015 SAY "Estado: "  SIZE 057, 007 OF oJanela PIXEL
        @ 025, 015 MSGET cEstado   SIZE 120, 008 OF oJanela PIXEL PICTURE "@!"

        @ 040, 015 BUTTON "Pesquisar"         SIZE 120, 010 OF oJanela PIXEL;
        ACTION ( BuscaFOR() )

    ACTIVATE MSDIALOG oJanela CENTERED

Return

Static Function BuscaFOR()
    // Declara��o de vari�veis.
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cDesc     := ""
    // Aqui � informada a pesquisa que ser� feita no banco de dados.
    cQuery := "SELECT * FROM " + RetSqlName('SA2') + " WHERE A2_EST = '" + upper(cEstado) + "' AND D_E_L_E_T_ = ' '"

    // E aqui, a mesma � realizada, posicionando em seguida o ponteiro no in�cio da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto n�o for atingido o final da tabela, � realizada a concatena��o das informa��es solicitadas.
    While &(cAlias)->(!EOF())
        cDesc += "C�digo: " + &(cAlias)->(A2_COD) + CRLF +;
                 " Nome: " + &(cAlias)->(A2_NOME) + CRLF +;
                 Replicate("=", 35) + CRLF
        &(cAlias)->(DbSkip())
    End

    // Por fim, a mesma � exibida ao usu�rio.
    FwAlertInfo(cDesc, "Fornecedores")

    // E aqui, a tabela � fechada e a �rea restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
