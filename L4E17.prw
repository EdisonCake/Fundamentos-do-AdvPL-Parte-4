#INCLUDE 'PROTHEUS.CH'

User Function L4E17()
    Local cAlias      := 'ZZS'
    Private cCadastro := 'Cadastro de Alunos'
    Private aCores := {{ 'ZZS->ZZS_IDADE > 18' , 'ENABLE' },;
                       {'ZZS->ZZS_IDADE < 18', 'DISABLE'}}
    Private aRotina := {}
    
    Aadd(aRotina, {'Pesquisar',    'AxPesqui',   0, 1})
    Aadd(aRotina, {'Visualizar',   'AxVisual',   0, 2})
    Aadd(aRotina, {'Cadastrar',    'AxInclui',   0, 3})
    Aadd(aRotina, {'Alterar',      'AxAltera',   0, 4})
    Aadd(aRotina, {'Excluir',      'AxDeleta',   0, 5})
    Aadd(aRotina, {'Legenda',      'U_Captions', 0, 6})
    
    DbSelectArea('ZZS')
    DbSetOrder(1)
    
    MBrowse(NIL, NIL, NIL, NIL, cAlias, , , , , ,aCores)
    
    DbCloseArea()
Return

User Function Captions()
    FwAlertInfo("Verde - Alunos maiores de 18 anos." + CRLF +;
                "Vermelho - Alunos com menos de 18 anos.", "Legenda")
Return 
