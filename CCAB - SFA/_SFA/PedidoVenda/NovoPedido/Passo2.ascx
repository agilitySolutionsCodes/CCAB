<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Passo2.ascx.cs" Inherits="_SFA_ConferirPedidoLiberado_NovoPedido_Passo2" %>
<%@ Register Assembly="FarPoint.Web.Spread" Namespace="FarPoint.Web.Spread" TagPrefix="FarPoint" %>

<!-- Área de Mensagens (Desabilitada - display: none - por não estar sendo utilizada) -->
<div style="display: none; margin-bottom: 15px;">
    <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
</div>

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
</div>

<div style="text-align: right; margin-top: 15px;" class="fonteTbCadastro">
    <fieldset style="vertical-align: top; width: 410px; padding: 3px;">
        Valores em <%= _moeda %> &nbsp; 
        <asp:TextBox style="text-align: right;" ID="valorTotal" 
            Width="120" ReadOnly="true" runat="server" Text="0,00" 
            CssClass="campoTexto" />&nbsp;
        <asp:Button ID="btAtualizarValor" Text="Atualizar Valor" Width="130"
            CssClass="button" runat="server" OnClientClick="return compararColunas()" OnClick="AtualizarValor_Click" />
    </fieldset>
    <asp:HiddenField ID="nrMinProdutos" runat="server" />
</div>

<script type="text/javascript">

    var spread = document.getElementById("<%= FpSpread1.ClientID%>");

    function chkQuant() {
        sDecimalPlaces = 1;
        
        row = spread.ActiveRow;
        col = spread.ActiveCol;

        fator = ConvertToNumber(spread.GetValue(spread.ActiveRow, 1));

        cellValue = ConvertToNumber(spread.GetValue(spread.ActiveRow, spread.ActiveCol));

        if (cellValue > 0) {
            if (cellValue < fator || cellValue % fator != 0) {
                alert("Valor deve ser múltiplo da\nQuantidade da Embalagem (" + ConvertToString(fator, sDecimalPlaces) + ")");
                spread.GetCellByRowCol(row, col).innerText = "0,0";
                spread.SetValue(row, col, "0,0", true);
                spread.SetActiveCell(row, col);
            }
            else
                somar();
        }
        spread.ScrollTo(row, col);

        var total = document.getElementById("<%= valorTotal.ClientID%>");
        total.value = "0,00";
    }

    function somar() {
        sDecimalPlaces = 1;
        
        row = spread.ActiveRow;
        col = spread.ActiveCol;

        cellValue = ConvertToNumber(spread.GetValue(spread.ActiveRow, spread.ActiveCol));

        totalValue = ConvertToNumber(spread.GetValue(row, spread.GetColCount() - 1));

        totalValue += cellValue;

        spread.GetCellByRowCol(row, spread.GetColCount() - 1).innerText = ConvertToString(totalValue, sDecimalPlaces);
    }

    function subtrair() {
        sDecimalPlaces = 1;
        
        row = spread.ActiveRow;
        col = spread.ActiveCol;

        cellValue = ConvertToNumber(spread.GetValue(spread.ActiveRow, spread.ActiveCol));

        totalValue = ConvertToNumber(spread.GetValue(row, spread.GetColCount() - 1));

        totalValue -= cellValue;

        spread.GetCellByRowCol(row, spread.GetColCount() - 1).innerText = ConvertToString(totalValue, sDecimalPlaces);
    }

    function compararColunas() {

        rows = spread.GetRowCount();
        cols = spread.GetColCount();
        col = cols - 1;

        if (rows > 0) spread.SetActiveCell(0, col); // ativa a última celula da linha 0

        totalQuant = 0;
        linhasQuant = 0;
        for (row = 0; row < rows; row++) {
            totalQuant += ConvertToNumber(spread.GetValue(row, col));
            if (ConvertToNumber(spread.GetValue(row, col)) != 0)
                linhasQuant++;
        }
        
        if (totalQuant <= 0) {
            alert("Nenhuma Quantidade foi digitada");
            return false;
        }

        var nrMinProd = document.getElementById("<%= nrMinProdutos.ClientID%>");

        if (linhasQuant < nrMinProd.value) {
            alert("É necessário que se informe a quantidade\nde pelo menos " + nrMinProd.value + " produtos para continuar.");
            return false;
        }
         
        row--;
        spread.SetActiveCell(row, col);

        return true;
    }

    function ConvertToNumber(sVlr) {
        sVlr = sVlr.replace(",", ".");
        return parseFloat(sVlr) * 10000;
    }

    function ConvertToString(nVlr, nDecimalPlaces) {
        if (nVlr == 0)
            return "0,0";

        nVlr = nVlr / 10000;

        if (nVlr.toString().indexOf(".") < 0) {
            sInt = nVlr.toString();
            sDec = "0";
        }
        else {
            s = nVlr.toString().split(".");
            sInt = s[0];
            sDec = s[1];
        }

        if (sDec.length > nDecimalPlaces)
            sDec = sDec.substr(0, nDecimalPlaces - 1);

        while (sDec.length < nDecimalPlaces)
            sDec += "0";

        return sInt + "," + sDec;
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

        sDecimalPlaces = 1;

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
                        //for (i = sDecimalPlaces - 1; i >= 0; i--) {
                        for (i = sDecimalPlaces; i >= 1; i--) {
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

        //event.spread.SetActiveCell(event.row, event.col);

        subtrair();
    }

    function FpSpread1_Blur(event) {

        if (event.col == 0) return; // Coluna Nome de Produto

        sValue = event.cell.innerText;
        sValue = sValue.replace(".", ",");
        
        sDecimalPlaces = 1;

        if (sValue == " ") {
            event.cell.innerText = "0,0";
            spread.SetValue(spread.ActiveRow, spread.ActiveCol, "0,0", false);
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
        chkQuant();
    }
</script>