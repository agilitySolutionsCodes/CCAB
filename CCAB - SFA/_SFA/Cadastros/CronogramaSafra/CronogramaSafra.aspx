<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CronogramaSafra.aspx.cs" Inherits="_SFA_CronogramaSafra_CronogramaSafra" %>
<%@ Register TagPrefix="uc" TagName="DadosPai" Src="~/_SFA/Cadastros/CronogramaSafra/DadosPai.ascx" %>
<%@ Register TagPrefix="uc" TagName="Filtro" Src="~/_SFA/Cadastros/CronogramaSafra/Filtro.ascx" %>
<%@ Register TagPrefix="uc" TagName="Resultado" Src="~/_SFA/Cadastros/CronogramaSafra/Resultado.ascx" %>
<%@ Register TagPrefix="uc" TagName="Formulario" Src="~/_SFA/Cadastros/CronogramaSafra/Formulario.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function Confirmacao(nome)
        {
            return confirm("Deseja realmente excluir o registro\n\n[" + nome + "]?");
        }
    </script>

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
                                        <asp:ImageButton ID="btIncluir" ImageAlign="AbsMiddle" BackColor="Transparent" ImageUrl="~/imgsCCAB/tbTitulo_btIncluir.gif"
                                            AlternateText=".: incluir" runat="server" OnClick="btIncluir_OnClick" />
                                        <asp:ImageButton ID="btView" ImageAlign="AbsMiddle" BackColor="Transparent" ImageUrl="~/imgsCCAB/tbGrid_operacoesVisualizar.gif"
                                            AlternateText=".: visualizar" OnClick="btView_OnClick" runat="server" />
                                        <asp:ImageButton ID="btEdit" ImageAlign="AbsMiddle" BackColor="Transparent" ImageUrl="~/imgsCCAB/tbGrid_operacoesAlterar.gif"
                                            AlternateText=".: alterar" OnClick="btEdit_OnClick" runat="server" />
                                        <asp:ImageButton ID="btDelete" ImageAlign="AbsMiddle" BackColor="Transparent" ImageUrl="~/imgsCCAB/tbGrid_operacoesExcluir.gif"
                                            Enabled="false" AlternateText=".: excluir" OnClick="btDelete_OnClick" runat="server" />
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                            
                            
                            

                                        <asp:ImageButton    ID="btCooperativa" ImageAlign="AbsMiddle" BackColor="Transparent" 
                                                            ImageUrl="~/imgsCCAB/tbTitulo_btCP.gif" 
                                                            OnClick="btCooperativa_OnClick" AlternateText=".: Cooperativas" runat="server" />

                            
                                        <asp:ImageButton    ID="btHistorico" ImageAlign="AbsMiddle" BackColor="Transparent" 
                                                            ImageUrl="~/imgsCCAB/tbTitulo_btHistorico.gif" 
                                                            OnClick="btVencimento_OnClick" AlternateText=".: Vencimentos" runat="server" />
                                            
                                        <asp:ImageButton    ID="imageButtonPrincipioAtivo" ImageAlign="AbsMiddle" 
                                                            BackColor="Transparent" ImageUrl="~/imgsCCAB/tbTitulo_btPrincipioAtivo.gif" 
                                                            AlternateText=".: Regras Pricipio Ativo" runat="server" 
                                                            onclick="imageButtonPrincipioAtivo_Click" />
                                        
                                        <asp:ImageButton    ID="imageButtonContaOrdem" ImageAlign="AbsMiddle" 
                                                            BackColor="Transparent" ImageUrl="~/imgsCCAB/tbTitulo_btContaOrdem.gif" 
                                                            AlternateText=".: Conta Ordem" runat="server" 
                                                            onclick="imageButtonContaOrdem_Click" />
                                                            
                                        <asp:ImageButton    ID="imageButton1" ImageAlign="AbsMiddle" 
                                                            BackColor="Transparent" ImageUrl="~/imgsCCAB/tbTitulo_btOrigemFaturamento.gif" 
                                                            AlternateText=".: Origem Faturamento" runat="server" 
                                                            onclick="imageButtonOrigemFaturamento_Click" />

                                        <asp:ImageButton    ID="imageButton2" ImageAlign="AbsMiddle" 
                                                            BackColor="Transparent" ImageUrl="~/imgsCCAB/tbTitulo_btCessaoCredito.gif" 
                                                            AlternateText=".: Cessão de Crédito" runat="server" 
                                                            onclick="imageButtonCessaoCredito_Click" />
                                        
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
                <asp:Panel ID="Panel1" runat="server" Width="850" Style="display: none; background: #FFFFFF; padding: 10px;">
                    <uc:Formulario ID="Formulario1" runat="server" />    
                </asp:Panel>
            </div>
            
        </ContentTemplate>
    </asp:UpdatePanel>
        
</asp:Content>

