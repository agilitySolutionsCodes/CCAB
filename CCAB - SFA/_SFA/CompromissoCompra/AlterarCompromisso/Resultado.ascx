<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_CompromissoCompra_AlterarCompromisso_Resultado" %>

<asp:GridView ID="GridView1" DataKeyNames="cdCompromissoCompraSEQ" runat="server" 
    OnPageIndexChanging="GridView_PageIndexChanging" OnSorting="GridView_Sorting">
    <Columns>
        <asp:TemplateField HeaderText="Nº Compromisso">
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" Text='<%# Bind("cdCompromissoCompraSEQ") %>' 
                OnClick="GridView_OnClick" CommandArgument='<%# Bind("cdCompromissoCompraSEQ") %>' />
            </ItemTemplate>
            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" Width="100" />
            <HeaderStyle HorizontalAlign="Right" />
        </asp:TemplateField>
        <asp:BoundField DataField="dtEmissaoCompromissoCompra" HeaderText="Data Emissão" DataFormatString="{0:dd/MM/yyyy}" SortExpression="dtEmissaoCompromissoCompra" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top"/>
            <HeaderStyle HorizontalAlign="Center"/>
        </asp:BoundField>
        <asp:BoundField DataField="dsAgenteComercialCooperativaCompromissoCompra" HeaderText="Agente" SortExpression="dsAgenteComercialCooperativaCompromissoCompra">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="dsPessoaOrigemFaturamento" HeaderText="Origem Faturamento" SortExpression="dsPessoaOrigemFaturamento">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="dsCronogramaSafra" HeaderText="Safra" SortExpression="dsCronogramaSafra">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="dsIndicadorMoedaCompromissoCompra" HeaderText="Moeda" SortExpression="dsIndicadorMoedaCompromissoCompra">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
        <asp:BoundField DataField="vrTotalMoedaCompromissoCompra" HeaderText="Valor" DataFormatString="{0:###,###,###,##0.0000}" SortExpression="vrTotalMoedaCompromissoCompra">
            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Right" />
        </asp:BoundField>
        <asp:BoundField DataField="dsIndicadorStatusCompromissoCompra" HeaderText="Situação" SortExpression="dsIndicadorStatusCompromissoCompra">
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:BoundField>
    </Columns>
</asp:GridView>
