using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Conv;

public partial class _SFA_CompromissoCompra_NovoCompromisso_Passo3Header : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["cdCompromissoCompra"] == null)
            return;
        
        CompromissoCompra obj = new CompromissoCompra();
        DataTable tb = obj.ObterResumoDadosTMP(Convert.ToInt64(Session["cdCompromissoCompra"].ToString()));
        
        if (tb.Rows.Count > 0)
        {
            DataRow r = tb.Rows[0];
            StringBuilder sb = new StringBuilder();

            try
            {
                string tituloWidth = "15%";
                string contentWidth = "85%";

                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Data Emissão:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>");

                if (r["dtEmissaoCompromissoCompra"].ToString() != "") 
                    sb.Append(Convert.ToDateTime(r["dtEmissaoCompromissoCompra"].ToString()).ToString("dd/MM/yyyy"));

                sb.Append("</span>");
                
                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Situação:</span>" + 
                          "<span style='float: right; width: " + contentWidth + "'>" +
                          r["dsIndicadorStatusCompromissoCompra"].ToString() + "</span>");
                
                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Agente: </span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" +
                          r["dsAgenteComercialCooperativaCompromissoCompra"].ToString() + "</span>");
                
                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Origem Faturamento:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" +
                          r["dsPessoaOrigemFaturamento"].ToString() + "</span>");
                
                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Safra:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" +
                          r["dsCronogramaSafra"].ToString() + "</span>");

                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Moeda:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" + 
                          r["dsIndicadorMoedaCompromissoCompra"].ToString() + "</span>");

                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Agente Comercial RC:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" + 
                          r["dsAgenteComercialRCCompromissoCompra"].ToString() + "</span>");
            }
            catch { Response.Redirect("~/_SFA/CompromissoCompra/NovoCompromisso/NovoCompromisso.aspx"); }

            lbContents.Text = sb.ToString();
        }
    }
}
