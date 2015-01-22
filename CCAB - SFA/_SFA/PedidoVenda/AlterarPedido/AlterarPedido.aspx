<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AlterarPedido.aspx.cs" Inherits="_SFA_PedidoVenda_AlterarPedido" %>
<%@ Register TagPrefix="uc" TagName="Passo1" Src="~/_SFA/PedidoVenda/AlterarPedido/Passo1.ascx" %>
<%@ Register TagPrefix="uc" TagName="Passo2Header" Src="~/_SFA/PedidoVenda/AlterarPedido/Passo2Header.ascx" %>
<%@ Register TagPrefix="uc" TagName="Passo2" Src="~/_SFA/PedidoVenda/AlterarPedido/Passo2.ascx" %>
<%@ Register TagPrefix="uc" TagName="Passo3Header" Src="~/_SFA/PedidoVenda/AlterarPedido/Passo3Header.ascx" %>
<%@ Register TagPrefix="uc" TagName="Passo3" Src="~/_SFA/PedidoVenda/AlterarPedido/Passo3.ascx" %>
<%@ Register TagPrefix="uc" TagName="Passo4" Src="~/_SFA/PedidoVenda/AlterarPedido/Passo4.ascx" %>
<%@ Register TagPrefix="uc" TagName="Passo5" Src="~/_SFA/PedidoVenda/AlterarPedido/Passo5.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="javascript" type="text/javascript">
        function ExibirRelatorioPedidoVenda(pCdPedidoVendaSEQ)
        {
            window.open("./../../Relatorios/PedidoVenda.aspx?cdPedidoVendaSEQ=" + pCdPedidoVendaSEQ, "PedidoVenda", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=700,height=500,left=100,top=50");
	        return true;
        }
    </script>
    <script language="javascript" type="text/javascript" src="../../../scripts/ajax.js"></script>
    <script language="javascript" type="text/javascript" src="../../../scripts/keepalive.js"></script>
          
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
    
    <!-- Área de Mensagens -->
    <div style="height: 25px;">
        <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
    </div>
    
    <!-- Grid Resultado -->
    <div>
        <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
            
            <asp:View ID="View1" runat="server">
                <p style="text-align: center">Passo 1: Escolha do Cliente</p>
                <div style="margin: 0; text-align: left">
                    <uc:Passo1 ID="Passo1" runat="server" />    
                </div>
                <div style="text-align: right;">             
                    <asp:Button runat="server" ID="btPasso1Avancar" CssClass="button" ValidationGroup="Form"
                        Text="Avançar" CausesValidation="true" OnClick="btPasso1Avancar_OnClick" />
                    <asp:Button runat="server" ID="btPasso1Cancelar" CssClass="button" Text="cancelar" 
                        CausesValidation="false" OnClick="btCancelar_OnClick" />
                </div> 
            </asp:View>
            
            <asp:View ID="View2" runat="server">
                <p style="text-align: center">Passo 2: Escolha dos Produtos</p>
                <div style="margin: 0 0 20px 0; text-align: left">
                    <uc:Passo2Header ID="Passo2Header1" runat="server" />
                </div>
                <div style="margin: 0 0 20px 0; text-align: left">
                    <uc:Passo2 ID="Passo2" runat="server" /> 
                </div>
                <div style="text-align: right;">
                    <asp:Button runat="server" ID="btPasso2Retornar" CssClass="button" ValidationGroup="Form"
                        Text="Retornar" CausesValidation="false" OnClick="btPasso2Retornar_OnClick" />
                    <asp:Button runat="server" ID="btPasso2Avancar" CssClass="button" 
                        ValidationGroup="Form" Text="Avançar" CausesValidation="true" 
                        OnClientClick="return compararColunas()" OnCommand="btPasso2Avancar_OnClick" />
                    <asp:Button runat="server" ID="btPasso2Cancelar" CssClass="button" Text="cancelar" 
                        CausesValidation="false" OnCommand="btCancelar_OnClick" />
                </div>
            </asp:View>
            
            <asp:View ID="View3" runat="server">
                <p style="text-align: center">Passo 3: Resumo</p>
                <div style="margin: 0 0 20px 0; text-align: left">
                    <uc:Passo3Header ID="Passo3Header1" runat="server" />
                </div>
                <div style="margin: 0 0 20px 0; text-align: left">
                    <uc:Passo3 ID="Passo3" runat="server" /> 
                </div>
                <div style="text-align: right;">
                    <asp:Button runat="server" ID="btPasso3Retornar" CssClass="button" ValidationGroup="Form"
                        Text="Retornar" CausesValidation="false" OnClick="btPasso3Retornar_OnClick" />
                    <asp:Button runat="server" ID="btPasso3Avancar" CssClass="button" ValidationGroup="Form"
                        Text="Avançar" CausesValidation="true" OnCommand="btPasso3Avancar_OnClick" />
                    <asp:Button runat="server" ID="btPasso3Cancelar" CssClass="button" Text="cancelar" 
                        CausesValidation="false" OnCommand="btCancelar_OnClick" />
                </div>
            </asp:View>
            
            <asp:View ID="View4" runat="server">
                <p style="text-align: center">Passo 4: Planejamento Entrega</p>
                <p style="text-align: center"> <br />
                   </p>
                <div style="margin: 0 0 20px 0; text-align: left">
                    <uc:Passo2Header ID="Passo2Header2" runat="server" />
                </div>
                <div style="margin: 0 0 20px 0; text-align: left">
                    <uc:Passo4 ID="Passo4" runat="server" /> 
                </div>
                <div style="text-align: right;">
                    <asp:Button runat="server" ID="btPasso4Retornar" CssClass="button" ValidationGroup="Form"
                        Text="Retornar" CausesValidation="false" OnClick="btPasso4Retornar_OnClick" />
                    <asp:Button runat="server" ID="btPasso4Avancar" CssClass="button" 
                        ValidationGroup="Form" Text="Avançar" CausesValidation="true" 
                        OnClientClick="return compararColunas()" OnCommand="btPasso4Avancar_OnClick" />
                    <asp:Button runat="server" ID="btPasso4Cancelar" CssClass="button" Text="cancelar" 
                        CausesValidation="false" OnCommand="btCancelar_OnClick" />
                </div>
            </asp:View>
            
            <asp:View ID="View5" runat="server">
                <p style="text-align: center">Passo 5: Distribuição Cultura</p>
                <p style="text-align: center">Este passo é simplesmente para controle estatístico do CCAB, não sendo obrigatório o seu preenchimento.</p>
                <div style="margin: 0 0 20px 0; text-align: left">
                    <uc:Passo2Header ID="Passo2Header3" runat="server" />
                </div>
                <div style="margin: 0 0 20px 0; text-align: left">
                    <uc:Passo5 ID="Passo5" runat="server" /> 
                </div>
                <div style="text-align: right;">
                    <asp:Button runat="server" ID="btPasso5Retornar" CssClass="button" ValidationGroup="Form"
                        Text="Retornar" CausesValidation="false" OnClick="btPasso5Retornar_OnClick" />
                    <asp:Button runat="server" ID="btPasso5Salvar" CssClass="button" 
                        ValidationGroup="Form" Text="Salvar" CausesValidation="true" 
                        OnClientClick="return compararColunas()" OnCommand="btPasso5Salvar_OnClick" />
                    <asp:Button runat="server" ID="btCancelar" CssClass="button" Text="cancelar" 
                        CausesValidation="false" OnCommand="btCancelar_OnClick" />
                </div>
            </asp:View>
            
            <asp:View ID="View6" runat="server">
                <p style="text-align: center">Passo 6: Imprimir</p>
                <div class="tbCadastro_Mestra">
                    <h2 style="color: #808080">
                        Pedido Nº <%= numPedido %> alterado com sucesso.
                    </h2>
                    <br /><br />
                    <asp:Button runat="server" ID="btAlterarPedido" CssClass="button" Text="pedidos" 
                        CausesValidation="false" OnCommand="btAlterarPedido_OnClick" />&nbsp;&nbsp;
                    <asp:Button runat="server" ID="btImprimir" CssClass="button" Text="imprimir" 
                        CausesValidation="false" />
                </div> 
            </asp:View>
            
        </asp:MultiView>
    </div>
        
</asp:Content>

