<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_TipoCultura_Resultado" %>

<asp:GridView ID="GridView1" DataKeyNames="cdTipoCulturaSEQ" runat="server" 
    OnSelectedIndexChanged="GridView_SelectedIndexChanged" OnPageIndexChanging="GridView_PageIndexChanging" OnSorting="GridView_Sorting">
    <Columns>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:GridViewRowSelector ID="GridViewRowSelector1" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="cdTipoCulturaSEQ" HeaderText="Código" SortExpression="cdTipoCulturaSEQ">
            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Right" />
        </asp:BoundField>
        <asp:BoundField DataField="dsTipoCultura" HeaderText="Descrição" SortExpression="dsTipoCultura" >
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top"/>
            <HeaderStyle HorizontalAlign="Left"/>
        </asp:BoundField>
        <asp:BoundField DataField="nuOrdemApresentacaoTipoCultura" HeaderText="Ordem Apresentação" SortExpression="nuOrdemApresentacaoTipoCultura" >
            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top"/>
            <HeaderStyle HorizontalAlign="Right"/>
        </asp:BoundField>
        <asp:BoundField DataField="dsIndicadorStatusTipoCultura" HeaderText="Situação" SortExpression="dsIndicadorStatusTipoCultura">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Center" />
        </asp:BoundField>
    </Columns>
</asp:GridView>
