<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Filtro.ascx.cs" Inherits="_SFA_Colaborador_Filtro" %>
<%@ Register TagPrefix="uc" TagName="OnDemandSearch" Src="~/Comum/OnDemandSearch/OnDemandSearch.ascx" %>

<script type="text/javascript" src="../../../scripts/JScript.js"></script>
<script type="text/javascript">
    function chkFields() {
        var _cpf = eval('theForm.' + '<%=nuCNPJCPFPessoa.ClientID %>');
        
        var _login = eval('theForm.' + '<%=dsLoginPessoa.ClientID %>');

        var _nome = eval('theForm.' + '<%=nmFoneticoPessoa.ClientID %>');

        var _perfil = eval('theForm.' + '<%=cdIndicadorTipoPerfilPessoa.ClientID %>');
        var _perfilValue = eval('theForm.' + '<%=cdIndicadorTipoPerfilPessoaValue.ClientID %>');
        
        var _status = eval('theForm.' + '<%=cdIndicadorStatusPessoa.ClientID %>');
        var _statusValue = eval('theForm.' + '<%=cdIndicadorStatusPessoaValue.ClientID %>');

        var _codigo = eval('theForm.' + '<%=cdPessoaERP.ClientID %>');
        
        var _locked = eval('theForm.' + '<%=cdIndicadorSenhaBloqueadaPessoa.ClientID %>');
        var _lockedValue = eval('theForm.' + '<%=cdIndicadorSenhaBloqueadaPessoaValue.ClientID %>');

        var _empresa = eval('theForm.' + '<%=cdEmpresaColaboradorPessoa.ClientID %>');
        var _empresaValue = eval('theForm.' + '<%=cdEmpresaColaboradorPessoaValue.ClientID %>');

        var _msg = "";

        _perfilValue.value = _perfil.value.toString();
        _statusValue.value = _status.value.toString();
        _lockedValue.value = _locked.value.toString();
        _empresaValue.value = _empresa.value.toString();
        
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
        if (_cpf.value != "") {
            _msg = ValidateInput(_cpf, "Cpf");
            if (_msg != "") {
                alert('Campo "CPF" não é válido.' + _msg);
                _cpf.focus();
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
            Perfil:
        </td>
        <td class="tbTd_CinzaClara">
            <asp:HiddenField ID="cdIndicadorTipoPerfilPessoaValue" runat="server" />
            <asp:DropDownList ID="cdIndicadorTipoPerfilPessoa" runat="server"   
                CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado" 
                DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource3" />
        </td>
        <td class="tbTd_cinzaEscura">
            CPF:
        </td>
        <td class="tbTd_CinzaClara">
            <conv:TextBox Type="Numeric" DecimalPlaces="0" ID="nuCNPJCPFPessoa" ToolTip="Informe o CPF (11 dígitos) incluindo o DV" runat="server" Columns="11" MaxLength="11"
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
        <td class="tbTd_cinzaEscura">
            Empresa:
        </td>
        <td class="tbTd_CinzaClara">
            <asp:HiddenField ID="cdEmpresaColaboradorPessoaValue" runat="server" />
            <asp:DropDownList ID="cdEmpresaColaboradorPessoa" runat="server"   
                CssClass="campoTexto" DataValueField="cdPessoaSEQ" Width="350"
                DataTextField="dsPessoa" DataSourceID="ObjectDataSource4" />
        </td>
        <td class="tbTd_cinzaEscura" nowrap>
            Senha Bloqueada:
        </td>
        <td class="tbTd_CinzaClara">
            <asp:HiddenField ID="cdIndicadorSenhaBloqueadaPessoaValue" runat="server" />
            <asp:DropDownList ID="cdIndicadorSenhaBloqueadaPessoa" runat="server"   
                CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado" 
                DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource2" />
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
        <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORTIPOPERFILCOLABORADOR" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="ObjectDataSource4" runat="server" SelectMethod="ObterListaOnDemandERP" TypeName="Pessoa">
    <SelectParameters>
        <asp:Parameter Name="cdIndicadorTipoPerfilPessoa" DefaultValue="3" Type="Int32" />
        <asp:SessionParameter SessionField="cdUsuario" Name="cdUsuarioUltimaAlteracao" Type="Int64" />
        <asp:Parameter Name="cdIndicadorTipoAgenteComercialPessoa" DefaultValue="0" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
