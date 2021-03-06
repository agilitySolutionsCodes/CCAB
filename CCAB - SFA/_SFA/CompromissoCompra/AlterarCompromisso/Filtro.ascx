﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Filtro.ascx.cs" Inherits="_SFA_CompromissoCompra_AlterarCompromisso_Filtro" %>

<script type="text/javascript" src="../../../scripts/JScript.js"></script>

<script type="text/javascript">
    function chkFields() {
    
        var _agente = eval('theForm.' + '<%=cdAgente.ClientID %>');
        var _agenteValue = eval('theForm.' + '<%=cdAgenteValue.ClientID %>');

        var _origem = eval('theForm.' + '<%=cdPessoaOrigemFaturamento.ClientID %>');
        var _origemValue = eval('theForm.' + '<%=cdPessoaOrigemFaturamentoValue.ClientID %>');
        
        var _safra = eval('theForm.' + '<%=cdCronogramaSafraSEQ.ClientID %>');
        var _safraValue = eval('theForm.' + '<%=cdCronogramaSafraSEQValue.ClientID %>');

        var _moeda = eval('theForm.' + '<%=cdMoeda.ClientID %>');
        var _moedaValue = eval('theForm.' + '<%=cdMoedaValue.ClientID %>');

        var _status = eval('theForm.' + '<%=cdStatus.ClientID %>');
        var _statusValue = eval('theForm.' + '<%=cdStatusValue.ClientID %>');
        
        var _msg = "";

        _agenteValue.value = _agente.value.toString();
        _origemValue.value = _origem.value.toString();
        _safraValue.value = _safra.value.toString();
        _moedaValue.value = _moeda.value.toString();
        _statusValue.value = _status.value.toString();

        if (_safraValue.value == "0"){ 
            alert("Safra é parâmetro obrigatório"); 
            return false;
        } 
        return true;
    }
</script>

<div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbGenerica_01">
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Agente:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:HiddenField ID="cdAgenteValue" runat="server" />
                <asp:DropDownList ID="cdAgente" runat="server"   
                    CssClass="campoTexto" DataValueField="cdPessoaSEQ" Width="470"  
                    DataTextField="nmPessoa" DataSourceID="ObjectDataSource1" 
                    OnPreRender="cdAgente_PreRender" 
                    onselectedindexchanged="cdAgente_SelectedIndexChanged" AutoPostBack="true" />
            </td>
            <td align="right" rowspan="7" class="tbTd_cinzaEscura" style="padding-right: 20px;"> 
                <asp:LinkButton runat="server" ID="btPesquisar" OnClientClick="return chkFields()" 
                     Text="Pesquisar Compromisso" OnClick="btPesquisar_OnClick" />
            </td>
        </tr>
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Origem Faturamento:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:HiddenField ID="cdPessoaOrigemFaturamentoValue" runat="server" />
                <asp:DropDownList ID="cdPessoaOrigemFaturamento" runat="server" AutoPostBack="True"    
                    CssClass="campoTexto" DataValueField="cdPessoaOrigemFaturamento" 
                    DataTextField="dsPessoaOrigemFaturamento" 
                    DataSourceID="ObjectDataSource5" />
            </td>
        </tr>
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Safra: *
            </td>
            <td class="tbTd_CinzaClara">
                <asp:HiddenField ID="cdCronogramaSafraSEQValue" runat="server" />
                
                <asp:DropDownList ID="cdCronogramaSafraSEQAno" runat="server" CssClass="campoTexto" 
                    Width="60px" DataValueField="Ano" 
                    DataTextField="Ano" DataSourceID="ObjectDataSource_ObterListaAno" 
                    AutoPostBack="True" 
                    onselectedindexchanged="cdCronogramaSafraSEQAno_SelectedIndexChanged">
                </asp:DropDownList>
                                
                <asp:DropDownList ID="cdCronogramaSafraSEQ" runat="server"     
                    CssClass="campoTexto" DataValueField="cdCronogramaSafraSEQ" 
                    DataTextField="dsCronogramaSafra" DataSourceID="ObjectDataSource2" />
            </td>
        </tr>
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Moeda:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:HiddenField ID="cdMoedaValue" runat="server" />
                <asp:DropDownList ID="cdMoeda" runat="server"  
                    CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado" 
                    DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource3" />
            </td>
        </tr>
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Nº Compromisso:
            </td>
            <td class="tbTd_CinzaClara">
                <conv:TextBox ID="cdCompromisso" runat="server" Enabled="true" Columns="8"   
                    CssClass="campoTexto" Type="Numeric" DecimalPlaces="0" />
            </td>
        </tr>
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Situação:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:HiddenField ID="cdStatusValue" runat="server" />
                <asp:DropDownList ID="cdStatus" runat="server"  
                    CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado" 
                    DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource4" />
            </td>
        </tr>
        <tr>
            <td class="tbTd_cinzaEscura">
            </td>
            <td class="tbTd_CinzaClara">
                (*) Os campos marcados com asterisco são de preenchimento obrigatório 
            </td>
        </tr>
    </table>
</div>

<div style="display: none;">
    <asp:Label ID="lbNomeTela" runat="server" SkinID="normal" />
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="ObterListaPedidoAgente" TypeName="Pessoa">
        <SelectParameters>
            <asp:SessionParameter SessionField="cdUsuario" Name="cdUsuario" Type="Int64" />
            <asp:Parameter Name="cdIndicadorStatusPessoa" DefaultValue="0" Type="Int64" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    

    <asp:ObjectDataSource ID="ObjectDataSource_ObterListaAno" runat="server" SelectMethod="ObterListaAno" TypeName="CronogramaSafra">
    </asp:ObjectDataSource> 
        
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="ObterLista" TypeName="CronogramaSafra">
        <SelectParameters>
            <asp:Parameter Name="dsCronogramaSafra" DefaultValue=" " Type="String" />
            <asp:Parameter Name="cdIndicadorStatusCronogramaSafra" DefaultValue="0" Type="Int64" />
            <asp:Parameter Name="Ano" DefaultValue="" Type="String" />
            <asp:Parameter Name="cdPessoaSEQ" DefaultValue="0" Type="Int64" />
            <asp:Parameter Name="cdIndicadorSituacaoCooperativa" DefaultValue="0" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource> 
    <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORMOEDA" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORSTATUSCOMPROMISSOCOMPRA" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" SelectMethod="ObterListaOrigemFaturamento" TypeName="Pessoa">
        <SelectParameters>
            <asp:Parameter Name="cdIndicadorStatusPessoa" DefaultValue="0" Type="Int64" />
        </SelectParameters>
    </asp:ObjectDataSource>
</div>

<br />
