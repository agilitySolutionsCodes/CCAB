<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_GrupoAcesso_Resultado" %>

<asp:GridView ID="GridView1" DataKeyNames="cdGrupoAcessoSEQ" runat="server" 
    OnSelectedIndexChanged="GridView_SelectedIndexChanged" OnPageIndexChanging="GridView_PageIndexChanging" OnSorting="GridView_Sorting">
    <Columns>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:GridViewRowSelector ID="GridViewRowSelector1" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="cdGrupoAcessoSEQ" HeaderText="Código" SortExpression="cdGrupoAcessoSEQ" >
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top"/>
            <HeaderStyle HorizontalAlign="Left"/>
        </asp:BoundField>
        <asp:BoundField DataField="dsGrupoAcesso" HeaderText="Nome do Grupo" SortExpression="dsGrupoAcesso" >
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top"/>
            <HeaderStyle HorizontalAlign="Left"/>
        </asp:BoundField>
        <asp:BoundField DataField="wkGrupoAcesso" HeaderText="Observação" SortExpression="wkGrupoAcesso" >
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top"/>
            <HeaderStyle HorizontalAlign="Left"/>
        </asp:BoundField>
        <asp:BoundField DataField="dsIndicadorStatusGrupoAcesso" HeaderText="Situação" SortExpression="dsIndicadorStatusGrupoAcesso">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Center" />
        </asp:BoundField>
    </Columns>
</asp:GridView>
