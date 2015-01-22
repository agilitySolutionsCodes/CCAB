<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="TrocarSenha.aspx.cs" Inherits="Comum_TrocarSenha" %>
<%@ Register TagPrefix="uc" TagName="DadosPai" Src="~/Comum/TrocarSenha/DadosPai.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            
            <!-- Cabeçalho -->
            <div class="pageSection">
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="tbTitulo_bordaEsquerda">
                            &nbsp;
                        </td>
                        <td class="tbTitulo_BG">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="400" align="left">
                                        &nbsp;</td>
                                    <td width="20" align="right">
                                        <asp:Image ID="Image1" runat="server" Width="18" Height="36" ImageAlign="Top" 
                                            ImageUrl="~/imgsCCAB/tbTitulo_imgMarcador.jpg" />
                                    </td>
                                    <td width="340" class="tbTitulo_NomeTela" align="left">
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
            </div>
            
            <!-- Identificação do Pai --> 
            <%if (MostraDadosPai){%>
            <div>
                <uc:DadosPai ID="DadosPai1" runat="server" />
            </div>
            <%} %>
            
            <!-- Área de Mensagens -->
            <div style="margin-top: 15px;">
                <asp:ValidationSummary EnableClientScript="true" ID="ValidationSummary1" ShowSummary="false"
                    ShowMessageBox="true" ValidationGroup="Form" HeaderText="O formulário contém erros:"
                    runat="server" />
                <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
            </div>
            <!-- Formulário --> 
                      
            <!-- Opções de Interesse -->
            
            <%if(!_successMsg){ %>
                <div style="margin: 20px 0">
                <table width="30%" border="0" cellpadding="0" cellspacing="0" class="tbCadastro_Mestra">
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Nova Senha:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:TextBox ID="txtNovaSenha1" runat="server" AutoPostBack="false" ValidationGroup="Form"
                                Columns="10" MaxLength="255" TextMode="Password" CssClass="campoTexto" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Nova Senha é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="txtNovaSenha1" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Confirmação:
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:TextBox ID="txtNovaSenha2" runat="server" AutoPostBack="false" ValidationGroup="Form"
                                Columns="10" MaxLength="255" TextMode="Password" CssClass="campoTexto" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Confirmação da Senha Atual é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="txtNovaSenha2" />
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Os campos Nova Senha e Confirmação devem ser iguais" 
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="txtNovaSenha2" ControlToCompare="txtNovaSenha1" />
                        </td>
                    </tr>
                </table>
            </div>  
                <div style="text-align: right;">
                    <br />
                    <asp:Button runat="server" ID="btAction" CssClass="button" ValidationGroup="Form"
                        CausesValidation="true" Text="Salvar" OnCommand="btAction_OnClick" />
                </div>
            <%} else { %>
                <div class="tbCadastro_Mestra">
                    <h2 style="color: #808080">Senha alterada com sucesso.</h2>
                </div>   

            <%} %>  
            
            
            
        </ContentTemplate>
    </asp:UpdatePanel>
        
</asp:Content>

