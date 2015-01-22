<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_CronogramaSafra_Resultado" %>

<asp:GridView ID="GridView1" DataKeyNames="cdCronogramaSafraSEQ" runat="server" 
    OnSelectedIndexChanged="GridView_SelectedIndexChanged" OnPageIndexChanging="GridView_PageIndexChanging" OnSorting="GridView_Sorting">
    <Columns>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:GridViewRowSelector ID="GridViewRowSelector1" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="dsCronogramaSafra" HeaderText="Safra" SortExpression="dsCronogramaSafra" >
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top"/>
            <HeaderStyle HorizontalAlign="Left"/>
        </asp:BoundField>
        <asp:BoundField DataField="dtInicioCronogramaSafra" 
            SortExpression="dtInicioCronogramaSafra" 
            HeaderText="Data Inicio" DataFormatString="{0:dd/MM/yyyy}">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Center" />
        </asp:BoundField>
        <asp:BoundField DataField="dtFimCronogramaSafra" 
            SortExpression="dtFimCronogramaSafra" 
            HeaderText="Data Fim" DataFormatString="{0:dd/MM/yyyy}">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Center" />
        </asp:BoundField>
        <asp:BoundField DataField="dtLimiteLiberacaoCCCronogramaSafra" 
            SortExpression="dtLimiteLiberacaoCCCronogramaSafra" 
            HeaderText="Limite Liberação Compra" DataFormatString="{0:dd/MM/yyyy}">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Center" />
        </asp:BoundField>
        <asp:BoundField DataField="dtLimiteAprovacaoCCCronogramaSafra" 
            SortExpression="dtLimiteAprovacaoCCCronogramaSafra" 
            HeaderText="Limite Aprovação Compra" DataFormatString="{0:dd/MM/yyyy}">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Center" />
        </asp:BoundField>
        <asp:BoundField DataField="dtLimiteLiberacaoPVCronogramaSafra" 
            SortExpression="dtLimiteLiberacaoPVCronogramaSafra" 
            HeaderText="Limite Liberação Pedido" DataFormatString="{0:dd/MM/yyyy}">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Center" />
        </asp:BoundField>
        <asp:BoundField DataField="dtLimiteAprovacaoPVRCCronogramaSafra" 
            SortExpression="dtLimiteAprovacaoPVRCCronogramaSafra" 
            HeaderText="Limite Aprovação Pedido RC" DataFormatString="{0:dd/MM/yyyy}">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Center" />
        </asp:BoundField>
        <asp:BoundField DataField="dtLimiteAprovacaoPVACCronogramaSafra" 
            SortExpression="dtLimiteAprovacaoPVACCronogramaSafra" 
            HeaderText="Limite Aprovação Pedido CCAB" DataFormatString="{0:dd/MM/yyyy}">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Center" />
        </asp:BoundField>
        <asp:BoundField DataField="dsIndicadorStatusCronogramaSafra" HeaderText="Situação" SortExpression="dsIndicadorStatusCronogramaSafra">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Center" />
        </asp:BoundField>
    </Columns>
</asp:GridView>
