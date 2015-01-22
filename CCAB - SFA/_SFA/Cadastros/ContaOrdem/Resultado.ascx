<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_ContaOrdem_Resultado" %>

<asp:GridView ID="GridView1" DataKeyNames="cdCooperativaContaOrdemSEQ" runat="server" OnSelectedIndexChanged="GridView_SelectedIndexChanged" AutoGenerateColumns="False">
<Columns>   
    <asp:TemplateField><ItemTemplate><asp:GridViewRowSelector ID="GridViewRowSelector1" runat="server" /></ItemTemplate></asp:TemplateField>        
    <asp:BoundField DataField="dsAgente" HeaderText="Agente" ItemStyle-HorizontalAlign="Left" />        
    <asp:BoundField DataField="dsIndicadorContaOrdem" HeaderText="Conta Ordem" />
</Columns>    
</asp:GridView>
