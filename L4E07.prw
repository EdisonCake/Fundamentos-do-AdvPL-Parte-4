#INCLUDE 'TOTVS.CH'

User Function AdvPl07()
    Local aArea := GetArea()
    Local oGrpLog
    Local oBtnConf
    Private lRetorno := .F.
    Private oDlgPvt

    //Says e Gets
    Private oSayUsr
    Private oGetUsr, cGetUsr := Space(25) // Vai pegar o usuário
    Private oSayPsw
    Private oGetPsw, cGetPsw  := Space(20) // Vai pegar a senha
    Private oGetConf, cGetConf := Space(20) // Vai pegar a confirmação da senha
    Private oGetErr, cGetErr  := ""

    //Dimensões da janela
    Private nJanLarg := 200
    Private nJanAltu := 250
      
    //Criando a janela
    DEFINE MSDIALOG oDlgPvt TITLE "Cadastro" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL

        //Grupo de Cadastro
        @ 003, 001     GROUP oGrpLog TO (nJanAltu/2)-1, (nJanLarg/2)-3         PROMPT "Cadastro de Usuário: "     OF oDlgPvt COLOR 0, 16777215 PIXEL

            //Label e Get de Usuário
            @ 013, 006   SAY   oSayUsr PROMPT "Usuário:"        SIZE 030, 007 OF oDlgPvt                    PIXEL
            @ 020, 006   MSGET oGetUsr VAR    cGetUsr           SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 PIXEL
          
            //Label e Get da Senha
            @ 033, 006   SAY   oSayPsw PROMPT "Senha:"          SIZE 030, 007 OF oDlgPvt                    PIXEL
            @ 040, 006   MSGET oGetPsw VAR    cGetPsw           SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 PIXEL PASSWORD
          
            //Label e Get da Confirmação da senha
            @ 053, 006   SAY   oSayPsw PROMPT "Confirme:"       SIZE 030, 007 OF oDlgPvt                    PIXEL
            @ 060, 006   MSGET oGetConf VAR    cGetConf         SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 PIXEL PASSWORD
          
            //Get de Log, pois se for Say, não da para definir a cor
            @ 080, 006   MSGET oGetErr VAR    cGetErr        SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 NO BORDER PIXEL
            oGetErr:lActive := .F.
            oGetErr:setCSS("QLineEdit{color:#FF0000; background-color:#FEFEFE;}")
          
            //Botões
            @ (nJanAltu/2)-18, 006 BUTTON oBtnConf PROMPT "Cadastrar"             SIZE (nJanLarg/2)-12, 015 OF oDlgPvt ACTION (fVldUsr()) PIXEL
            oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")
    ACTIVATE MSDIALOG oDlgPvt CENTERED
      
    //Se a rotina foi confirmada e deu certo, atualiza o usuário e a senha
    If lRetorno
        cUsrLog     := Alltrim(cGetUsr)
        cPswLog     := Alltrim(cGetPsw)
        cPswConfLog := Alltrim(cGetConf)
    EndIf
      
    RestArea(aArea)
Return lRetorno

// Função de validação de usuário e senha
Static Function fVldUsr()
    Local cUsrAux   := Alltrim(cGetUsr)
    Local cPswAux   := Alltrim(cGetPsw)
    Local cPswAux2  := Alltrim(cGetConf)
    Local nCount    := 0
    Local nNum      := 0
    Local nSimb     := 0
    Local nUpp      := 0
    Local cCheck    := ""

    // Se o usuário atende aos requisitos, ele entra em um novo bloco condicional.
    if len(cUsrAux) > 6
        
        // Se a senha atende aos requisitos, entra em um novo bloco condicional.
        if len(cPswAux) > 6

            // Aqui, será verificado se a senha possui a quantidade mínima de caracteres especiais solicitados.
            for nCount := 1 to len(cPswAux)
                cCheck := asc(substr(cPswAux,nCount))

                // Aqui, vai atribuir ao contador as validações.
                if cCheck >= 48 .and. cCheck <= 57
                    nNum++
                elseif cCheck >= 65 .and. cCheck <= 90
                    nUpp++
                elseif cCheck >= 33 .and. cCheck <= 47
                    nSimb++
                elseif cCheck >= 58 .and. cCheck <= 64
                    nSimb++
                elseif cCheck >= 91 .and. cCheck <= 93
                    nSimb++
                elseif cCheck >= 123 .and. cCheck <= 125
                    nSimb++
                endif
            Next

            // Se as validações obtiverem menos do que o esperado, a senha não é aceita pelo algoritmo.
            if (nNum > 0) .and. (nUpp > 0) .and. (nSimb > 0)

                // Se a confirmação da senha estiver em branco, é solicitado ao usuário que o mesmo confirme-a.
                if cPswAux2 == " "
                    cGetErr := "Confirme a senha!"
                    oGetErr:Refresh()
                
                // Aqui, é validado se ambas as senhas coincidem. Senão, é informado ao usuário.
                else
                    if cPswAux == cPswAux2
                       lRetorno := .T. 
                    else
                        cGetErr := "Senhas não coincidem"
                        oGetErr:Refresh()
                    endif

                endif

            else
                cGetErr := "Senha inválida!"
                oGetErr:Refresh()
            endif

        else
            cGetErr := "Senha inválida!"
            oGetErr:Refresh()
        endif
        
    // Senão atualiza o erro e retorna para a rotina
    Else
        cGetErr := "Usuário inválido."
        oGetErr:Refresh()
    EndIf
      
    //Se o retorno for válido, fecha a janela
    If lRetorno
        MsgInfo("Bem vindo(a)!", "Cadastro efetuado com sucesso!")
        oDlgPvt:End()
    EndIf
Return
