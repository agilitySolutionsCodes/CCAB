<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Filtro.ascx.cs" Inherits="_SFA_Vendedor_Filtro" %>
<%@ Register TagPrefix="uc" TagName="OnDemandSearch" Src="~/Comum/OnDemandSearch/OnDemandSearch.ascx" %>

<script type="text/javascript" src="../../../scripts/JScript.js"></script>
<script type="text/javascript">
    function chkFields() {
        var _cnpjcpf = eval('theForm.' + '<%=nuCNPJCPFPessoa.ClientID %>');
        
        var _login = eval('theForm.' + '<%=dsLoginPessoa.ClientID %>');

        var _nome = eval('theForm.' + '<%=nmFoneticoPessoa.ClientID %>');

        var _tipoPessoa = eval('theForm.' + '<%=cdIndicadorPessoa.ClientID %>');
        var _tipoPessoaValue = eval('theForm.' + '<%=cdIndicadorPessoaValue.ClientID %>');
        
        var _status = eval('theForm.' + '<%=cdIndicadorStatusPessoa.ClientID %>');
        var _statusValue = eval('theForm.' + '<%=cdIndicadorStatusPessoaValue.ClientID %>');

        var _codigo = eval('theForm.' + '<%=cdPessoaERP.ClientID %>');
        
        var _locked = eval('theForm.' + '<%=cdIndicadorSenhaBloqueadaPessoa.ClientID %>');
        var _lockedValue = eval('theForm.' + '<%=cdIndicadorSenhaBloqueadaPessoaValue.ClientID %>');

        var _tipoAgente = eval('theForm.' + '<%=cdIndicadorTipoAgenteComercialPessoa.ClientID %>');
        var _tipoAgenteValue = eval('theForm.' + '<%=cdIndicadorTipoAgenteComercialPessoaValue.ClientID %>');

        var _msg = "";

        _tipoPessoaValue.value = _tipoPessoa.value.toString();
        _statusValue.value = _status.value.toString();
        _lockedValue.value = _locked.value.toString();
        _tipoAgenteValue.value = _tipoAgente.value.toString();
        
        if (_codigo.value != "") {
            _msg = ValidateInput(_codigo, "Numero");
            if (_msg != "") {
                alert('Campo "Código ERP" não é válido.' + _msg);
                _codigo.focus();
                return false;
            }
        }
        if (_nome.value != "") {
            if (_nome.value.length < 3) {
                alert('Campo "Nome" não é válido.\n\nPelo menos 3 caracteres devem ser informados.');
                _nome.focus();
                return false;
            }
            _msg = ValidateInput(_nome, "Texto");
            if (_msg != "") {
                alert('Campo "Nome" não é válido.' + _msg);
                _nome.focus();
                return false;
            }
        }
        if (_login.value != "") {
            _msg = ValidateInput(_login, "Texto");
            if (_msg != "") {
                alert('Campo "Login" não é válido.' + _msg);
                _login.focus();
                return false;
            }
        }
        if (_cnpjcpf.value != "") {
            if (_cnpjcpf.value.length == 14) {
                _msg = ValidateInput(_cnpjcpf, "Cnpj");
                _tipo = "CNPJ";
            }
            else {
                _msg = ValidateInput(_cnpjcpf, "Cpf");
                _tipo = "CPF";
            }
            if (_msg != "") {
                alert('Campo ' + _tipo + ' não é válido.' + _msg);
                _cnpjcpf.focus();
                return false;
            }
        }
        return true;
    }
</script>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbGenerica_01">
    <tr>
        <td class="tbTd_cinzaEscura" nowrap>
            Código:
        </td>
        <td class="tbTd_CinzaClara">
            <conv:TextBox Type="Numeric" ID="cdPessoaERP" runat="server" Columns="12" MaxLength="30"
                CssClass="campoTexto" ValidationGroup="Filtro" />
        </td>
        <td class="tbTd_cinzaEscura" nowrap>
            Nome:
        </td>
        <td class="tbTd_CinzaClara">
            <conv:TextBox Type="Text" ID="nmFoneticoPessoa" runat="server" Columns="14" MaxLength="70"
                CssClass="campoTexto" ValidationGroup="Filtro" />
        </td>
        <td align="right" rowspan="4" class="tbTd_cinzaEscura" style="padding-right: 20px;">
            <asp:ImageButton runat="server" ID="btPesquisar" Width="15" Height="17" ImageAlign="right" 
                ImageUrl="~/imgsCCAB/tbGrid_operacoesPesquisar.gif" OnClientClick="return chkFields()" 
                ToolTip="pesquisar" ValidationGroup="Filtro" OnClick="btPesquisar_OnClick" />
        </td>
    </tr>
    <tr>
        <td class="tbTd_cinzaEscura">
            Tipo Pessoa:
        </td>
        <td class="tbTd_CinzaClara">
            <asp:HiddenField ID="cdIndicadorPessoaValue" runat="server" />
            <asp:DropDownList ID="cdIndicadorPessoa" runat="server"   
                CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado" 
                DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource3" />
        </td>
        <td class="tbTd_cinzaEscura">
            CNPJ/CPF:
        </td>
        <td class="tbTd_CinzaClara">
            <conv:TextBox Type="Numeric" DecimalPlaces="0" ID="nuCNPJCPFPessoa" ToolTip="Informe o CNPJ (14 dígitos) ou CPF (11 dígitos) incluindo o DV" runat="server" Columns="14" MaxLength="14"
                CssClass="campoTexto" ValidationGroup="Filtro" />
        </td>
    </tr>
    <tr>
        <td class="tbTd_cinzaEscura">
            Login:
        </td>
        <td class="tbTd_CinzaClara">
            <conv:TextBox Type="Text" ID="dsLoginPessoa" runat="server" Columns="12" MaxLength="30"
                CssClass="campoTexto" ValidationGroup="Filtro" />
        </td>
        <td class="tbTd_cinzaEscura">
            Situação:
        </td>
        <td class="tbTd_CinzaClara">
            <asp:HiddenField ID="cdIndicadorStatusPessoaValue" runat="server" />
            <asp:DropDownList ID="cdIndicadorStatusPessoa" runat="server"   
                CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado" 
                DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource1" />
        </td>
    </tr>
    <tr>
        <td class="tbTd_cinzaEscura" nowrap>
            Senha Bloqueada:
        </td>
        <td class="tbTd_CinzaClara">
            <asp:HiddenField ID="cdIndicadorSenhaBloqueadaPessoaValue" runat="server" />
            <asp:DropDownList ID="cdIndicadorSenhaBloqueadaPessoa" runat="server"   
                CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado" 
                DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource2" />
        </td>
        <td class="tbTd_cinzaEscura">
            Tipo Agente:
        </td>
        <td class="tbTd_CinzaClara">
            <asp:HiddenField ID="cdIndicadorTipoAgenteComercialPessoaValue" runat="server" />
            <asp:DropDownList ID="cdIndicadorTipoAgenteComercialPessoa" runat="server"   
                CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado"   
                DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource4" />
        </td>
    </tr> 
</table>
<asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
    <SelectParameters>
        <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORATIVOINATIVO" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
    <SelectParameters>
        <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORSIMNAO" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
    <SelectParameters>
        <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORPESSOA" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="ObjectDataSource4" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
    <SelectParameters>
        <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORTIPOAGENTE" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>
