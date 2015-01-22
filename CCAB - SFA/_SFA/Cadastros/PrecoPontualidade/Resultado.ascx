<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_PrecoPontualidade_Resultado" %>

<asp:GridView ID="GridView1" DataKeyNames="cdCronogramaSafraVencimentoCoopSEQ" runat="server" OnSelectedIndexChanged="GridView_SelectedIndexChanged" AutoGenerateColumns="False">
<Columns>   
    <asp:TemplateField><ItemTemplate><asp:GridViewRowSelector ID="GridViewRowSelector1" runat="server" /></ItemTemplate></asp:TemplateField>        
    <asp:BoundField DataField="nmCooperativa" HeaderText="Agente" ItemStyle-HorizontalAlign="Left" />
    <asp:BoundField DataField="pcCorrecaoPreco" 
        SortExpression="pcCorrecaoPreco" 
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
    
</Columns>    
</asp:GridView>
