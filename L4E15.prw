#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function AdvPl15()
    local cTitle := "Pesquisa de Produto"
    Private oJanela, oGrp
    Private cProduto := space(30)

    private nJanAlt  := 130
    private nJanLarg := 300

    DEFINE MSDIALOG oJanela TITLE cTitle FROM 000, 000 TO nJanAlt, nJanLarg PIXEL

        @ 003, 003 GROUP oGrp TO (nJanAlt / 2) - 3 , (nJanLarg / 2) - 3 PROMPT "Busca de Produtos: " OF oJanela PIXEL

        @ 015, 015 SAY "Código do Produto: "  SIZE 057, 007 OF oJanela PIXEL
        @ 025, 015 MSGET cProduto             SIZE 120, 008 OF oJanela PIXEL

        @ 040, 015 BUTTON "Pesquisar"         SIZE 120, 010 OF oJanela PIXEL;
        ACTION ( BuscCOD2() )

    ACTIVATE MSDIALOG oJanela CENTERED

Return 

Static Function BuscCOD2()
    // Declaração de variáveis
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := ""
    local cDesc     := ""
    local lCadastro := .T.
    
    // Aqui é preparado o ambiente com base na empresa, filial, tabela e módulos selecionados.
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

    cQuery := "SELECT * FROM " + RetSqlName('SB1') + " WHERE B1_COD = '" + alltrim(cProduto) + "' AND D_E_L_E_T_ = ' '"

    // E aqui é feita a pesquisa no banco de dados.
    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    // Enquanto o ponteiro não chegar ao final, será feita uma comparação com o registro selecionado.
    While &(cAlias)->(!EOF())

        // Caso o registro do campo seja exatamente igual à pesquisa do usuário, será atribuída a informação à variável correspondente.
        if alltrim(&(cAlias)->(B1_COD)) == alltrim(cProduto)
            cDesc := "Código: " + &(cAlias)->(B1_COD) + CRLF +;
                     "Descrição: " + &(cAlias)->(B1_DESC) + CRLF+;
                     "Preço de Venda: R$ " + cvaltochar(&(cAlias)->(B1_PRV1))
            &(cAlias)->(DbSkip())
        endif
        
    End

    // Se a descrição estiver nula/em branco, será informado ao usuário a inexistêncaia do código/produto, senão, é informado ao usuário as informações da pesquisa.
    if cDesc == ""
        lCadastro := MsgYesNo("Não foram encontrados produtos com o código informado.", "Atenção")

            If lCadastro == .t.
                AxCadastro('SB1', 'Cadastro de Produtos')
            Else
                Return
            endif

    else
        FwAlertInfo(cDesc)
    endif

    // Aqui é fechada a tabela e restaurada a área
    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 
