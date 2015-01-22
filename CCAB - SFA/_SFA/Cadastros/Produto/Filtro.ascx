<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Filtro.ascx.cs" Inherits="_SFA_Produto_Filtro" %>

<script type="text/javascript" src="../../../scripts/JScript.js"></script>
<script type="text/javascript">
    function chkFields() {
        var _codigo = eval('theForm.' + '<%=cdProdutoERP.ClientID %>');
        var _descr = eval('theForm.' + '<%=dsProduto.ClientID %>');
        var _liberado = eval('theForm.' + '<%=cdIndicadorLiberadoPedidoProduto.ClientID %>');
        var _liberadoValue = eval('theForm.' + '<%=cdIndicadorLiberadoPedidoProdutoValue.ClientID %>');
        var _msg = "";

        _liberadoValue.value = _liberado.value.toString();

        if (_codigo.value != "") {
            _msg = ValidateInput(_codigo, "Texto");
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
            <conv:TextBox Type="Text" ID="cdProdutoERP" runat="server" Columns="20" MaxLength="30" CssClass="campoTexto" ValidationGroup="Filtro" Width="150" />
        </td>
        <td class="tbTd_cinzaEscura" nowrap>
            Descrição:
        </td>
        <td class="tbTd_CinzaClara">
            <conv:TextBox Type="Text" ID="dsProduto" runat="server" Columns="20" MaxLength="70" CssClass="campoTexto" ValidationGroup="Filtro" Width="150"/>
        </td>         
        <td class="tbTd_cinzaEscura"> 
            Liberado:   
        </td>
        <td class="tbTd_CinzaClara">  
            <asp:HiddenField ID="cdIndicadorLiberadoPedidoProdutoValue" runat="server" />
            <asp:DropDownList ID="cdIndicadorLiberadoPedidoProduto" runat="server" CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado" DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource1" /> 
        </td>
        <td align="right" class="tbTd_cinzaEscura" style="padding-right: 20px;" rowspan="2">
            <asp:ImageButton runat="server" ID="btPesquisar" Width="15" Height="17" ImageAlign="right" 
                ImageUrl="~/imgsCCAB/tbGrid_operacoesPesquisar.gif" OnClientClick="return chkFields()" 
                ToolTip="pesquisar" ValidationGroup="Filtro" OnClick="btPesquisar_OnClick" />
        </td>
    </tr>
    <tr>
         <td class="tbTd_cinzaEscura"> 
            Tipo:   
        </td>
        <td class="tbTd_CinzaClara">  
            <asp:HiddenField ID="hiddenFieldTipoProduto" runat="server" />
            <asp:DropDownList ID="dropDownListTipoProduto" Width="155" runat="server" CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado" DataTextField="wkDominioCodigoReferenciado" DataSourceID="dataSourceTipoProduto" />        
        </td>    
        <td class="tbTd_cinzaEscura">&nbsp;</td>
        <td class="tbTd_CinzaClara">&nbsp;</td>  
        <td class="tbTd_cinzaEscura" style="display:none"> 
            Fornecedor:   
        </td>
        <td class="tbTd_CinzaClara"  style="display:none">  
            <asp:HiddenField ID="hiddenFieldFornecedor" runat="server" />
                <asp:DropDownList ID="dropDownListFornecedor" Width="155" runat="server"  CssClass="campoTexto" DataValueField="cdPessoaOrigemFaturamento" DataTextField="dsPessoaOrigemFaturamento" DataSourceID="dataSourceFornecedor" />              
        </td>   
        <td class="tbTd_cinzaEscura">&nbsp;</td>
        <td class="tbTd_CinzaClara">&nbsp;</td>
    </tr>
</table>

<asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
    <SelectParameters>
        <asp:Parameter  Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORSIMNAO" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>

 <asp:ObjectDataSource ID="dataSourceFornecedor" runat="server" SelectMethod="ObterListaOrigemFaturamento" TypeName="Pessoa">
    <SelectParameters>
        <asp:Parameter Name="cdIndicadorStatusPessoa" Type="Int64" />
    </SelectParameters>
</asp:ObjectDataSource>


<asp:ObjectDataSource ID="dataSourceTipoProduto" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
    <SelectParameters>
        <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPTIPOPRODUTO" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>




