#INCLUDE 'TOTVS.CH'

User Function AdvPl07()
    Local aArea := GetArea()
    Local oGrpLog
    Local oBtnConf
    Private lRetorno := .F.
    Private oDlgPvt

    //Says e Gets
    Private oSayUsr
    Private oGetUsr, cGetUsr := Space(25) // Vai pegar o usu�rio
    Private oSayPsw
    Private oGetPsw, cGetPsw  := Space(20) // Vai pegar a senha
    Private oGetConf, cGetConf := Space(20) // Vai pegar a confirma��o da senha
    Private oGetErr, cGetErr  := ""

    //Dimens�es da janela
    Private nJanLarg := 200
    Private nJanAltu := 250
      
    //Criando a janela
    DEFINE MSDIALOG oDlgPvt TITLE "Cadastro" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL

        //Grupo de Cadastro
        @ 003, 001     GROUP oGrpLog TO (nJanAltu/2)-1, (nJanLarg/2)-3         PROMPT "Cadastro de Usu�rio: "     OF oDlgPvt COLOR 0, 16777215 PIXEL

            //Label e Get de Usu�rio
            @ 013, 006   SAY   oSayUsr PROMPT "Usu�rio:"        SIZE 030, 007 OF oDlgPvt                    PIXEL
            @ 020, 006   MSGET oGetUsr VAR    cGetUsr           SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 PIXEL
          
            //Label e Get da Senha
            @ 033, 006   SAY   oSayPsw PROMPT "Senha:"          SIZE 030, 007 OF oDlgPvt                    PIXEL
            @ 040, 006   MSGET oGetPsw VAR    cGetPsw           SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 PIXEL PASSWORD
          
            //Label e Get da Confirma��o da senha
            @ 053, 006   SAY   oSayPsw PROMPT "Confirme:"       SIZE 030, 007 OF oDlgPvt                    PIXEL
            @ 060, 006   MSGET oGetConf VAR    cGetConf         SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 PIXEL PASSWORD
          
            //Get de Log, pois se for Say, n�o da para definir a cor
            @ 080, 006   MSGET oGetErr VAR    cGetErr        SIZE (nJanLarg/2)-12, 007 OF oDlgPvt COLORS 0, 16777215 NO BORDER PIXEL
            oGetErr:lActive := .F.
            oGetErr:setCSS("QLineEdit{color:#FF0000; background-color:#FEFEFE;}")
          
            //Bot�es
            @ (nJanAltu/2)-18, 006 BUTTON oBtnConf PROMPT "Cadastrar"             SIZE (nJanLarg/2)-12, 015 OF oDlgPvt ACTION (fVldUsr()) PIXEL
            oBtnConf:SetCss("QPushButton:pressed { background-color: qlineargradient(x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #dadbde, stop: 1 #f6f7fa); }")
    ACTIVATE MSDIALOG oDlgPvt CENTERED
      
    //Se a rotina foi confirmada e deu certo, atualiza o usu�rio e a senha
    If lRetorno
        cUsrLog     := Alltrim(cGetUsr)
        cPswLog     := Alltrim(cGetPsw)
        cPswConfLog := Alltrim(cGetConf)
    EndIf
      
    RestArea(aArea)
Return lRetorno

// Fun��o de valida��o de usu�rio e senha
Static Function fVldUsr()
    Local cUsrAux   := Alltrim(cGetUsr)
    Local cPswAux   := Alltrim(cGetPsw)
    Local cPswAux2  := Alltrim(cGetConf)
    Local nCount    := 0
    Local nNum      := 0
    Local nSimb     := 0
    Local nUpp      := 0
    Local cCheck    := ""

    // Se o usu�rio atende aos requisitos, ele entra em um novo bloco condicional.
    if len(cUsrAux) > 6
        
        // Se a senha atende aos requisitos, entra em um novo bloco condicional.
        if len(cPswAux) > 6

            // Aqui, ser� verificado se a senha possui a quantidade m�nima de caracteres especiais solicitados.
            for nCount := 1 to len(cPswAux)
                cCheck := asc(substr(cPswAux,nCount))

                // Aqui, vai atribuir ao contador as valida��es.
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

            // Se as valida��es obtiverem menos do que o esperado, a senha n�o � aceita pelo algoritmo.
            if (nNum > 0) .and. (nUpp > 0) .and. (nSimb > 0)

                // Se a confirma��o da senha estiver em branco, � solicitado ao usu�rio que o mesmo confirme-a.
                if cPswAux2 == " "
                    cGetErr := "Confirme a senha!"
                    oGetErr:Refresh()
                
                // Aqui, � validado se ambas as senhas coincidem. Sen�o, � informado ao usu�rio.
                else
                    if cPswAux == cPswAux2
                       lRetorno := .T. 
                    else
                        cGetErr := "Senhas n�o coincidem"
                        oGetErr:Refresh()
                    endif

                endif

            else
                cGetErr := "Senha inv�lida!"
                oGetErr:Refresh()
            endif

        else
            cGetErr := "Senha inv�lida!"
            oGetErr:Refresh()
        endif
        
    // Sen�o atualiza o erro e retorna para a rotina
    Else
        cGetErr := "Usu�rio inv�lido."
        oGetErr:Refresh()
    EndIf
      
    //Se o retorno for v�lido, fecha a janela
    If lRetorno
        MsgInfo("Bem vindo(a)!", "Cadastro efetuado com sucesso!")
        oDlgPvt:End()
    EndIf
Return
