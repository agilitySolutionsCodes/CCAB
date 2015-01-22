<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_CompromissoCompra_ConsultarCompromissoConsolidado_Resultado" %>


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

    function ExibirRelatorio(pCdCompromissoCompraSEQ) 
    {
        window.open("./../../Relatorios/CompromissoCompra.aspx?cdCompromissoCompraSEQ=" + pCdCompromissoCompraSEQ, "CompromissoCompra", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=700,height=500,left=100,top=50");
    }

    function ExibirRelatorioLista(pCdCompromissoCompraSEQ, pCdAgenteComercialCooperativaCompromissoCompra, pCdCronogramaSafraSEQ, pCdIndicadorStatusCompromissoCompra, pCdIndicadorMoedaCompromissoCompra, pCdPessoaOrigemFaturamento, pExibirPreco)
    {
        window.open("./../../Relatorios/CompromissoCompraAnalitico.aspx?cdCompromissoCompraSEQ=" + pCdCompromissoCompraSEQ + "&CdAgenteComercialCooperativaCompromissoCompra=" + pCdAgenteComercialCooperativaCompromissoCompra + "&CdCronogramaSafraSEQ=" + pCdCronogramaSafraSEQ + "&CdIndicadorStatusCompromissoCompra=" + pCdIndicadorStatusCompromissoCompra + "&CdIndicadorMoedaCompromissoCompra=" + pCdIndicadorMoedaCompromissoCompra + "&cdPessoaOrigemFaturamento=" + pCdPessoaOrigemFaturamento + "&blExibirPreco=" + pExibirPreco, "CompromissoCompra", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=700,height=500,left=100,top=50");
    }

    function ExibirRelatorioCompromissoCompraAnaliticoSimples(pCdCompromissoCompraSEQ, pCdAgenteComercialCooperativaCompromissoCompra, pCdCronogramaSafraSEQ, pCdIndicadorStatusCompromissoCompra, pCdIndicadorMoedaCompromissoCompra, pCdPessoaOrigemFaturamento, pExibirPreco) {
        window.open("./../../Relatorios/CompromissoCompraAnaliticoSimples.aspx?cdCompromissoCompraSEQ=" + pCdCompromissoCompraSEQ + "&CdAgenteComercialCooperativaCompromissoCompra=" + pCdAgenteComercialCooperativaCompromissoCompra + "&CdCronogramaSafraSEQ=" + pCdCronogramaSafraSEQ + "&CdIndicadorStatusCompromissoCompra=" + pCdIndicadorStatusCompromissoCompra + "&CdIndicadorMoedaCompromissoCompra=" + pCdIndicadorMoedaCompromissoCompra + "&cdPessoaOrigemFaturamento=" + pCdPessoaOrigemFaturamento + "&blExibirPreco=" + pExibirPreco, "CompromissoCompra", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=700,height=500,left=100,top=50");
    }

    function ExibirRelatorioCompromissoCompraConsolidado(pCdAgenteComercialCooperativaCompromissoCompra, pCdCronogramaSafraSEQ) {
        window.open("./../../Relatorios/CompromissoCompraConsolidado.aspx?CdAgenteComercialCooperativaCompromissoCompra=" + pCdAgenteComercialCooperativaCompromissoCompra + "&CdCronogramaSafraSEQ=" + pCdCronogramaSafraSEQ, "CompromissoCompra", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=700,height=500,left=100,top=50");
    }
        
    function ExibirRelatorioCompromissoCompraSintetico(pCdCompromissoCompraSEQ, pCdAgenteComercialCooperativaCompromissoCompra, pCdCronogramaSafraSEQ, pCdIndicadorStatusCompromissoCompra, pCdIndicadorMoedaCompromissoCompra, pCdPessoaOrigemFaturamento, pExibirPreco)
    {
        window.open("./../../Relatorios/CompromissoCompraSintetico.aspx?cdCompromissoCompraSEQ=" + pCdCompromissoCompraSEQ + "&CdAgenteComercialCooperativaCompromissoCompra=" + pCdAgenteComercialCooperativaCompromissoCompra + "&CdCronogramaSafraSEQ=" + pCdCronogramaSafraSEQ + "&CdIndicadorStatusCompromissoCompra=" + pCdIndicadorStatusCompromissoCompra + "&CdIndicadorMoedaCompromissoCompra=" + pCdIndicadorMoedaCompromissoCompra + "&cdPessoaOrigemFaturamento=" + pCdPessoaOrigemFaturamento + "&blExibirPreco=" + pExibirPreco, "CompromissoCompra", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=700,height=500,left=100,top=50");
    }
        
    function ExibirRelatorioCompromissoCompraResumoPorSituacao(pCdCompromissoCompraSEQ, pCdAgenteComercialCooperativaCompromissoCompra, pCdCronogramaSafraSEQ, pCdIndicadorStatusCompromissoCompra, pCdIndicadorMoedaCompromissoCompra, pCdPessoaOrigemFaturamento)
    {
        window.open("./../../Relatorios/CompromissoCompraResumoPorSituacao.aspx?cdCompromissoCompraSEQ=" + pCdCompromissoCompraSEQ + "&CdAgenteComercialCooperativaCompromissoCompra=" + pCdAgenteComercialCooperativaCompromissoCompra + "&CdCronogramaSafraSEQ=" + pCdCronogramaSafraSEQ + "&CdIndicadorStatusCompromissoCompra=" + pCdIndicadorStatusCompromissoCompra + "&CdIndicadorMoedaCompromissoCompra=" + pCdIndicadorMoedaCompromissoCompra + "&cdPessoaOrigemFaturamento=" + pCdPessoaOrigemFaturamento, "CompromissoCompra", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=700,height=500,left=100,top=50");
    }
</script>

<div>
    <asp:GridView ID="GridView1" DataKeyNames="cdCompromissoCompraSEQ" runat="server" SkinID="NoPaging">
        <Columns>
            <asp:TemplateField HeaderText="Nº Compromisso">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" Text='<%# Eval("cdCompromissoCompraSEQ") %>' 
                    OnClientClick='javascript:ExibirRelatorio(this.innerText); return false;' />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
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
</div>

<div style="text-align: right; margin-top: 15px;">
    <asp:Button runat="server" ID="btCompromissoCompraAnaliticoSimples" CssClass="button" ValidationGroup="Form"
        Text="Sintético" Width="130" CausesValidation="false" Visible="false" />
    <asp:Button runat="server" ID="btCompromissoCompraSintetico" CssClass="button" ValidationGroup="Form"
        Text="Imprimir Lista" Width="200" CausesValidation="false" Visible="false" />
    <asp:Button runat="server" ID="btResumoSituacao" CssClass="button" ValidationGroup="Form"
        Text="Resumo Por Situação" Width="200" CausesValidation="false" Visible="false" />
    <asp:Button runat="server" ID="btAction" CssClass="button" ValidationGroup="Form"
        Text="Imprimir" Width="130" CausesValidation="false" Visible="false" />
</div>
