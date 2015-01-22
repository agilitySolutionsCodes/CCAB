<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Cliente.aspx.cs" Inherits="_SFA_Cliente_Cliente" %>
<%@ Register TagPrefix="uc" TagName="DadosPai" Src="~/_SFA/Cadastros/Cliente/DadosPai.ascx" %>
<%@ Register TagPrefix="uc" TagName="Filtro" Src="~/_SFA/Cadastros/Cliente/Filtro.ascx" %>
<%@ Register TagPrefix="uc" TagName="Resultado" Src="~/_SFA/Cadastros/Cliente/Resultado.ascx" %>
<%@ Register TagPrefix="uc" TagName="Formulario" Src="~/_SFA/Cadastros/Cliente/Formulario.ascx" %>

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
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td width="500" align="left">
                                        <asp:ImageButton ID="btView" ImageAlign="AbsMiddle" BackColor="Transparent" ImageUrl="~/imgsCCAB/tbTitulo_btVisualizar.gif"
                                            AlternateText=".: visualizar" OnClick="btView_OnClick" runat="server" />
                                        <asp:ImageButton ID="btEdit" ImageAlign="AbsMiddle" BackColor="Transparent" ImageUrl="~/imgsCCAB/tbTitulo_btEditar.gif"
                                            AlternateText=".: alterar" OnClick="btEdit_OnClick" runat="server" />&nbsp;&nbsp;&nbsp;&nbsp;
                                        <%-- <asp:ImageButton ID="btHistorico" ImageAlign="AbsMiddle" BackColor="Transparent" 
                                            ImageUrl="~/imgsCCAB/tbTitulo_btHistorico.gif" OnClick="btHistorico_OnClick" AlternateText=".: histórico" runat="server" /> --%>
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
            
            <!-- Identificação do Pai --> 
            <%if (MostraDadosPai){%>
            <div>
                <uc:DadosPai ID="DadosPai1" runat="server" />
            </div>
            <%} %>
            
            <!-- Filtro -->
            <div class="pageSection">
                <uc:Filtro ID="Filtro1" runat="server" />
            </div>
            
            <!-- Área de Mensagens -->
            <div>
                <%-- <asp:ValidationSummary EnableClientScript="true" ID="ValidationSummary1" ShowSummary="false"
                    ShowMessageBox="true" ValidationGroup="Form" HeaderText="O formulário contém erros:"
                    runat="server" />--%>
                <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
            </div>
 
            <!-- Grid Resultado -->
            <div>
                <uc:Resultado ID="Resultado1" runat="server" />
            </div>
            
            <!-- Formulário de Edição -->
            <div>
                <asp:Panel ID="Panel1" runat="server" Width="890" Style="display: none; background: #FFFFFF; padding: 10px;">
                    <uc:Formulario ID="Formulario1" runat="server" />    
                </asp:Panel>
            </div>
            
        </ContentTemplate>
    </asp:UpdatePanel>
        
</asp:Content>

