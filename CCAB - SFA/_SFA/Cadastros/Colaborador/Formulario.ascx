<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Formulario.ascx.cs" Inherits="_SFA_Colaborador_Formulario" %>

<!-- Preparação da PopUp Modal que exibirá o Formulário (Permite que o formulário seja arrastado pela tela) -->
<asp:Button runat="server" ID="btShowPanel1" Style="display: none" />
<asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btShowPanel1"
    PopupControlID="Panel1" PopupDragHandleControlID="Panel1DragHandle" BackgroundCssClass="modalBackground" />

<script type="text/javascript" src="../../../scripts/JScript.js"></script>
<script type="text/JavaScript">
   <!--
    function CheckCPF(sender, args) {
        if (!isMod11(args.Value)) {
            alert("O CPF não foi digitado corretamente.");
            return false;
        }
        return true;
    }    
   -->
</script>
   
<!-- Cabeçalho Formulário -->    
<div class="pageSection">
    <asp:Panel runat="Server" ID="Panel1DragHandle" CssClass="drag">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td class="tbTitulo_bordaEsquerda">
                    &nbsp;
                </td>
                <td class="tbTitulo_BG">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td width="250" class="tbTitulo_NomeTela" align="left">
                                <asp:Label runat="server" SkinID="normal" ID="lbOperacao" />
                            </td>
                            <td width="*">
                                <asp:Image ID="Image2" runat="server" Width="18" Height="36" ImageAlign="Right" ImageUrl="~/imgsCCAB/tbTitulo_imgMarcador.jpg" />
                            </td>
                            <td width="265" class="tbTitulo_NomeTela" align="left">
                                <asp:Label ID="lbNomeTela" runat="server" SkinID="normal" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="tbTitulo_bordaDireita">
                    &nbsp;
                </td>
            </tr>
        </table>
    </asp:Panel>
</div>
<!-- Área de Mensagens -->
<div>
    <asp:ValidationSummary EnableClientScript="true" ID="ValidationSummary1" ShowSummary="false"
        ShowMessageBox="true" ValidationGroup="Form" HeaderText="O formulário contém erros:"
        runat="server" />
    <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
</div>
<!-- Formulário -->
<div>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="cdPessoaSEQ" CellPadding="5"
        AutoGenerateRows="false" Width="100%" GridLines="None">
        
        <InsertItemTemplate>
            <div class="pageSection">
            
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbCadastro_Mestra">
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            CPF:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="true" ID="nuCNPJCPFPessoa" runat="server" 
                                Columns="11" MaxLength="11" CssClass="campoTexto" Text='<%# Bind("nuCNPJCPFPessoa") %>' />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator3" runat="server" ErrorMessage="CPF é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="nuCNPJCPFPessoa" />
                            <asp:RegularExpressionValidator Display="None" ID="RegularExpressionValidator2" runat="server" ErrorMessage="O formato de CPF é 99999999999"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="nuCNPJCPFPessoa" ValidationExpression="^\d{11}$" />     
                            <asp:CustomValidator Display="None" ID="CustomValidator2" ClientValidationFunction="CheckCPF"  
                                ControlToValidate="nuCNPJCPFPessoa" EnableClientScript="true" ErrorMessage="O CPF informado é inválido"
                                Text="*" ValidationGroup="Form" ForeColor="#f6f6f6" runat="server" />
                        </td>
                        <td class="fonteTbCadastro">
                        </td>
                        <td class="tdCamposFormularios">
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="fonteTbCadastro">
                            Nome:*
                        </td>
                        <td class="tdCamposFormularios" colspan="4">
                            <conv:TextBox Type="Text" Enabled="true" ID="nmPessoa" runat="server" 
                                Columns="123" MaxLength="70" CssClass="campoTexto" Text='<%# Bind("nmPessoa") %>' />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator4" runat="server" ErrorMessage="Nome é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="nmPessoa" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Perfil:*
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="true" ID="cdIndicadorTipoPerfilPessoa" runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource8" 
                                DataValueField="vrDominioCodigoReferenciado" DataTextField="wkDominioCodigoReferenciado"  />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Perfil é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="cdIndicadorTipoPerfilPessoa" InitialValue="0" />
                        </td>
                        <td class="fonteTbCadastro">
                            E-mail:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="true" ID="enEmailPrincipalPessoa" runat="server" 
                                Columns="40" MaxLength="70" CssClass="campoTexto" Text='<%# Bind("enEmailPrincipalPessoa") %>' />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator14" runat="server" ErrorMessage="Email é campo obrigatório."
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="enEmailPrincipalPessoa" />
                            <asp:RegularExpressionValidator Display="None" ID="RegularExpressionValidator5" runat="server" ErrorMessage="O formato de Email é nome@dominio.com.br"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="enEmailPrincipalPessoa" ValidationExpression="^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$" />
                        </td>
                    </tr>
                    <%-- 
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Nacionalidade:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdNacionalidadePessoa" runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource1" 
                                DataTextField="dsNacionalidadePais" DataValueField="cdPais" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator13" runat="server" ErrorMessage="Nacionalidade é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="cdNacionalidadePessoa" InitialValue="0" />
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            RG/Cédula Estr:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" Enabled="false" ID="nuRGCedulaEstrangeiroPessoa" runat="server" 
                                Columns="30" CssClass="campoTexto" Text='<%# Bind("nuRGCedulaEstrangeiroPessoa") %>' />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Data Nascimento:
                        </td>
                        <td class="tdCamposFormularios">                            
                            <conv:TextBox Type="Date" Enabled="false" ID="dtNascimentoPessoa" runat="server" ValidationGroup="Form" 
                                CssClass="campoTexto" Text='<%# Bind("dtNascimentoPessoa", "{0:dd/MM/yyyy}") %>' />
                            <asp:Label ID="Label1" runat="server" SkinID="data" style="font-size: xx-small; vertical-align: middle" Text="&nbsp;(ddmmaaaa)" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator11" runat="server" ErrorMessage="Data de Nascimento é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="dtNascimentoPessoa" />
                            <asp:CompareValidator Display="None" id="CompareValidator1" runat="server" ControlToValidate="dtNascimentoPessoa" 
                                Operator="DataTypeCheck" Type="Date" ErrorMessage="A data informada não é válida" 
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form" />
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Sexo:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdIndicadorSexoPessoa" runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource9" 
                                DataTextField="wkDominioCodigoReferenciado" DataValueField="vrDominioCodigoReferenciado" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator9" runat="server" ErrorMessage="Sexo é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="cdIndicadorSexoPessoa" InitialValue="0" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Estado Civil:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="false" ID="cdIndicadorEstadoCivilPessoa" runat="server" ValidationGroup="Form"
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource10" 
                                DataTextField="wkDominioCodigoReferenciado" DataValueField="vrDominioCodigoReferenciado" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator10" runat="server" ErrorMessage="Estado Civil é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="cdIndicadorEstadoCivilPessoa" InitialValue="0" />
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Situação:*
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="true" ID="cdIndicadorStatusPessoa" runat="server"   
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataValueField="vrDominioCodigoReferenciado" 
                                DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource5" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator12" runat="server" ErrorMessage="Estado Civil é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="cdIndicadorStatusPessoa" InitialValue="0" />
                        </td>
                    </tr>
                    --%>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Empresa:*
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList Enabled="true" ID="cdEmpresaColaboradorPessoa" runat="server"   
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataValueField="cdPessoaSEQ" Width="350"
                                DataTextField="dsPessoa" DataSourceID="ObjectDataSource11" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator12" runat="server" ErrorMessage="Empresa é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="cdEmpresaColaboradorPessoa" InitialValue="0" />
                        </td>
                        <td valign="middle" class="fonteTbCadastro">
                            Login:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" ID="dsLoginPessoa" runat="server" 
                                Columns="40" MaxLength="40" CssClass="campoTexto" Text='<%# Bind("dsLoginPessoa") %>' />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator5" runat="server" ErrorMessage="Login é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="dsLoginPessoa" />
                        </td>
                    </tr>
                </table>
                 
            </div>
        </InsertItemTemplate>
        
        <EditItemTemplate>
            <div class="pageSection">
                
                <asp:TabContainer ID="TabContainer1" Height="190" runat="server">
                    
                    <asp:TabPanel ID="TabPanel1" runat="server" HeaderText="Cadastro Básico">
                        <ContentTemplate>
                            
                            <table width="100%" border="0" cellpadding="3" cellspacing="0">
                                <tr>
                                    <td class="fonteTbCadastro">
                                        Código:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="cdPessoaERP" runat="server" 
                                            Columns="14" CssClass="campoTexto" Text='<%# Bind("cdPessoaSEQ") %>' />
                                    </td>
                                    <td></td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        CPF:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuCNPJCPFPessoa" runat="server" 
                                            Columns="11" MaxLength="11" CssClass="campoTexto" Text='<%# Bind("nuCNPJCPFPessoa") %>' />
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator3" runat="server" ErrorMessage="CPF é campo obrigatório"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="nuCNPJCPFPessoa" />
                                        <asp:RegularExpressionValidator Display="None" ID="RegularExpressionValidator2" runat="server" ErrorMessage="O formato de CPF é 99999999999"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="nuCNPJCPFPessoa" ValidationExpression="^\d{11}$" />     
                                        <asp:CustomValidator Display="None" ID="CustomValidator2" ClientValidationFunction="CheckCPF"  
                                            ControlToValidate="nuCNPJCPFPessoa" EnableClientScript="true" ErrorMessage="O CPF informado é inválido"
                                            Text="*" ValidationGroup="Form" ForeColor="#f6f6f6" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fonteTbCadastro">
                                        Nome:*
                                    </td>
                                    <td class="tdCamposFormularios" colspan="4">
                                        <conv:TextBox Type="Text" Enabled="true" ID="nmPessoa" runat="server" 
                                            Columns="123" MaxLength="70" CssClass="campoTexto" Text='<%# Bind("nmPessoa") %>' />
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator4" runat="server" ErrorMessage="Nome é campo obrigatório"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="nmPessoa" />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Perfil:*
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList Enabled="true" ID="cdIndicadorTipoPerfilPessoa" runat="server" ValidationGroup="Form"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource8" 
                                            DataValueField="vrDominioCodigoReferenciado" DataTextField="wkDominioCodigoReferenciado"  />
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Perfil é campo obrigatório"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="cdIndicadorTipoPerfilPessoa" InitialValue="0" />
                                    </td>
                                    <td class="fonteTbCadastro">
                                        E-mail:*
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="true" ID="enEmailPrincipalPessoa" runat="server" 
                                            Columns="40" MaxLength="70" CssClass="campoTexto" Text='<%# Bind("enEmailPrincipalPessoa") %>' />
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator14" runat="server" ErrorMessage="Email é campo obrigatório."
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="enEmailPrincipalPessoa" />
                                        <asp:RegularExpressionValidator Display="None" ID="RegularExpressionValidator5" runat="server" ErrorMessage="O formato de Email é nome@dominio.com.br"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="enEmailPrincipalPessoa" ValidationExpression="^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$" />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Empresa:*
                                    </td>
                                    <td class="tdCamposFormularios" colspan="4">
                                        <asp:DropDownList Enabled="true" ID="cdEmpresaColaboradorPessoa" runat="server"   
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataValueField="cdPessoaSEQ" Width="350"
                                            DataTextField="dsPessoa" DataSourceID="ObjectDataSource11" />
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator15" runat="server" ErrorMessage="Empresa é campo obrigatório"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="cdEmpresaColaboradorPessoa" InitialValue="0" />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Nacionalidade:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList Enabled="false" ID="cdNacionalidadePessoa" runat="server" ValidationGroup="Form"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource1" 
                                            DataTextField="dsNacionalidadePais" DataValueField="cdPais" />
                                    </td>
                                    <td>
                                        <%-- <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator13" runat="server" ErrorMessage="Nacionalidade é campo obrigatório"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="cdNacionalidadePessoa" InitialValue="0" /> --%>
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        RG/Cédula Estr:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuRGCedulaEstrangeiroPessoa" runat="server" 
                                            Columns="30" CssClass="campoTexto" Text='<%# Bind("nuRGCedulaEstrangeiroPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Data Nascimento:
                                    </td>
                                    <td class="tdCamposFormularios">                            
                                        <conv:TextBox Type="Date" Enabled="false" ID="dtNascimentoPessoa" runat="server" ValidationGroup="Form" 
                                            CssClass="campoTexto" Text='<%# Bind("dtNascimentoPessoa", "{0:dd/MM/yyyy}") %>' />
                                        <asp:Label ID="Label1" runat="server" SkinID="data" style="font-size: xx-small; vertical-align: middle" Text="&nbsp;(ddmmaaaa)" />
                                    </td>
                                    <td>
                                       <%-- <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator11" runat="server" ErrorMessage="Data de Nascimento é campo obrigatório"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="dtNascimentoPessoa" />
                                        <asp:CompareValidator Display="None" id="CompareValidator1" runat="server" ControlToValidate="dtNascimentoPessoa" 
                                            Operator="DataTypeCheck" Type="Date" ErrorMessage="A data informada não é válida" 
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form" /> --%>
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Sexo:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList Enabled="false" ID="cdIndicadorSexoPessoa" runat="server" ValidationGroup="Form"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource9" 
                                            DataTextField="wkDominioCodigoReferenciado" DataValueField="vrDominioCodigoReferenciado" />
                                    </td>
                                    <td>
                                        <%-- <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator9" runat="server" ErrorMessage="Sexo é campo obrigatório"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="cdIndicadorSexoPessoa" InitialValue="0" /> --%>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Estado Civil:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList Enabled="false" ID="cdIndicadorEstadoCivilPessoa" runat="server" ValidationGroup="Form"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource10" 
                                            DataTextField="wkDominioCodigoReferenciado" DataValueField="vrDominioCodigoReferenciado" />
                                    </td>
                                    <td>
                                        <%-- <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator10" runat="server" ErrorMessage="Estado Civil é campo obrigatório"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="cdIndicadorEstadoCivilPessoa" InitialValue="0" /> --%>
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Situação:*
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList Enabled="true" ID="cdIndicadorStatusPessoa" runat="server"   
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataValueField="vrDominioCodigoReferenciado" 
                                            DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource5" />
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator12" runat="server" ErrorMessage="Estado Civil é campo obrigatório"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="cdIndicadorStatusPessoa" InitialValue="0" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:TabPanel>
                    
                    <asp:TabPanel ID="TabPanel2" runat="server" HeaderText="Endereços">
                        <ContentTemplate>
                            <table width="100%" border="0" cellpadding="3" cellspacing="0">
                                <tr>
                                    <td colspan="6">
                                        <h5 style="text-align: left; color: Gray; margin: 0 0 0 0">
                                            Endereço Principal</h5>
                                        <hr style="color: Green; height: 1px;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle" class="fonteTbCadastro">
                                        País:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList Enabled="false" ID="cdPaisEnderecoPrincipalPessoa" runat="server"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource1"
                                            DataTextField="nmPais" DataValueField="cdPais" />
                                    </td>
                                    <td class="fonteTbCadastro">
                                        Logradouro:
                                    </td>
                                    <td class="tdCamposFormularios" colspan="3">
                                        <conv:TextBox Type="Text" Enabled="false" ID="enLogradouroEnderecoPrincipalPessoa"
                                            runat="server" ValidationGroup="Form" Columns="100" CssClass="campoTexto" Text='<%# Bind("enLogradouroEnderecoPrincipalPessoa") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fonteTbCadastro">
                                        Bairro:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="enBairroEnderecoPrincipalPessoa" runat="server"
                                            Columns="25" CssClass="campoTexto" Text='<%# Bind("enBairroEnderecoPrincipalPessoa") %>' />
                                    </td>
                                    <td class="fonteTbCadastro">
                                        Município:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="enMunicipioEnderecoPrincipalPessoa"
                                            runat="server" Columns="40" CssClass="campoTexto" Text='<%# Bind("enMunicipioEnderecoPrincipalPessoa") %>' />
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Estado:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList Enabled="false" ID="cdSiglaEstadoEnderecoPrincipalPessoa" runat="server"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource6"
                                            DataTextField="cdSiglaEstado" DataValueField="cdSiglaEstado" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fonteTbCadastro">
                                        CEP:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Enabled="false" ID="nuCepEnderecoPrincipalPessoa" runat="server" ValidationGroup="Form"
                                            Columns="7" CssClass="campoTexto" Text='<%# Bind("nuCepEnderecoPrincipalPessoa") %>' />
                                    </td>
                                    <td class="fonteTbCadastro">
                                        Referência:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="enReferenciaEnderecoPrincipalPessoa"
                                            runat="server" Columns="40" CssClass="campoTexto" Text='<%# Bind("enReferenciaEnderecoPrincipalPessoa") %>' />
                                    </td>
                                    <td class="fonteTbCadastro">
                                        Caixa Postal:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuCaixaPostalEnderecoPrincipalPessoa"
                                            runat="server" Columns="15" CssClass="campoTexto" Text='<%# Bind("nuCaixaPostalEnderecoPrincipalPessoa") %>' />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:TabPanel>
                    
                    <asp:TabPanel ID="TabPanel3" runat="server" HeaderText="Telefones">
                        <ContentTemplate>
                            <table width="100%" border="0" cellpadding="3" cellspacing="0">
                                <tr>
                                    <td colspan="9">
                                        <h5 style="text-align: left; color: Gray; margin:  0 0 0 0">Telefone Principal</h5>
                                        <hr style="color: Green; height: 1px;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle" class="fonteTbCadastro">
                                        DDI:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList Enabled="false" ID="cdPaisTelefonePrincipalPessoa" runat="server" 
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource7" 
                                            DataTextField="dsDDI" DataValueField="cdPais" />
                                    </td>
                                    <td>
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        DDD:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuDDDTelefonePrincipalPessoa" runat="server" 
                                            Columns="2" CssClass="campoTexto" Text='<%# Bind("nuDDDTelefonePrincipalPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Telefone:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuTelefonePrincipalPessoa" runat="server" 
                                            Columns="10" CssClass="campoTexto" Text='<%# Bind("nuTelefonePrincipalPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="9">
                                        <h5 style="text-align: left; color: Gray; margin:  0 0 0 0">FAX</h5>
                                        <hr style="color: Green; height: 1px;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle" class="fonteTbCadastro">
                                        DDI:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList Enabled="false" ID="cdPaisTelefoneFAXPessoa" runat="server" 
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource7" 
                                            DataTextField="dsDDI" DataValueField="cdPais" />
                                    </td>
                                    <td>
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        DDD:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuDDDTelefoneFAXPessoa" runat="server" 
                                            Columns="2" CssClass="campoTexto" Text='<%# Bind("nuDDDTelefoneFAXPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Telefone:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuTelefoneFAXPessoa" runat="server" 
                                            Columns="10" CssClass="campoTexto" Text='<%# Bind("nuTelefoneFAXPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                </tr> 
                                <tr>
                                    <td colspan="9">
                                        <h5 style="text-align: left; color: Gray; margin:  0 0 0 0">Celular</h5>
                                        <hr style="color: Green; height: 1px;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle" class="fonteTbCadastro">
                                        DDI:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList Enabled="false" ID="cdPaisTelefoneCelularPessoa" runat="server" 
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource7" 
                                            DataTextField="dsDDI" DataValueField="cdPais" />
                                    </td>
                                    <td>
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        DDD:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuDDDTelefoneCelularPessoa" runat="server" 
                                            Columns="2" CssClass="campoTexto" Text='<%# Bind("nuDDDTelefoneCelularPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Telefone:
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <conv:TextBox Type="Text" Enabled="false" ID="nuTelefoneCelularPessoa" runat="server" 
                                            Columns="10" CssClass="campoTexto" Text='<%# Bind("nuTelefoneCelularPessoa") %>' />
                                    </td>
                                    <td>
                                    </td>
                                </tr>   
                            </table>
                        </ContentTemplate>
                    </asp:TabPanel>
                    
                    <asp:TabPanel ID="TabPanel4" runat="server" HeaderText="Segurança de Acesso">
                        <ContentTemplate>
                            <asp:HiddenField ID="cdPessoaSEQ" runat="server" Value='<%# Bind("cdPessoaSEQ") %>' />
                            <table width="100%" border="0" cellpadding="3" cellspacing="0">
                                <tr>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Login:*
                                    </td>
                                    <td class="tdCamposFormularios" colspan="4">
                                        <conv:TextBox Type="Text" ID="dsLoginPessoa" runat="server" 
                                            Columns="40" MaxLength="40" CssClass="campoTexto" Text='<%# Bind("dsLoginPessoa") %>' />
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator5" runat="server" ErrorMessage="Login é campo obrigatório"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="dsLoginPessoa" />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Tipo de Acesso:*
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList ID="cdIndicadorTipoAcessoPessoa" runat="server" ValidationGroup="Form"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource2" 
                                            DataTextField="wkDominioCodigoReferenciado" DataValueField="vrDominioCodigoReferenciado" />
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator6" runat="server" ErrorMessage="Tipo de Acesso deve ser informado"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="cdIndicadorTipoAcessoPessoa" InitialValue="0" />
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Primeiro Acesso:*
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList ID="cdIndicadorPrimeiroAcessoPessoa" runat="server" ValidationGroup="Form"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource3" 
                                            DataTextField="wkDominioCodigoReferenciado" DataValueField="vrDominioCodigoReferenciado" />
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator7" runat="server" ErrorMessage="Deve ser informado se é Primeiro Acesso ou não"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="cdIndicadorPrimeiroAcessoPessoa" InitialValue="0" />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Senha Bloqueada:*
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList ID="cdIndicadorSenhaBloqueadaPessoa" runat="server" ValidationGroup="Form"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource3" 
                                            DataTextField="wkDominioCodigoReferenciado" DataValueField="vrDominioCodigoReferenciado" />
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator8" runat="server" ErrorMessage="Deve ser informado se a Senha está bloqueada ou não"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="cdIndicadorSenhaBloqueadaPessoa" InitialValue="0" />
                                    </td>
                                    <td valign="middle" class="fonteTbCadastro">
                                        Grupo Acesso:*
                                    </td>
                                    <td class="tdCamposFormularios">
                                        <asp:DropDownList ID="cdGrupoAcessoSEQ" runat="server" ValidationGroup="Form"
                                            CssClass="campoTexto" OnPreRender="ConfigCombo" DataSourceID="ObjectDataSource4" 
                                            DataTextField="dsGrupoAcesso" DataValueField="cdGrupoAcessoSEQ" />
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator2" runat="server" ErrorMessage="O Grupo de Acesso não foi informado"
                                            Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                            ControlToValidate="cdGrupoAcessoSEQ" InitialValue="0" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:TabPanel>
                    
                </asp:TabContainer>
            
            </div>
             
        </EditItemTemplate>          
    </asp:FormView>
    
    <div style="text-align: right;">
        <asp:Button runat="server" ID="btAction" CssClass="button" ValidationGroup="Form"
            CausesValidation="true" OnCommand="btAction_OnClick" />
        <asp:Button runat="server" ID="btCancel" CommandName="Cancel" CssClass="button" Text="cancelar" 
            CausesValidation="false" OnCommand="btCancel_OnClick" />
    </div>

</div>    

<div style="display:none">
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="ObterListaNacionalidade" TypeName="Pais">
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORTIPOACESSO" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORSIMNAO" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" SelectMethod="ObterLista" TypeName="GrupoAcesso">
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORATIVOINATIVO" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource6" runat="server" SelectMethod="ObterLista" TypeName="Estado">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="cdPais" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource7" runat="server" SelectMethod="ObterListaDDI" TypeName="Pais">
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource8" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORTIPOPERFILCOLABORADOR" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>  
    <asp:ObjectDataSource ID="ObjectDataSource9" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORSEXO" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource> 
    <asp:ObjectDataSource ID="ObjectDataSource10" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORESTADOCIVIL" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource11" runat="server" SelectMethod="ObterListaOnDemandERP" TypeName="Pessoa">
        <SelectParameters>
            <asp:Parameter Name="cdIndicadorTipoPerfilPessoa" DefaultValue="3" Type="Int32" />
            <asp:SessionParameter SessionField="cdUsuario" Name="cdUsuarioUltimaAlteracao" Type="Int64" />
            <asp:Parameter Name="cdIndicadorTipoAgenteComercialPessoa" DefaultValue="0" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource> 
</div>


