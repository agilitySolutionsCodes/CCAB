<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Filtro.ascx.cs" Inherits="_SFA_TipoCultura_Filtro" %>

<script type="text/javascript" src="../../../scripts/JScript.js"></script>
<script type="text/javascript">
    function chkFields() {
        var _codigo = eval('theForm.' + '<%=cdTipoCulturaSEQ.ClientID %>');
        var _descr = eval('theForm.' + '<%=dsTipoCultura.ClientID %>');
        var _status = eval('theForm.' + '<%=cdIndicadorStatusTipoCultura.ClientID %>');
        var _statusValue = eval('theForm.' + '<%=cdIndicadorStatusTipoCulturaValue.ClientID %>');
        var _msg = "";

        _statusValue.value = _status.value.toString();

        if (_codigo.value != "") {
            _msg = ValidateInput(_codigo, "Numero");
            if (_msg != "") {
                alert('Campo "Código" não é válido.' + _msg);
                _codigo.focus();
                return false;
            }
        }
        if (_descr.value != "") {
            if (_descr.value.length < 3) {
                alert('Campo "Descrição" não é válido.\n\nPelo menos 3 caracteres devem ser informados.');
                _descr.focus();
                return false;
            }
            _msg = ValidateInput(_descr, "Texto");
            if (_msg != "") {
                alert('Campo "Descrição" não é válido.' + _msg);
                _descr.focus();
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
            <conv:TextBox Type="Text" ID="cdTipoCulturaSEQ" runat="server" Columns="20" MaxLength="30"
                CssClass="campoTexto" ValidationGroup="Filtro" />
        </td>
        <td class="tbTd_cinzaEscura" nowrap>
            Descrição:
        </td>
        <td class="tbTd_CinzaClara">
            <conv:TextBox Type="Text" ID="dsTipoCultura" runat="server" Columns="20" MaxLength="70"
                CssClass="campoTexto" ValidationGroup="Filtro" />
        </td>
        <td class="tbTd_cinzaEscura"> 
            Situação:   
        </td>
        <td class="tbTd_CinzaClara">  
            <asp:HiddenField ID="cdIndicadorStatusTipoCulturaValue" runat="server" />
            <asp:DropDownList ID="cdIndicadorStatusTipoCultura" runat="server"   
                CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado" 
                DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource1" /> 
        </td>
        <td align="right" class="tbTd_cinzaEscura" style="padding-right: 20px;">
            <asp:ImageButton runat="server" ID="btPesquisar" Width="15" Height="17" ImageAlign="right" 
                ImageUrl="~/imgsCCAB/tbGrid_operacoesPesquisar.gif" OnClientClick="return chkFields()" 
                ToolTip="pesquisar" ValidationGroup="Filtro" OnClick="btPesquisar_OnClick" />
        </td>
    </tr>
</table>
<asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
    <SelectParameters>
        <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORATIVOINATIVO" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>
