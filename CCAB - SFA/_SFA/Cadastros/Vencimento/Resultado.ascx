<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_Vencimento_Resultado" %>

<asp:GridView ID="GridView1" DataKeyNames="cdCronogramaSafraVencimentoSEQ" runat="server" 
    OnSelectedIndexChanged="GridView_SelectedIndexChanged" OnPageIndexChanging="GridView_PageIndexChanging" OnSorting="GridView_Sorting">
    <Columns>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:GridViewRowSelector ID="GridViewRowSelector1" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="dsTipoCronogramaSafraVencimento" HeaderText="Tipo Vencimento" SortExpression="dsTipoCronogramaSafraVencimento" >
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top"/>
            <HeaderStyle HorizontalAlign="Left"/>
        </asp:BoundField>
        <asp:BoundField DataField="dtCronogramaSafraVencimento" 
            SortExpression="dtCronogramaSafraVencimento" 
            HeaderText="Data Vencimento" DataFormatString="{0:dd/MM/yyyy}">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Center" />
        </asp:BoundField>
        <asp:BoundField DataField="pcCorrecaoPrecoTipoCulturaVencimento" 
            SortExpression="pcCorrecaoPrecoTipoCulturaVencimento" 
            HeaderText="% Correção Preço" DataFormatString="{0:##0.0000}">
            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Right" />
        </asp:BoundField>
        <asp:BoundField DataField="pcDescontoPontualidade" 
            SortExpression="pcDescontoPontualidade" 
            HeaderText="% Desconto Pontualidade" DataFormatString="{0:##0.0000}">
            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Right" />
        </asp:BoundField>        
        <asp:BoundField DataField="wkCronogramaSafraVencimento" 
            SortExpression="wkCronogramaSafraVencimento" 
            HeaderText="Observação">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
    </Columns>
</asp:GridView>
