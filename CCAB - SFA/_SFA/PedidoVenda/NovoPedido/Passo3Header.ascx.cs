using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Conv;

public partial class _SFA_PedidoVenda_NovoPedido_Passo3Header : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["cdPedidoVenda"] == null)
            return;

        PedidoVenda obj = new PedidoVenda();
        DataTable tb = obj.ObterResumoDadosTMP(Convert.ToInt64(Session["cdPedidoVenda"].ToString()));

        if (tb.Rows.Count > 0)
        {
            StringBuilder sb = new StringBuilder();

            try
            {
                string tituloWidth = "15%";
                string contentWidth = "85%";

                DataRow r = tb.Rows[0];

                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Data Digitação:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" +
                          Convert.ToDateTime(r["dtDigitacaoPedidoVenda"].ToString()).ToString("dd/MM/yyyy"));
                sb.Append("</span>");

                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Data Emissão:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>");
                if (r["dtEmissaoPedidoVenda"].ToString() != "")
                    sb.Append(Convert.ToDateTime(r["dtEmissaoPedidoVenda"].ToString()).ToString("dd/MM/yyyy"));
                sb.Append("</span>");

                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Situação:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" +
                          r["dsIndicadorStatusPedidoVenda"].ToString() + "</span>");

                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Agente: </span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" +
                          r["dsAgenteComercialCooperativaPedidoVenda"].ToString() + "</span>");

                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Origem Faturamento:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" +
                          r["dsPessoaOrigemFaturamento"].ToString() + "</span>");

                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Tipo Pedido:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" +
                          r["dsTipoPedidoVenda"].ToString() + "</span>");


                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Cliente:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" +
                          r["dsClienteFaturamentoPedidoVenda"].ToString() + "</span>");

                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Local Entrega:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" +
                          r["dsClienteEntregaPedidoVenda"].ToString() + "</span>");

                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Safra:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" +
                          r["dsCronogramaSafra"].ToString() + "</span>");

                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Moeda:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" +
                          r["dsIndicadorMoedaPedidoVenda"].ToString() + "</span>");

                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Agente Comercial RC:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" +
                          r["dsAgenteComercialRCPedidoVenda"].ToString() + "</span>");
            }
            catch { Response.Redirect("~/_SFA/PedidoVenda/NovoPedido/NovoPedido.aspx"); }

            lbContents.Text = sb.ToString();
        }
    }
}
