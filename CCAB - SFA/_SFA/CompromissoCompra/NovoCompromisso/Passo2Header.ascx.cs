using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Conv;

public partial class _SFA_CompromissoCompra_NovoCompromisso_Passo2Header : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["PVPasso1"] != null)
        {
            StringBuilder sb = new StringBuilder();
            PVPasso1 p1 = (PVPasso1)Session["PVPasso1"];

            try
            {
                string tituloWidth = "15%";
                string contentWidth = "85%";

                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Agente:</span>" + 
                          "<span style='float: right; width: " + contentWidth + "'>" + p1.nmAgente + "</span>");
                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Safra: </span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" + p1.nmSafra + "</span>");
                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Origem Faturamento:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" + p1.nmOrigemFaturamento + "</span>");
                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Moeda: </span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" + p1.nmMoeda + "</span>");
            }
            catch { Response.Redirect("~/_SFA/CompromissoCompra/NovoCompromisso/NovoCompromisso.aspx"); }

            lbContents.Text = sb.ToString();
        }
    }
}
