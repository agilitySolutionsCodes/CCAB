<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_CompromissoCompra_LiberarCompromisso_Resultado" %>


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

    function ExibirRelatorio(pCdCompromissoCompraSEQ) {
        window.open("./../../Relatorios/CompromissoCompra.aspx?cdCompromissoCompraSEQ=" + pCdCompromissoCompraSEQ, "CompromissoCompra", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=700,height=500,left=100,top=50");
    }

    function chkClick(obj) {

        var _chkControl = eval('theForm.' + '<%=chkControl.ClientID %>');
        var _valor = parseInt(_chkControl.value);

        if (obj.checked)
            _valor += 1;
        else
            _valor -= 1;

        _chkControl.value = _valor;
    }
    
    function Confirmacao() {

        var _chkControl = eval('theForm.' + '<%=chkControl.ClientID %>');
        var _valor = parseInt(_chkControl.value);

        if (_valor <= 0) {
            alert("Nenhum registro foi selecionado!");
            return false;
        }
        else
            return confirm("Deseja realmente Liberar\no(s) registro(s) selecionado(s)?");
    }
</script>

<div>
    <asp:GridView ID="GridView1" DataKeyNames="cdCompromissoCompraSEQ" runat="server" SkinID="NoPaging">
        <Columns>
            <asp:TemplateField HeaderText="Select">
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelect" onclick="javascript:chkClick(this);" runat="server" />
                </ItemTemplate>
                <HeaderTemplate>
                    <input id="chkAll" onclick="javascript:SelectAll(this);" runat="server" type="checkbox" title="Selecionar Todos" />
                </HeaderTemplate>
            </asp:TemplateField>   
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
            <asp:BoundField DataField="vrTotalMoedaCompromissoCompra" HeaderText="Valor" DataFormatString="{0:###,###,###,##0.00}" SortExpression="vrTotalMoedaCompromissoCompra">
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
    <asp:HiddenField ID="chkControl" runat="server" Value="0" />
    <asp:Button runat="server" ID="btAction" CssClass="button" ValidationGroup="Form"
        Text="Liberar" CausesValidation="true" 
        OnClientClick="return Confirmacao()" 
        OnClick="btAction_Click" Visible="false" />
</div>
