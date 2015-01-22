<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_Colaborador_Resultado" %>

<asp:GridView ID="GridView1" DataKeyNames="cdPessoaSEQ" runat="server" 
    OnSelectedIndexChanged="GridView_SelectedIndexChanged" OnPageIndexChanging="GridView_PageIndexChanging" OnSorting="GridView_Sorting">
    <Columns>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:GridViewRowSelector ID="GridViewRowSelector1" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="cdPessoaSEQ" HeaderText="Código" SortExpression="cdPessoaSEQ">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="nuCNPJCPFPessoa" HeaderText="CPF" SortExpression="nuCNPJCPFPessoa">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="nmPessoa" HeaderText="Nome" SortExpression="nmPessoa">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="dsLoginPessoa" HeaderText="Login" SortExpression="dsLoginPessoa">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="nmEmpresaColaboradorPessoa" HeaderText="Empresa" SortExpression="nmEmpresaColaboradorPessoa">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="dsIndicadorStatusPessoa" HeaderText="Situação" SortExpression="dsIndicadorStatusPessoa">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="dsIndicadorTipoPerfilPessoa" HeaderText="Perfil" SortExpression="dsIndicadorTipoPerfilPessoa">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
    </Columns>
</asp:GridView>
