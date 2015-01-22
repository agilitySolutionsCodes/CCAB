<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_TabelaPreco_Resultado" %>
<%@ Register Assembly="FarPoint.Web.Spread" Namespace="FarPoint.Web.Spread" TagPrefix="FarPoint" %>

<script language="javascript" type="text/javascript">

    function ExibirRelatorioTabelaPreco(pCdPessoaSEQ, pCdCronogramaSafraSEQ, pCdTipoProduto)
    {
        window.open("./../../Relatorios/TabelaPreco.aspx?cdPessoaSEQ=" + pCdPessoaSEQ + "&cdCronogramaSafraSEQ=" + pCdCronogramaSafraSEQ + "&cdTipoProduto=" + pCdTipoProduto, "TabelaPreco", "toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=700,height=500,left=100,top=50");
	    return true;
    }


    function chkFields(obj) {

        if(obj.style.cursor == 'wait') return false; 
        
        var _cooperativa = eval('theForm.' + '<%=cdPessoaCooperativaSEQ.ClientID %>');
        var _cooperativaValue = eval('theForm.' + '<%=cdPessoaCooperativaSEQValue.ClientID %>');

        var _safra = eval('theForm.' + '<%=cdCronogramaSafraSEQ.ClientID %>');
        var _safraValue = eval('theForm.' + '<%=cdCronogramaSafraSEQValue.ClientID %>');
        
        _cooperativaValue.value = _cooperativa.value.toString();
        _safraValue.value = _safra.value.toString();

        if (_cooperativaValue.value == "0" || _safraValue.value == "0") {
            alert("Cooperativa e Safra devem ser informados");
            return false;
        }

        //var spread = document.getElementById("<%= FpSpread1.ClientID%>");
        if (typeof messageDiv == "object")
            messageDiv.style.display = 'none';
        else
            spreadDiv.style.display = 'none';
        
        obj.style.cursor = 'wait';
        
        return true;
    }

    function SaveSpread(obj) {

        if (obj.style.cursor == 'wait') return false;
        spreadDiv.style.display = 'none';
        obj.style.cursor = 'wait';

        return true;
    }
    
    function FpSpread1_Focus(event) {

        // Não processa colunas bloqueadas
        if (event.spread.GetCellByRowCol(event.row, event.col).getAttribute("FpCellType") == "readonly")
            return;
  
        sValue = event.cell.innerText;
      
        sDecimalPlaces = 4;

        while (sValue.indexOf(".") > 0)
            sValue = sValue.replace(".", "");

        sValue = sValue.replace(",", "");

        if (isNaN(sValue) || sValue == "")
            _value = "";
        else {
            if (sDecimalPlaces == 0)
                _value = sValue;
            else {
                sInt = sValue.substr(0, sValue.length - sDecimalPlaces);
                sDec = sValue.substr(sValue.length - sDecimalPlaces, sValue.length);

                if (parseFloat(sDec) == 0)
                    _value = parseFloat(sInt);
                else {
                    if (parseFloat(sInt) != 0) {
                        for (i = sDecimalPlaces - 1; i >= 0; i--) {
                            if (sDec.substr(i, 1) == "0")
                                sDec = sDec.substr(0, i);
                        }
                    }
                    else {
                        sInt = "0";
                        sDec = parseFloat(sDec).toString();
                        while (sDec.length < sDecimalPlaces)
                            sDec = "0" + sDec;
                    }
                    _value = sInt + "," + sDec;
                }
            }
        }

        event.cell.innerText = _value;
        
        //event.spread.SetActiveCell(event.row, event.col)    
    }

    function FpSpread1_Blur(event) {

        if (event.col == 0) return; // Coluna Nome de Produto

        sValue = event.cell.innerText;
        
        /////////// Novo bloco... /////////////////
        sValue = sValue.replace(".", ",");      
        caracteresValidos = '1234567890,';
        sAux = "";
        _valid = false;
        for (n = 0; n < sValue.length ; n++) {
            _char = sValue.substr(n, 1);
            if (caracteresValidos.indexOf(_char) >= 0)
                if (!isNaN(_char)) _valid = true;
                if(_valid)
                    sAux += _char;
        }
        sValue = sAux;
        ///////////////////////////////////////////
        
        sDecimalPlaces = 4;
        
        if (sValue == " " || sValue == "") {
            event.cell.innerText = "0,0000";
            spread.SetValue(spread.ActiveRow, spread.ActiveCol, "0,0000", false);
            return;
        }

        if (sDecimalPlaces == 0) {
            if (sValue.length > 3) {
                sAux = "";
                j = 0;
                for (i = sValue.length - 1; i >= 0; i--) {
                    sAux = sValue.substr(i, 1) + sAux;
                    j++;
                    if (j == 3 && i != 0) {
                        sAux = "." + sAux;
                        j = 0;
                    }
                }
            }
            else
                sAux = sValue;

            return sAux;
        }
        else {
            if (sValue.indexOf(",") <= 0) {
                sInt = sValue;
                sDec = "000000000000".substr(0, sDecimalPlaces);
            }
            else {
                sInt = sValue.substr(0, sValue.indexOf(","));
                sDec = sValue.substr(sValue.indexOf(",") + 1, sValue.length);
                if (sDec.length < sDecimalPlaces)
                    sDec = (sDec + "000000000000");
                    
                sDec = sDec.substr(0, sDecimalPlaces);
            }

            if (sInt.length > 3) {
                sAux = "";
                j = 0;
                for (i = sInt.length - 1; i >= 0; i--) {
                    sAux = sInt.substr(i, 1) + sAux;
                    j++;
                    if (j == 3 && i != 0) {
                        sAux = "." + sAux;
                        j = 0;
                    }
                }
            }
            else
                sAux = sInt;

            event.cell.innerText = sAux + "," + sDec;
            //spread.SetValue(spread.ActiveRow, spread.ActiveCol, sAux + "," + sDec, false); 
        }
    }

</script>

<div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbGenerica_01">
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Cooperativa:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:HiddenField ID="cdPessoaCooperativaSEQValue" runat="server" />
                <asp:DropDownList ID="cdPessoaCooperativaSEQ" runat="server"   
                    CssClass="campoTexto" DataValueField="cdPessoaSEQ" Width="350"  
                    DataTextField="dsPessoa" DataSourceID="ObjectDataSource1"
                     
                    AutoPostBack="true" onprerender="cdPessoaCooperativaSEQ_PreRender" 
                    onselectedindexchanged="cdPessoaCooperativaSEQ_SelectedIndexChanged" />                    
            </td>
            <td class="tbTd_cinzaEscura" nowrap>
                Safra:
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
                    DataTextField="dsCronogramaSafra" DataSourceID="ObjectDataSource2" 
                    AutoPostBack="True" 
                    onselectedindexchanged="cdCronogramaSafraSEQ_SelectedIndexChanged" 
                    />
            </td>
            <td align="right" class="tbTd_cinzaEscura" style="padding-right: 20px;" rowspan="2">
                <asp:ImageButton runat="server" ID="btPesquisar" Width="15" Height="17" ImageAlign="right" 
                    ImageUrl="~/imgsCCAB/tbGrid_operacoesPesquisar.gif" OnClientClick="return chkFields(this)" 
                    ToolTip="pesquisar" ValidationGroup="Filtro" OnClick="btPesquisar_Click" />
            </td>
        </tr>
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>Regra Produto:</td>
            <td class="tbTd_CinzaClara"><asp:DropDownList ID="dropDownListRegraProduto" Width="155" runat="server" CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado" DataTextField="wkDominioCodigoReferenciado" DataSourceID="dataSourceTipoProduto" /></td>
            <td class="tbTd_cinzaEscura" nowrap>&nbsp;</td>
            <td class="tbTd_CinzaClara">&nbsp;</td>            
        </tr>
    </table>
    
</div>

<br />

<!-- Área de Mensagens -->
<div>
    <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
    <asp:Label ID="lblMensagem" runat="server" Visible="false" style="color:Red"></asp:Label>
</div>

<br />

<%if(!_successMsg){ %>
<div id="spreadDiv">
    <FarPoint:FpSpread ID="FpSpread1" runat="server" ActiveSheetViewIndex="0" 
        Visible="false">
        <Sheets>
            <FarPoint:SheetView SheetName="Sheet1" /> 
        </Sheets>
        <Pager />
        <ClientEvents EditStart="FpSpread1_Focus" />
        <ClientEvents EditStopped="FpSpread1_Blur" />
    </FarPoint:FpSpread>
    <br />
    <div style="margin-top: 15px; text-align: right;">
        <asp:Button runat="server" Visible="false" ID="btExcluir" 
            OnClientClick="return confirm('Deseja realmente excluir a Tabela de Preço?');" 
            CssClass="button" Text="Excluir" onclick="btExcluir_Click"/>
        <asp:Button runat="server" Visible="false" ID="btImprimir"
            CssClass="button" Text="Imprimir" onclick="btImprimir_Click"/>
        <asp:Button runat="server" Visible="false" ID="btSalvar" OnClientClick="return SaveSpread(this)"
            CssClass="button" Text="Salvar" OnClick="btSalvar_Click" />  
    </div>
</div>

<asp:UpdateProgress ID="UpdateProgress1" runat="server">
    <ProgressTemplate>
        <div>
            <asp:Image runat="server" ImageAlign="AbsMiddle" ImageUrl="~/imgsCCAB/wait.gif" />
        </div>
        <br />
        <div>
            Aguarde... Em execução.
        </div>
    </ProgressTemplate>
</asp:UpdateProgress>

<div style="display: none;">
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="ObterListaOnDemandERP" TypeName="Pessoa">
        <SelectParameters>
            <asp:Parameter Name="cdIndicadorTipoPerfilPessoa" DefaultValue="3" Type="Int32" />
            <asp:SessionParameter SessionField="cdUsuario" Name="cdUsuarioUltimaAlteracao" Type="Int64" />
            <asp:Parameter Name="cdIndicadorTipoAgenteComercialPessoa" DefaultValue="1" Type="Int32" />
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
    
    <asp:ObjectDataSource ID="dataSourceTipoProduto" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPTIPOPRODUTO" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <asp:ObjectDataSource ID="ObjectDataSourcePrincipioAtivo" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPTIPOPRODUTOPRECO1" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <asp:ObjectDataSource ID="ObjectDataSourceProdutoAcabado" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPTIPOPRODUTOPRECO2" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
</div>            

<%}
  else
  {%>
<div id="messageDiv">
    <div class="tbCadastro_Mestra">
        <h2 style="color: #808080">
            Tabela de Preços atualizada com sucesso.
        </h2>
    </div> 
</div>

<asp:UpdateProgress ID="UpdateProgress2" runat="server">
    <ProgressTemplate>
        <div>
            <asp:Image ID="Image1" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/imgsCCAB/wait.gif" />
        </div>
        <br />
        <div>
            Aguarde... Em execução.
        </div>
    </ProgressTemplate>
</asp:UpdateProgress>

<%} %>