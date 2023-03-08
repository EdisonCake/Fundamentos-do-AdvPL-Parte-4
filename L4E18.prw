#INCLUDE 'PROTHEUS.CH'

User Function L4E18()
  // Declaração de variáveis.
  Local cAlias  := 'ZZC'
  Local cTitulo := 'Cadastro de Cursos'

  // Criação da AxCadastro para a tabela de cadastro de cursos.
  DbSelectArea(cAlias)
  DbSetOrder(1)
  AxCadastro(cAlias, cTitulo, '.F.', NIL)
Return
