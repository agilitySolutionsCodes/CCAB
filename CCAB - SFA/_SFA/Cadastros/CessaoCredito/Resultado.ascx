<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_CessaoCredito_Resultado" %>

<asp:GridView ID="GridView1" DataKeyNames="cdCooperativaCessaoCreditoSEQ" runat="server" OnSelectedIndexChanged="GridView_SelectedIndexChanged" AutoGenerateColumns="False">
<Columns>   
    <asp:TemplateField><ItemTemplate><asp:GridViewRowSelector ID="GridViewRowSelector1" runat="server" /></ItemTemplate></asp:TemplateField>        
    <asp:BoundField DataField="dsAgente" HeaderText="Agente" ItemStyle-HorizontalAlign="Left" />        
    <asp:BoundField DataField="dsIndicadorPedidoNormal" HeaderText="Normal" />
    <asp:BoundField DataField="dsIndicadorPedidoContaOrdem" HeaderText="Conta e Ordem" />
    <asp:BoundField DataField="dsIndicadorCessaoCredito" HeaderText="Cessão de Crédito" />
</Columns>    
</asp:GridView>
