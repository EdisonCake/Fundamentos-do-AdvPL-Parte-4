#INCLUDE 'PROTHEUS.CH'

User Function L4E18()
  Local cAlias  := 'ZZC'
  Local cTitulo := 'Cadastro de Cursos'
  Local lVldAlt := 'U_VldAlt()'

  DbSelectArea(cAlias)
  DbSetOrder(1)
  AxCadastro(cAlias, cTitulo, '.F.', lVldAlt)
Return
