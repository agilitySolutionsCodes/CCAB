/*
----------------------------
Scripts - Client Side Utils
Hélcio Bertolin, 2003 - 2009
----------------------------
*/


function MascararData(data) 
{
    if (ValidarInteiroInterno(data) == false) 
    {
        event.returnValue = false;
    }
    return FormatarCampo(data, '00/00/0000', event); 
}

function ValidarInteiroInterno() 
{
    if (event.keyCode < 48 || event.keyCode > 57) 
    {
        event.returnValue = false; return false;
    } 
    return true;
}

function FormatarCampo(campo, Mascara, evento) 
{         
    var boleanoMascara;                 
    var Digitato = evento.keyCode;        
    exp = /\-|\.|\/|\(|\)| /g   
    campoSoNumeros = campo.value.toString().replace( exp, "" );            
    var posicaoCampo = 0;            
    var NovoValorCampo="";        
    var TamanhoMascara = campoSoNumeros.length;                
    if (Digitato != 8) 
    { 
        // backspace                 
        for(i=0; i<= TamanhoMascara; i++) 
        {                         
            boleanoMascara  = ((Mascara.charAt(i) == "-") || (Mascara.charAt(i) == ".")                                                                
                                                            || (Mascara.charAt(i) == "/"))                         
                                                            boleanoMascara  = boleanoMascara || ((Mascara.charAt(i) == "(")
                                                            || (Mascara.charAt(i) == ")") || (Mascara.charAt(i) == " "))

            if (boleanoMascara) 
            {
                NovoValorCampo += Mascara.charAt(i);
                TamanhoMascara++;
            }
            else 
            {
                NovoValorCampo += campoSoNumeros.charAt(posicaoCampo);
                posicaoCampo++;
            }
        }

        campo.value = NovoValorCampo;

        return true;
    }
    else 
    {
        return true;
    }
}

function RestringirInteiro(Objeto) 
{
    var lvDigitos = "0123456789"
    var lvObjetoTemp
    for (var i = 0; i < Objeto.value.length; i++) 
    {
        lvObjetoTemp = Objeto.value.substring(i, i + 1)
        if (lvDigitos.indexOf(lvObjetoTemp) == -1) 
        {
            Objeto.value = Objeto.value.substring(0, i);
        }
    }
}
            
function blocTexto(objeto, maximo) 
{
    valor = objeto.value;
    quant = maximo;
    total = valor.length;

    if (total > quant) 
    {
        objeto.value = objeto.value.substring(0, quant);
    }
}

function isDate(sData) {
    if (sData == "")
        return false;

    s_dia = sData.substr(0, 2);
    s_mes = sData.substr(3, 2);
    s_ano = sData.substr(6, 4);

    i_mes = parseFloat(s_mes) - 1;

    var oData = new Date(s_ano, i_mes, s_dia);

    if (oData.getMonth() != i_mes || parseFloat(s_ano) < 1900 || s_ano == "")
        return false;

    return true;

}

function isMod11(sNumero) { 
    if (sNumero == "") 
        return false;
    /*
    if (sNumero.length == 14) {
        sTipo = "CPF" 
        iNum = sNumero.substr(0, 3) + sNumero.substr(4, 3) + sNumero.substr(8, 3);
        iDig = sNumero.substr(12, 2);
    }
    else {
        sTipo = "CNPJ"
        iNum = sNumero.substr(0, 2) + sNumero.substr(3, 3) + sNumero.substr(7, 3) + sNumero.substr(11, 4);
        iDig = sNumero.substr(16, 2);
    }
    */
    
    if (sNumero.length == 11) {
        sTipo = "CPF" 
        iNum = sNumero.substr(0, 9);
        iDig = sNumero.substr(9, 2);
    }
    else {
        sTipo = "CNPJ" 
        iNum = sNumero.substr(0, 12);
        iDig = sNumero.substr(12, 2);
    }
    
    for (n = 1; n <= 2; n++) {
        if (sTipo == "CPF")
            indice = (n == 1 ? 10 : 11);
        else
            indice = (n == 1 ? 5 : 6);     // CNPJ

        soma = 0;

        for (i = 0; i <= iNum.length - 1; i++) {
            soma += parseInt(iNum.substr(i, 1) * indice);
            indice--;
            if (indice == 1)
                indice = 9;
        }

        if (n == 1)
            dig1 = (soma % 11 < 2 ? 0 : 11 - (soma % 11));
        else
            dig2 = ((soma + (dig1 * 2)) % 11 < 2 ? 0 : 11 - ((soma + (dig1 * 2)) % 11));
    }

    return (dig1 != iDig.substr(0, 1) || dig2 != iDig.substr(1, 1) ? false : true);
}

function ValidateInput(ctrl, _type)
{
    var msg = "";
    var RegExpString = null;
    var _mask = "";
    
    // Validação por tipo de conteúdo (máscara)
    switch (_type)
    {
        case "Email":
        {
            RegExpString = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
            _mask = "usuario@dominio.com.br";
            break;
        }
        case "Url":
        {
            RegExpString = /http:\/\/([\w-]+\.)+[\w-]+(\/[\w- ./?&=]*)?/;
            _mask = "http://www.dominio.com.br";
            break;
        }
        case "Cep":
        {
            RegExpString = /\d{8}/; //    /\d{5}-\d{3}/;
            _mask = "99999999";
            break;
        }
        case "Cnpj":
        {
            RegExpString = /\d{14}/;    //     /\d{2}.\d{3}.\d{3}\/\d{4}-\d{2}/;
            _mask = "99999999999999";
            break;
        }
        case "Cpf":
        {
            RegExpString = /\d{11}/;   //      /\d{3}.\d{3}.\d{3}-\d{2}/;
            _mask = "99999999999";
            break;
        }
        case "Fone":
        {
            RegExpString = /\(\d{2}\)\d{4}-\d{4}/;
            _mask = "(99)9999-9999";
            break;
        }
        case "Data":
        {
            RegExpString = /\d{2}\/\d{2}\/\d{4}/;
            _mask = "99/99/9999";
            break;
        }
        case "Moeda":
        {
            RegExpString = /\d+([-+.]\d+)*,\d{2}/;
            _mask = "999.999.999,99";
            break;
        }
        case "Texto":
        {
            if(ctrl.value.indexOf('"') >=0 || ctrl.value.indexOf("'") >=0)
            {
                msg = "\n\nNão é permitida a presença de aspas\nou apóstrofes no conteúdo do campo!";
                return msg;
            }
            break;
        }
        case "Numero":
        {
            RegExpString = /\d+/;
            _mask = "999999";
            break;
        }
        default:
            RegExpString = null;
    }

    var matches = ctrl.value.match(RegExpString);

    if(_type != "Texto")
    {
        if (matches != null && ctrl.value == matches[0]) // Formato OK
        {
            if(_type == "Data") // Validação de Data por algoritmo
                if(!isDate(ctrl.value))
                    msg = " ";

            if(_type == "Cpf")
                if (ctrl.value.length == 11) 
                    if(!isMod11(ctrl.value)) // Validação de CPF por algoritmo
                        msg = " ";
                        
            if(_type == "Cnpj")
                if(!isMod11(ctrl.value)) // Validação de CPF/CNPJ por algoritmo
                    msg = " ";
        }
        else
            msg = (_type == "Texto" ? "" : "\n\nUtilize o Formato: " + _mask);
    }

    return msg;
}

function textConvert(ctrl, _type)
{
    if(_type=='AllLower')
    {
        ctrl.value = ctrl.value.toLowerCase()
        return true;
    }

    if(ctrl.conv=='AllUpper')
    {
        ctrl.value = ctrl.value.toUpperCase()
        return true;
    }

    // _type=='FirstCap'
    strParts = ctrl.value.toLowerCase().split(" ");
    ctrl.value = "";
    nIndex = strParts.length - 1

    for(n=0;n<=nIndex;n++)
    {
        if(strParts[n] == "da" || strParts[n] == "das" ||
            strParts[n] == "de" || strParts[n] == "del" ||
            strParts[n] == "dela" || strParts[n] == "di" ||
            strParts[n] == "do" || strParts[n] == "dos")

            ctrl.value += strParts[n] + (n<nIndex ? " " : "");

        else

            if(strParts[n] == "ii" || strParts[n] == "iii" ||
                strParts[n] == "iv" || strParts[n] == "vi" ||
                strParts[n] == "vii" || strParts[n] == "viii" ||
                strParts[n] == "ix" || strParts[n] == "xi" ||
                strParts[n] == "xii" || strParts[n] == "xiii" ||
                strParts[n] == "xiv" || strParts[n] == "xv" ||
                strParts[n] == "xvi" || strParts[n] == "xvii" ||
                strParts[n] == "xviii" || strParts[n] == "xix" ||
                strParts[n] == "xx" || strParts[n] == "xxi" ||
                strParts[n] == "xxii" || strParts[n] == "xxiii" ||
                strParts[n] == "xxiv" || strParts[n] == "xxv")

                ctrl.value += strParts[n].toUpperCase() + (n<nIndex ? " " : "");

            else

                ctrl.value += strParts[n].substr(0,1).toUpperCase() + strParts[n].substr(1,strParts[n].length-1) + (n<nIndex ? " " : "");
    }

    return true;
}

function jsValor(sVlr)
{
    sVlr = sVlr.replace(".","");
    sVlr = sVlr.replace(",","");
    if(isNaN(sVlr) || sVlr=="") sVlr = "000";
	return parseFloat(sVlr);
}

function FormatNum(sNumero)
{
	sInt = sNumero.substr(0, sNumero.length-2);
    sDec = sNumero.substr(sNumero.length-2, sNumero.length);
	if(sInt.length > 3)
	{
		sAux = "";
		j = 0;
		for(i = sInt.length - 1; i >= 0; i-- )
		{
			sAux = sInt.substr(i,1) + sAux;
			j++;
			if(j == 3 && i != 0)
			{
				sAux = "." + sAux;
				j = 0;
			}
		}
	}
    else
        sAux = sInt;
	return sAux + "," + sDec;
}

///////////////////////////////////////////////////////////////
// ConvWebControls Scripts  
// Incluir no topo da página que utilizará os controles:     
// <script type="text/javascript" src="../../../scripts/JScript.js"></script>
/////////////////////////////////////////////////////////////

function avoidEnter()
{
    if(event.keyCode == 13)
    {   
        event.cancelBubble = true; 
        event.returnValue = false;
    }
}
 
function formatValue(obj)
{
    sValue = obj.value;
    sDecimalPlaces = obj.DecimalPlaces;

    if(sValue == "" && obj.IsRequired)
    {
        this.IsValid = false;
        return "";
    }
    
    if(sDecimalPlaces == "0")
    {
        if(sValue.length > 3)
	    {
		    sAux = "";
		    j = 0;
		    for(i = sValue.length - 1; i >= 0; i-- )
		    {
			    sAux = sValue.substr(i,1) + sAux;
			    j++;
			    if(j == 3 && i != 0)
			    {
				    sAux = "." + sAux;
				    j = 0;
			    }
		    }
	    }
        else
            sAux = sValue;
        
        return sAux;
    }
    else
    {
	    if(sValue.indexOf(",") <= 0)
	    {
	        sInt = sValue;
	        sDec = "000000000000".substr(0, sDecimalPlaces);
	    }
	    else
	    {
	        sInt = sValue.substr(0, sValue.indexOf(","));
            sDec = sValue.substr(sValue.indexOf(",")+1, sValue.length);
            if (sDec.length < sDecimalPlaces)
                    sDec = (sDec + "000000000000");
                    
                sDec = sDec.substr(0, sDecimalPlaces);
        }
                  
	    if(sInt.length > 3)
	    {
		    sAux = "";
		    j = 0;
		    for(i = sInt.length - 1; i >= 0; i-- )
		    {
			    sAux = sInt.substr(i,1) + sAux;
			    j++;
			    if(j == 3 && i != 0)
			    {
				    sAux = "." + sAux;
				    j = 0;
			    }
		    }
	    }
        else
            sAux = sInt;
	    return sAux + "," + sDec;
	}
}

function unFormatValue(obj)
{   
    sValue = obj.value;
    sDecimalPlaces = obj.DecimalPlaces;
    
    while(sValue.indexOf(".")>0)
        sValue = sValue.replace(".","");
        
    sValue = sValue.replace(",","");
    
    if(isNaN(sValue) || sValue=="") 
        return "";
    else
    {   
        if(sDecimalPlaces == "0")
            return sValue;
        else
        {
            sInt = sValue.substr(0, sValue.length-sDecimalPlaces);
            sDec = sValue.substr(sValue.length-sDecimalPlaces, sValue.length);

            if (parseFloat(sDec) == 0)
                return sInt; 
            else 
            {
                for (i = sDecimalPlaces - 1; i >= 0; i--) {
                    if (sDec.substr(i, 1) == "0")
                        sDec = sDec.substr(0, i);
                }
            } 
	        
	        return sInt + "," + sDec;
	    }
	}
}

function validateKeys(obj)
{   
    sValue = obj.value;
    sDecimalPlaces = obj.DecimalPlaces;
    
    if(event.keyCode!=8 && 
       event.keyCode!=0 && 
       event.keyCode!=44 && 
       (event.keyCode<48 || event.keyCode>57))
    {
        event.cancelBubble = true; 
        event.returnValue = false;
    }
    
    if(event.keyCode==44)
    {
        if(sDecimalPlaces == "0")
        {
            event.cancelBubble = true; 
            event.returnValue = false;
        }
        
        if(sValue.length==0 || sValue.indexOf(",")>0)
        {
            event.cancelBubble = true; 
            event.returnValue = false;
        }
    }
    
    if(sValue.indexOf(",") > 0)
	{
        sDec = sValue.substr(sValue.indexOf(","), sValue.length);
        if (sDec.length > sDecimalPlaces)
        {
            event.cancelBubble = true; 
            event.returnValue = false;
        }        
    }
}

function validateStrictText(obj) {

    var valid = true;
    var caracteresValidos = 'àèìòùâêîôûäëïöüáéíóúãõÀÈÌÒÙÂÊÎÔÛÄËÏÖÜÁÉÍÓÚÃÕçÇ ';
    
    var _char = String.fromCharCode(event.keyCode);
    
    if (caracteresValidos.indexOf(_char) == -1) {
        if (event.keyCode < 65)
            valid = false;
        else 
        {
            if(event.keyCode > 90 && event.keyCode < 97)
                valid = false;
            else
            {
                if(event.keyCode > 122)
                    valid = false;
            }
        }
    }
                
    if(!valid)
    {            
        event.cancelBubble = true;
        event.returnValue = false;
    }
}

function chkDate(obj)
{
    if(event.keyCode < 48 || event.keyCode > 57)
    {
        event.cancelBubble = true; 
        event.returnValue = false;
    }
    
    sValue = obj.value;
    if(sValue.length == 2 || sValue.length == 5) 
    {
        sValue += "/";
        obj.value = sValue;
    }
}
 
function formatDate(obj)
{
    var Date = unFormatDate(obj); //obj.value.toString();
    var Date2 = Date;
        
    if(Date.length == 8)
    {
        Date = Date2.charAt(0)+ Date2.charAt(1) + "/";
        Date += Date2.charAt(2)+ Date2.charAt(3) + "/"
        Date += Date2.charAt(4)+ Date2.charAt(5)+Date2.charAt(6)+ Date2.charAt(7);
    }
    else
        Date = "Data Inválida";
      
    return Date;
}

function unFormatDate(obj)
{    
    sValue = obj.value;
    
    while(sValue.indexOf("/")>0)
        sValue = sValue.replace("/","");
        
    return sValue;
}

////////////////////////////////////////
// TreeViewTipoAtivo
////////////////////////////////////////
function NodeClick(_AssocObj, _DispObj, _PersistentObj, _nodeValue, _nodeText) {
    var _tipoAtivoValue = eval(_AssocObj);
    _tipoAtivoValue.value = _nodeValue;
  
    var _tipoAtivoText = eval(_DispObj); 
    _tipoAtivoText.value = _nodeText;
    
    if(_PersistentObj != "")
    {
        var _persistText = eval(_PersistentObj); 
        _persistText.value = _nodeText;
    }
}

function LimparTipoAtivo(_AssocObj, _DispObj, _PersistentObj) {
    var _tipoAtivoValue = eval(_AssocObj);
    _tipoAtivoValue.value = "";
    var _tipoAtivoText = eval(_DispObj);
    _tipoAtivoText.value = "";  
    if(_PersistentObj != "")
    {
        var _persistText = eval(_PersistentObj); 
        _persistText.value = "";
    } 
}
    
///////////////////////////////////////
