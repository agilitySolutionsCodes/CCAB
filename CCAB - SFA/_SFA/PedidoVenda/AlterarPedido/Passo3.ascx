<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Passo3.ascx.cs" Inherits="_SFA_PedidoVenda_AlterarPedido_Passo3" %>
<%@ Register Assembly="FarPoint.Web.Spread" Namespace="FarPoint.Web.Spread" TagPrefix="FarPoint" %>

<!-- Área de Mensagens (Desabilitada - display: none - por não estar sendo utilizada) -->
<div style="display: none; margin-bottom: 15px;">
    <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
</div>

<div id="spreadDiv">
    <FarPoint:FpSpread ID="FpSpread1" runat="server" ActiveSheetViewIndex="0" 
        Visible="false">
        <Sheets>
            <FarPoint:SheetView SheetName="Sheet1" /> 
        </Sheets>
        <Pager />

    </FarPoint:FpSpread>
</div>

<div style="text-align: right; margin-top: 15px;" class="fonteTbCadastro">
    <fieldset style="vertical-align: top; width: 290px; padding: 3px;">
        Valor Total em <%= _moeda %> &nbsp; 
        <conv:TextBox Type="Numeric" DecimalPlaces="2" ID="valorTotal" 
            Width="120" ReadOnly="true" runat="server" Text="0,00" 
            CssClass="campoTexto" />&nbsp;
    </fieldset>
</div>
