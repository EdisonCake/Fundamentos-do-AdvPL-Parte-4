#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function AdvPl12()
    local cTitle := "Pesquisa de Produto por Data"
    local dDataIni := CTOD("")
    local dDataFim := CTOD("")

    SET DATE TO BRITISH         // Aqui é transformado o formato da data para AA/MM/DD
    Set(_SET_EPOCH, 1980)

    Private oJanela, oGrp

    private nJanAlt  := 130
    private nJanLarg := 300

    DEFINE MSDIALOG oJanela TITLE cTitle FROM 000, 000 TO nJanAlt, nJanLarg PIXEL

        @ 003, 003 GROUP oGrp TO (nJanAlt / 2) - 3 , (nJanLarg / 2) - 3 PROMPT "Busca por Data: " OF oJanela PIXEL

            @ 017, 015 SAY "Data de Início"     SIZE 057, 007 OF oJanela PIXEL
            @ 015, 085 MSGET dDataIni           SIZE 050, 007 OF oJanela PIXEL 

            @ 027, 015 SAY "Data Final"         SIZE 057, 007 OF oJanela PIXEL
            @ 025, 085 MSGET dDataFim           SIZE 050, 007 OF oJanela PIXEL 

            @ (nJanAlt / 2 ) - 20, 015 BUTTON "Pesquisar"         SIZE 120, 010 OF oJanela PIXEL;
            ACTION ( BuscaDAT( dDataIni, dDataFim ) )

    ACTIVATE MSDIALOG oJanela CENTERED

Return

Static Function BuscaDAT(dDataIni, dDataFim)
    // Declaração de variáveis.
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cDesc     := ""
    
    // Aqui é preparado o ambiente com base na empresa, filial, tabela e módulos escolhidos.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5' MODULO 'COM'

    // E aqui é passada a informação convertida para o padrão do banco de dados para que a pesquisa possa ser realizada.
    cQuery := "SELECT * FROM " + RetSqlName('SC5') + " WHERE C5_EMISSAO >= '" + DTOS(dDataIni) + "' AND C5_EMISSAO <= '" + DTOS(dDataFim) + "' AND D_E_L_E_T_ = ' '"

    // Aqui é feita a pesquisa com base nas informações obtidas do usuário e é posicionado o ponteiro no início da tabela.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro não chegar no final da tabela, será concatenadas as informações solicitadas pelo usuário.
    While &(cAlias)->(!EOF())
        cDesc += "Pedido: " + &(cAlias)->(C5_NUM) + " Data de Emissão: " + cvaltochar(StoD(&(cAlias)->(C5_EMISSAO))) + CRLF + CRLF

        &(cAlias)->(DbSkip())
    End

    //Por fim, será exibido ao usuário.
    FwAlertInfo(cDesc, "Pedidos")

    // E a tabela será fechada, e a área restaurada.
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
