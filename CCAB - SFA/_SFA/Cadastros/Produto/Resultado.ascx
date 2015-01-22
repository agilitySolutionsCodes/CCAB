<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_Produto_Resultado" %>

<asp:GridView ID="GridView1" DataKeyNames="cdProdutoSEQ" runat="server" 
    OnSelectedIndexChanged="GridView_SelectedIndexChanged" OnPageIndexChanging="GridView_PageIndexChanging" OnSorting="GridView_Sorting">
    <Columns>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:GridViewRowSelector ID="GridViewRowSelector1" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="cdProdutoERP" HeaderText="Código" SortExpression="cdProdutoERP">
            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Right" />
        </asp:BoundField>
        <asp:BoundField DataField="dsTipoProduto" HeaderText="Tipo" SortExpression="dsTipoProduto" >
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top"/>
            <HeaderStyle HorizontalAlign="Left"/>
        </asp:BoundField>
        <asp:BoundField DataField="dsProduto" HeaderText="Descrição" SortExpression="dsProduto" >
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top"/>
            <HeaderStyle HorizontalAlign="Left"/>
        </asp:BoundField>
        <asp:BoundField DataField="nmPessoa" HeaderText="Fornecedor" SortExpression="nmPessoa" Visible="false">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top"/>
            <HeaderStyle HorizontalAlign="Left"/>
        </asp:BoundField>        
        <asp:BoundField DataField="dsUnidadeProduto" HeaderText="Unidade" SortExpression="dsUnidadeProduto">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="qtEmbalagemProduto" HeaderText="Quantidade Embalagem" DataFormatString="{0:###,###,##0.0000}" SortExpression="qtEmbalagemProduto">
            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Right" />
        </asp:BoundField>
        <asp:BoundField DataField="dsIndicadorLiberadoPedidoProduto" HeaderText="Liberado" SortExpression="dsIndicadorLiberadoPedidoProduto">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Center" />
        </asp:BoundField>
    </Columns>
</asp:GridView>
