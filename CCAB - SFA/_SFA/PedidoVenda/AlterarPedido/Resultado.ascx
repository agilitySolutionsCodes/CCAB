<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_PedidoVenda_AlterarPedido_Resultado" %>

<asp:GridView ID="GridView1" DataKeyNames="cdPedidoVendaSEQ" runat="server" OnRowDataBound="RowDataBound"  
    OnPageIndexChanging="GridView_PageIndexChanging" OnSorting="GridView_Sorting">
    <Columns>
        <asp:TemplateField HeaderText="Nº Pedido">
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" Text='<%# Bind("cdPedidoVendaSEQ") %>' 
                OnClick="GridView_OnClick" CommandArgument='<%# Bind("cdPedidoVendaSEQ") %>' />
            </ItemTemplate>
            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Right" />
        </asp:TemplateField>
        <asp:BoundField DataField="dtDigitacaoPedidoVenda" HeaderText="Data Digitação" DataFormatString="{0:dd/MM/yyyy}" SortExpression="dtDigitacaoPedidoVenda" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top"/>
            <HeaderStyle HorizontalAlign="Center"/>
        </asp:BoundField>
        <asp:BoundField DataField="dtEmissaoPedidoVenda" HeaderText="Data Emissão" DataFormatString="{0:dd/MM/yyyy}" SortExpression="dtEmissaoPedidoVenda" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top"/>
            <HeaderStyle HorizontalAlign="Center"/>
        </asp:BoundField>
        <asp:BoundField DataField="dsAgenteComercialCooperativaPedidoVenda" HeaderText="Agente" SortExpression="dsAgenteComercialCooperativaPedidoVenda">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="dsPessoaOrigemFaturamento" HeaderText="Origem Faturamento" SortExpression="dsPessoaOrigemFaturamento">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="dsClienteFaturamentoPedidoVenda" HeaderText="Cliente" SortExpression="dsClienteFaturamentoPedidoVenda">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="dsClienteEntregaPedidoVenda" HeaderText="Local Entrega" SortExpression="dsClienteEntregaPedidoVenda">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="dsIndicadorMoedaPedidoVenda" HeaderText="Moeda" SortExpression="dsIndicadorMoedaPedidoVenda">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="vrTotalMoedaPedidoVenda" HeaderText="Valor" DataFormatString="{0:###,###,###,##0.00}" SortExpression="vrTotalMoedaPedidoVenda">
            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Right" />
        </asp:BoundField>
        <asp:BoundField DataField="dsIndicadorStatusPedidoVenda" HeaderText="Situação" SortExpression="dsIndicadorStatusPedidoVenda">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
    </Columns>
</asp:GridView>
