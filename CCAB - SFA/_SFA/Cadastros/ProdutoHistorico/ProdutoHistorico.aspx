﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ProdutoHistorico.aspx.cs" Inherits="_SFA_ProdutoHistorico_ProdutoHistorico" %>
<%@ Register TagPrefix="uc" TagName="DadosPai" Src="~/_SFA/Cadastros/ProdutoHistorico/DadosPai.ascx" %>
<%@ Register TagPrefix="uc" TagName="Filtro" Src="~/_SFA/Cadastros/ProdutoHistorico/Filtro.ascx" %>
<%@ Register TagPrefix="uc" TagName="Resultado" Src="~/_SFA/Cadastros/ProdutoHistorico/Resultado.ascx" %>
<%@ Register TagPrefix="uc" TagName="Formulario" Src="~/_SFA/Cadastros/ProdutoHistorico/Formulario.ascx" %>

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
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="500" align="left" width="100%">
                                        <asp:ImageButton runat="server" id="btVoltar" BackColor="Transparent" ImageAlign="Top" 
                                            ImageUrl="~/imgsCCAB/tbTitulo_btVoltar.gif" AlternateText=".: voltar" />
                                        <asp:ImageButton ID="btView" ImageAlign="AbsMiddle" BackColor="Transparent" ImageUrl="~/imgsCCAB/tbGrid_operacoesVisualizar.gif"
                                            AlternateText=".: visualizar" OnClick="btView_OnClick" runat="server" />
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
                <asp:Panel ID="Panel1" runat="server" Width="750" Style="display: none; background: #FFFFFF; padding: 10px;">
                    <uc:Formulario ID="Formulario1" runat="server" />    
                </asp:Panel>
            </div>
            
        </ContentTemplate>
    </asp:UpdatePanel>
        
</asp:Content>

