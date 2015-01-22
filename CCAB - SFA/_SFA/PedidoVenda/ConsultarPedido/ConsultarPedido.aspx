<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ConsultarPedido.aspx.cs" Inherits="_SFA_PedidoVenda_ConsultarPedido" %>
<%@ Register TagPrefix="uc" TagName="Filtro" Src="~/_SFA/PedidoVenda/ConsultarPedido/Filtro.ascx" %>
<%@ Register TagPrefix="uc" TagName="Resultado" Src="~/_SFA/PedidoVenda/ConsultarPedido/Resultado.ascx" %>
<%@ Register TagPrefix="uc" TagName="Formulario" Src="~/_SFA/PedidoVenda/ConsultarPedido/Formulario.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  
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
                                &nbsp;
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
    
    <%if (!Convert.ToBoolean(Session["ShowMessage"]))
    {%> 
    
    <!-- Filtro -->
    <div class="pageSection">
        <uc:Filtro ID="Filtro1" runat="server" />
    </div>
    
    <!-- Área de Mensagens -->
    <div>
        <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
    </div>
    
    <!-- Grid Resultado -->
    <div>
        <uc:Resultado ID="Resultado1" runat="server" />
    </div>
    
    <!-- Formulário de Edição -->
    <div>
        <asp:Panel ID="Panel1" runat="server" Width="70%" Style="display: none; background: #FFFFFF; padding: 10px;">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="false" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Panel ID="Panel2" runat="server" Width="100%" ScrollBars="Auto" style="padding: 5px" Height="550">
                        <uc:Formulario ID="Formulario1" runat="server" />
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel> 
        </asp:Panel>
    </div>
            
    <%}
    else
    {%> 
    <div class="tbCadastro_Mestra">
        <h2 style="color: #808080">
            Lista Impressa com sucesso.<br />
        </h2>
        <br />
        <asp:Button runat="server" ID="btLiberarPedido" CssClass="button" Text="consultar pedido" 
            CausesValidation="false" Width="170" OnClick="btLiberarPedido_Click" />
    </div>  
    <%} %>  
    
</asp:Content>

