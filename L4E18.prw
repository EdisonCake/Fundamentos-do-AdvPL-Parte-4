#INCLUDE 'PROTHEUS.CH'

User Function L4E18()
  // Declara��o de vari�veis.
  Local cAlias  := 'ZZC'
  Local cTitulo := 'Cadastro de Cursos'

  // Cria��o da AxCadastro para a tabela de cadastro de cursos.
  DbSelectArea(cAlias)
  DbSetOrder(1)
  AxCadastro(cAlias, cTitulo, '.F.', NIL)
Return
