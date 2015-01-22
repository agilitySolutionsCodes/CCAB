<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_ProdutoHistorico_Resultado" %>

<asp:GridView ID="GridView1" DataKeyNames="cdProdutoHistoricoSEQ" runat="server" 
    OnSelectedIndexChanged="GridView_SelectedIndexChanged" OnPageIndexChanging="GridView_PageIndexChanging" OnSorting="GridView_Sorting">
    <Columns>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:GridViewRowSelector ID="GridViewRowSelector1" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="dsTipoEventoHistorico" HeaderText="Evento" SortExpression="dsTipoEventoHistorico">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="dtOcorrenciaHistorico" HeaderText="Data" SortExpression="dtOcorrenciaHistorico">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="nmUsuario" HeaderText="Usuário" SortExpression="nmUsuario">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="cdProdutoERP" HeaderText="Código" SortExpression="cdProdutoERP">
            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Right" />
        </asp:BoundField>
        <asp:BoundField DataField="dsProduto" HeaderText="Descrição" SortExpression="dsProduto">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="dsUnidadeProduto" HeaderText="Unidade" SortExpression="dsUnidadeProduto">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="cdIndicadorLiberadoPedidoProduto" HeaderText="Liberado" SortExpression="cdIndicadorLiberadoPedidoProduto">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="nuOrdemApresentacaoProduto" HeaderText="Ordem Exibição" SortExpression="nuOrdemApresentacaoProduto">
            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Right" />
        </asp:BoundField>
    </Columns>
</asp:GridView>
