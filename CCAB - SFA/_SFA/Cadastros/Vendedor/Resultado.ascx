<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_Vendedor_Resultado" %>

<asp:GridView ID="GridView1" DataKeyNames="cdPessoaSEQ" runat="server" 
    OnSelectedIndexChanged="GridView_SelectedIndexChanged" OnPageIndexChanging="GridView_PageIndexChanging" OnSorting="GridView_Sorting">
    <Columns>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:GridViewRowSelector ID="GridViewRowSelector1" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="cdPessoaERP" HeaderText="Código" SortExpression="cdPessoaERP">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="nuCNPJCPFPessoa" HeaderText="CNPJ/CPF" SortExpression="nuCNPJCPFPessoa">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="nmPessoa" HeaderText="Nome" SortExpression="nmPessoa">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="dsIndicadorTipoAgenteComercialPessoa" HeaderText="Tipo Agente" SortExpression="dsIndicadorTipoAgenteComercialPessoa">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="dsLoginPessoa" HeaderText="Login" SortExpression="dsLoginPessoa">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="dsIndicadorStatusPessoa" HeaderText="Situação" SortExpression="dsIndicadorStatusPessoa">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
    </Columns>
</asp:GridView>
