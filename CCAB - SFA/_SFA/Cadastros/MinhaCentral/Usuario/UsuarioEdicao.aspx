<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UsuarioEdicao.aspx.cs" Inherits="_SFA_Cadastros_MinhaCentral_Usuario_UsuarioEdicao" %>
<%@ Register TagPrefix="uc" TagName="Formulario" Src="~/_SFA/Cadastros/MinhaCentral/Usuario/Formulario.ascx" %>

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
                                    <td width="500" align="left">
                                    </td>
                                    <td width="20" align="right">
                                        <asp:Image ID="Image1" runat="server" Width="18" Height="36" ImageAlign="Top" 
                                            ImageUrl="~/imgsCCAB/tbTitulo_imgMarcador.jpg" />
                                    </td>
                                    <td width="240" class="tbTitulo_NomeTela" align="left">
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

            <!-- Área de Mensagens -->
            <div>
                <%-- <asp:ValidationSummary EnableClientScript="true" ID="ValidationSummary1" ShowSummary="false"
                    ShowMessageBox="true" ValidationGroup="Form" HeaderText="O formulário contém erros:"
                    runat="server" />--%>
                <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
            </div>
            
            <!-- Formulário de Edição -->
            <div>
                <asp:Panel ID="Panel1" Width="85%" runat="server">
                    <uc:Formulario ID="Formulario1" runat="server" />    
                </asp:Panel>
            </div>
            
        </ContentTemplate>
    </asp:UpdatePanel>
        
</asp:Content>

