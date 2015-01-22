using AjaxControlToolkit;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class _SFA_PedidoVenda_ConsultarPedido_Formulario : System.Web.UI.UserControl
{

    protected void Page_Load(object sender, EventArgs e)
    {
        GridView1.SelectedRowStyle.Reset();

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (Session["cdPedidoSFA"] == null)
            return;

        lbOperacao.Text = "Desdobramento no Microsiga";

        //Label lb = (Label)Parent.FindControl("lbNomeTela");
        lbNomeTela.Text = "Consultar Pré-Pedido"; // lb.Text;

        GeraCabecalhoPedidoSFA(Convert.ToInt64(Session["cdPedidoSFA"]));
        
        LoadPedidosERP();


    }

    protected void LoadPedidosERP()
    {
        PedidoVendaERP obj = new PedidoVendaERP();
        DataTable tb = obj.ObterListaPedidoVendaERP(Convert.ToInt64(Session["cdPedidoSFA"]));
        
        GridView1.DataSource = tb.AsDataView();
        GridView1.DataBind();
    }

    protected void btViewItens_Click(object sender, EventArgs e)
    {


        LinkButton bt = (LinkButton) sender;


        string cdPedidoVendaERPSEQ = bt.CommandArgument;

        Button btnImprimirSelecionado = (Button)Parent.FindControl("Formulario1").FindControl("btnImprimirSelecionado");
        btnImprimirSelecionado.Attributes.Remove("onclick");

        if (cdTipoPedidoVenda.Value != "3") //Cessão de Crédito
        {
            btnImprimirSelecionado.Attributes.Add("onclick", string.Format("javascript:ExibirRelatorioPrePedido('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}'); return false;", 'S', 0, cdPedidoVendaERPSEQ, 0, 0, 0, 0, 0, 0, 0));
        }
        else
        {

        }

        


        PedidoVendaERP obj = new PedidoVendaERP();
        DataTable tb = obj.ObterListaPedidoVendaERPItem(Convert.ToInt64(bt.CommandArgument)); // Passa o cód. do Pedido ERP no SFA
        GridView1.SelectedRowStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#99CC00");
        
        GridView2.DataSource = tb.AsDataView();
        GridView2.DataBind();

        UpdatePanel1.Update();


    }

    protected void GeraCabecalhoPedidoSFA(long cdPedidoVenda)
    {

        PedidoVendaERP obj = new PedidoVendaERP();
        DataTable tb = obj.ObterResumoDados(cdPedidoVenda);

        if (tb.Rows.Count > 0)
        {
            DataRow r = tb.Rows[0];
            StringBuilder sb = new StringBuilder();

            try
            {
                string tituloWidth = "15%";
                string contentWidth = "85%";

                //Obtenho o Tipo de Pedido:
                cdTipoPedidoVenda.Value = r["cdTipoPedidoVenda"].ToString();


                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Nº Pedido SFA:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" +
                          r["cdPedidoVendaSEQ"].ToString());
                sb.Append("</span>");

                sb.Append("<br>");
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
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Tipo de Produto:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" +
                          r["dsTipoProduto"].ToString() + "</span>");


                sb.Append("<br>");
                sb.Append("<span style='float: left; width: " + tituloWidth + "'>Tipo de Pedido:</span>" +
                          "<span style='float: right; width: " + contentWidth + "'>" +
                          r["dsTipoPedidoVenda"].ToString() + "</span>");


                //btnImprimirTodos.Visible = true;
                //GridView1.Columns[2].Visible = true;

                //if (cdTipoPedidoVenda.Value == "3") //Cessão de Crédito
                //{
                //    Padrao padrao = new Padrao();

                //    sb.Append("<br>");
                //    sb.Append("<span style='float: left; width: " + tituloWidth + "'>Valor Total:</span>" +
                //              "<span style='float: right; width: " + contentWidth + "'>" +
                //              padrao.FormatarNumero(r["vrTotalMoedaPedidoVenda"].ToString(), 2) + "</span>");

                //    sb.Append("<br>");
                //    sb.Append("<span style='float: left; width: " + tituloWidth + "'>Valor Total em Aberto:</span>" +
                //              "<span style='float: right; width: " + contentWidth + "'>" +
                //              padrao.FormatarNumero(r["vrTotalAbertoMoedaPedidoVenda"].ToString(), 2) + "</span>");

                //    sb.Append("<br>");
                //    sb.Append("<span style='float: left; width: " + tituloWidth + "'>Nº Pré-Pedido:</span>" +
                //              "<span style='float: right; width: " + contentWidth + "'>" +
                //              r["cdPedidoVendaERP"].ToString() + "</span>");

                //    btnImprimirTodos.Visible = false;
                //    GridView1.Columns[2].Visible = false;

                //}

            }
            catch { Response.Redirect("~/_SFA/PedidoVenda/ConsultarPedido/ConsultarPedido.aspx"); }

            lbContents.Text = sb.ToString();
        }
        UpdatePanel2.Update();
    }

    protected void btCancel_OnClick(object sender, EventArgs e)
    {
        ModalPopupExtender1.Hide();   
    }
}
