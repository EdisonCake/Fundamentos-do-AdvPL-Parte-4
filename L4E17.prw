#INCLUDE 'PROTHEUS.CH'

User Function L4E17()
    // Declaração de variáveis.
    local aArea         := GetArea()
    Local cAlias        := 'ZZS'
    // local aLegenda      := {}
    Private cCadastro   := 'Cadastro de Alunos'
    Private aCores      := {}
    Private aRotina     := {}
    
    
    // Monstando o array aRotina, com as funções normais de menu e uma legenda personalizada.
    aAdd(aRotina, {'Pesquisar',    'AxPesqui',   0, 1})
    aAdd(aRotina, {'Visualizar',   'AxVisual',   0, 2})
    aAdd(aRotina, {'Cadastrar',    'AxInclui',   0, 3})
    aAdd(aRotina, {'Alterar',      'AxAltera',   0, 4})
    aAdd(aRotina, {'Excluir',      'AxDeleta',   0, 5})
    Aadd(aRotina, {'Legenda',      'u_LegZZS',   0, 6})

    // Montando o array de legendas.
    aAdd(aCores, {"ZZS_IDADE < 18", "DISABLE"})
    aAdd(aCores, {"ZZS_IDADE > 18", "ENABLE"})
    
    // Selecionando a tabela e ordenando.
    DbSelectArea('ZZS')
    ('ZZS')->(DbSetOrder(1))
    
    // Montando a mBrowse
    MBrowse(NIL, NIL, NIL, NIL, cAlias, , , , , , aCores)
    
    //Encerrando a notina.
    DbCloseArea()
    RestArea(aArea)
Return

// Função para criação de legenda personalizada para a rotina.
User Function LegZZS()
    local cQualquer := "Legenda"
    local aCor      := {}


    aAdd(aCor, {"VERDE", "Maior de 18 Anos"})
    aAdd(aCor, {"VERMELHO", "Menor de 18 Anos"})

    brwlegenda(cCadastro, cQualquer, aCor)

Return 
