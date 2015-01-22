<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_OrigemFaturamento_Resultado" %>

<asp:GridView ID="GridView1" DataKeyNames="cdCooperativaOrigemFaturamentoSEQ" runat="server" OnSelectedIndexChanged="GridView_SelectedIndexChanged" AutoGenerateColumns="False">
<Columns>   
    <asp:TemplateField><ItemTemplate><asp:GridViewRowSelector ID="GridViewRowSelector1" runat="server" /></ItemTemplate></asp:TemplateField>        
    <asp:BoundField DataField="dsAgente" HeaderText="Agente" ItemStyle-HorizontalAlign="Left" />        
    <asp:BoundField DataField="dsFaturamento" HeaderText="Origem Faturamento" />
    <asp:BoundField DataField="dsIndicadorOrigemFaturamento" HeaderText="Situação" />
</Columns>    
</asp:GridView>
