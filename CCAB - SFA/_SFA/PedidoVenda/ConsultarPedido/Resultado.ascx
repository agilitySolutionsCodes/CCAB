<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_PedidoVenda_ConsultarPedido_Resultado" %>


<script type="text/javascript">
    function SelectAll(spanChk){

        var oItem = spanChk.children;
        var theBox= (spanChk.type=="checkbox") ? spanChk : spanChk.children.item[0];
        xState=theBox.checked;
        elm=theBox.form.elements;

        for(i=0;i<elm.length;i++)
            if(elm[i].type=="checkbox" && elm[i].id!=theBox.id)
            {
                if(elm[i].checked!=xState)
                    elm[i].click();
            }
    }

    function ExibirRelatorio(pCdPedidoVendaSEQ) {
        window.open("./../../Relatorios/PedidoVenda.aspx?cdPedidoVendaSEQ=" + pCdPedidoVendaSEQ, "PedidoVenda", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=700,height=500,left=100,top=50");
    }

    function ExibirRelatorioLista(pCdPedidoVendaSEQ, pCdAgenteComercialCooperativaPedidoVenda, pCdCronogramaSafraSEQ, pCdIndicadorStatusPedidoVenda, pCdIndicadorMoedaPedidoVenda, pCdClienteFaturamentoPedidoVenda, pCdClienteEntregaPedidoVenda, pCdPessoaOrigemFaturamento, pExibirPreco)
    {
        window.open("./../../Relatorios/PedidoVendaAnalitico.aspx?cdPedidoVendaSEQ=" + pCdPedidoVendaSEQ + "&CdAgenteComercialCooperativaPedidoVenda=" + pCdAgenteComercialCooperativaPedidoVenda + "&CdCronogramaSafraSEQ=" + pCdCronogramaSafraSEQ + "&CdIndicadorStatusPedidoVenda=" + pCdIndicadorStatusPedidoVenda + "&CdIndicadorMoedaPedidoVenda=" + pCdIndicadorMoedaPedidoVenda + "&CdClienteFaturamentoPedidoVenda=" + pCdClienteFaturamentoPedidoVenda + "&CdClienteEntregaPedidoVenda=" + pCdClienteEntregaPedidoVenda + "&CdPessoaOrigemFaturamento=" + pCdPessoaOrigemFaturamento + "&blExibirPreco=" + pExibirPreco, "PedidoVenda", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=700,height=500,left=100,top=50");
    }

    function ExibirRelatorioPedidoVendaAnaliticoSimples(pCdPedidoVendaSEQ, pCdAgenteComercialCooperativaPedidoVenda, pCdCronogramaSafraSEQ, pCdIndicadorStatusPedidoVenda, pCdIndicadorMoedaPedidoVenda, pCdClienteFaturamentoPedidoVenda, pCdClienteEntregaPedidoVenda, pCdPessoaOrigemFaturamento, pExibirPreco) {
        window.open("./../../Relatorios/PedidoVendaAnaliticoSimples.aspx?cdPedidoVendaSEQ=" + pCdPedidoVendaSEQ + "&CdAgenteComercialCooperativaPedidoVenda=" + pCdAgenteComercialCooperativaPedidoVenda + "&CdCronogramaSafraSEQ=" + pCdCronogramaSafraSEQ + "&CdIndicadorStatusPedidoVenda=" + pCdIndicadorStatusPedidoVenda + "&CdIndicadorMoedaPedidoVenda=" + pCdIndicadorMoedaPedidoVenda + "&CdClienteFaturamentoPedidoVenda=" + pCdClienteFaturamentoPedidoVenda + "&CdClienteEntregaPedidoVenda=" + pCdClienteEntregaPedidoVenda + "&CdPessoaOrigemFaturamento=" + pCdPessoaOrigemFaturamento + "&blExibirPreco=" + pExibirPreco, "PedidoVenda", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=700,height=500,left=100,top=50");
    }
        
    function ExibirRelatorioPedidoVendaSintetico(pCdPedidoVendaSEQ, pCdAgenteComercialCooperativaPedidoVenda, pCdCronogramaSafraSEQ, pCdIndicadorStatusPedidoVenda, pCdIndicadorMoedaPedidoVenda, pCdClienteFaturamentoPedidoVenda, pCdClienteEntregaPedidoVenda, pCdPessoaOrigemFaturamento, pExibirPreco)
    {
        window.open("./../../Relatorios/PedidoVendaSintetico.aspx?cdPedidoVendaSEQ=" + pCdPedidoVendaSEQ + "&CdAgenteComercialCooperativaPedidoVenda=" + pCdAgenteComercialCooperativaPedidoVenda + "&CdCronogramaSafraSEQ=" + pCdCronogramaSafraSEQ + "&CdIndicadorStatusPedidoVenda=" + pCdIndicadorStatusPedidoVenda + "&CdIndicadorMoedaPedidoVenda=" + pCdIndicadorMoedaPedidoVenda + "&CdClienteFaturamentoPedidoVenda=" + pCdClienteFaturamentoPedidoVenda + "&CdClienteEntregaPedidoVenda=" + pCdClienteEntregaPedidoVenda + "&CdPessoaOrigemFaturamento=" + pCdPessoaOrigemFaturamento + "&blExibirPreco=" + pExibirPreco, "PedidoVenda", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=700,height=500,left=100,top=50");
    }

    function ExibirRelatorioPrePedido(TipoRelatorio, cdPedidoVendaSEQ, cdPedidoVendaERPSEQ, cdAgenteComercialCooperativaPedidoVenda, cdCronogramaSafraSEQ, cdClienteFaturamentoPedidoVenda, cdClienteEntregaPedidoVenda, cdIndicadorMoedaPedidoVenda, cdIndicadorStatusPedidoVenda, cdPessoaOrigemFaturamento) 
    {
        //window.open("./../../Relatorios/PrePedido.aspx?cdPedidoVendaSEQ=" + cdPedidoVendaSEQ + "&cdPedidoVendaERPSEQ=" + cdPedidoVendaERPSEQ, "PrePedido", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=700,height=500,left=100,top=50");
        window.open("./../../Relatorios/PrePedido.aspx?TipoRelatorio=" + TipoRelatorio + "&cdPedidoVendaSEQ=" + cdPedidoVendaSEQ + "&cdPedidoVendaERPSEQ=" + cdPedidoVendaERPSEQ + "&cdAgenteComercialCooperativaPedidoVenda=" + cdAgenteComercialCooperativaPedidoVenda + "&cdCronogramaSafraSEQ=" + cdCronogramaSafraSEQ + "&cdClienteFaturamentoPedidoVenda=" + cdClienteFaturamentoPedidoVenda + "&cdClienteEntregaPedidoVenda=" + cdClienteEntregaPedidoVenda + "&cdIndicadorMoedaPedidoVenda=" + cdIndicadorMoedaPedidoVenda + "&cdIndicadorStatusPedidoVenda=" + cdIndicadorStatusPedidoVenda + "&cdPessoaOrigemFaturamento=" + cdPessoaOrigemFaturamento, "PrePedido", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=700,height=500,left=100,top=50");
    }
    
</script>

<div>
    <asp:GridView ID="GridView1" DataKeyNames="cdPedidoVendaSEQ" OnRowDataBound="RowDataBound" runat="server" SkinID="NoPaging"> 
        <Columns>
            <asp:TemplateField ShowHeader="false">
                <ItemTemplate>
                    <asp:LinkButton ID="btViewERP" runat="server" CommandArgument='<%# Eval("cdPedidoVendaSEQ") %>' 
                        Text="Pré-Pedido" OnClick="btViewERP_Click" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="false" />
                <HeaderStyle HorizontalAlign="Center" />
            </asp:TemplateField>  
            <asp:TemplateField HeaderText="Nº Pedido">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton2" runat="server" Text='<%# Eval("cdPedidoVendaSEQ") %>' 
                    OnClientClick='javascript:ExibirRelatorio(this.innerText); return false;' />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:BoundField DataField="dtDigitacaoPedidoVenda" HeaderText="Data Digitação" DataFormatString="{0:dd/MM/yyyy}" SortExpression="dtDigitacaoPedidoVenda" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top"/>
                <HeaderStyle HorizontalAlign="Center"/>
            </asp:BoundField>
            <asp:BoundField DataField="dtEmissaoPedidoVenda" HeaderText="Data Emissão" DataFormatString="{0:dd/MM/yyyy}" SortExpression="dtEmissaoPedidoVenda" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top"/>
                <HeaderStyle HorizontalAlign="Center"/>
            </asp:BoundField>
            <asp:BoundField DataField="dsAgenteComercialCooperativaPedidoVenda" HeaderText="Agente" SortExpression="dsAgenteComercialCooperativaPedidoVenda">
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="dsPessoaOrigemFaturamento" HeaderText="Origem Faturamento" SortExpression="dsPessoaOrigemFaturamento">
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="dsClienteFaturamentoPedidoVenda" HeaderText="Cliente" SortExpression="dsClienteFaturamentoPedidoVenda">
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="dsClienteEntregaPedidoVenda" HeaderText="Local Entrega" SortExpression="dsClienteEntregaPedidoVenda">
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="dsIndicadorMoedaPedidoVenda" HeaderText="Moeda" SortExpression="dsIndicadorMoedaPedidoVenda">
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="vrTotalMoedaPedidoVenda" HeaderText="Valor" DataFormatString="{0:###,###,###,##0.00}" SortExpression="vrTotalMoedaPedidoVenda">
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="dsIndicadorStatusPedidoVenda" HeaderText="Situação" SortExpression="dsIndicadorStatusPedidoVenda">
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
</div>

<div style="text-align: right; margin-top: 15px;">
    <asp:Button runat="server" ID="btPedidoVendaAnaliticoSimples" CssClass="button" ValidationGroup="Form"
        Text="Sintético" 
        Width="130" 
        CausesValidation="false" 
        Visible="false" />
    <asp:Button runat="server" ID="btPedidoVendaSintetico" CssClass="button" ValidationGroup="Form"
        Text="Imprimir Lista" 
        Width="130" 
        CausesValidation="false" 
        Visible="false" />
    <asp:Button runat="server" ID="btnPrePedido" CssClass="button" ValidationGroup="Form"
        Text="Imprimir Lista Pré-Pedido"  
        Width="200" 
        CausesValidation="false" 
        Visible="false" />        
    <asp:Button runat="server" ID="btAction" CssClass="button" ValidationGroup="Form"
        Text="Analítico" 
        Width="130" 
        CausesValidation="false" 
        Visible="false" />
</div>
