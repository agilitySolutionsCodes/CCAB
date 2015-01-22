<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_CronogramaSafraCooperativa_Resultado" %>

<asp:GridView ID="GridView1" DataKeyNames="cdCronogramaSafraCooperativaSEQ" runat="server" OnSelectedIndexChanged="GridView_SelectedIndexChanged" AutoGenerateColumns="False">
<Columns>   
    <asp:TemplateField><ItemTemplate><asp:GridViewRowSelector ID="GridViewRowSelector1" runat="server" /></ItemTemplate></asp:TemplateField>        
    <asp:BoundField DataField="dsAgente" HeaderText="Agente" ItemStyle-HorizontalAlign="Left" />        
    <asp:BoundField DataField="dsIndicadorSituacaoCooperativa" HeaderText="Situação" />
</Columns>    
</asp:GridView>
