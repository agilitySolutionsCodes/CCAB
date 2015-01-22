using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Microsoft.Reporting.WebForms;

public partial class _SFA_Relatorios_PrePedido : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string TipoRelatorio = Request.QueryString["TipoRelatorio"];
        string cdPedidoVendaSEQ = Request.QueryString["cdPedidoVendaSEQ"];
        string cdPedidoVendaERPSEQ = Request.QueryString["cdPedidoVendaERPSEQ"];
        string cdAgenteComercialCooperativaPedidoVenda = Request.QueryString["cdAgenteComercialCooperativaPedidoVenda"];
        string cdCronogramaSafraSEQ = Request.QueryString["cdCronogramaSafraSEQ"];
        string cdClienteFaturamentoPedidoVenda = Request.QueryString["cdClienteFaturamentoPedidoVenda"];
        string cdClienteEntregaPedidoVenda = Request.QueryString["cdClienteEntregaPedidoVenda"];
        string cdIndicadorMoedaPedidoVenda = Request.QueryString["cdIndicadorMoedaPedidoVenda"];
        string cdIndicadorStatusPedidoVenda = Request.QueryString["cdIndicadorStatusPedidoVenda"];
        string cdPessoaOrigemFaturamento = Request.QueryString["cdPessoaOrigemFaturamento"];

        ReportParameter par_TipoRelatorio = new ReportParameter();
        par_TipoRelatorio.Name = "TipoRelatorio";
        par_TipoRelatorio.Values.Add(TipoRelatorio);

        ReportParameter par_cdPedidoVendaSEQ = new ReportParameter();
        par_cdPedidoVendaSEQ.Name = "cdPedidoVendaSEQ";
        par_cdPedidoVendaSEQ.Values.Add(cdPedidoVendaSEQ);

        ReportParameter par_cdPedidoVendaERPSEQ = new ReportParameter();
        par_cdPedidoVendaERPSEQ.Name = "cdPedidoVendaERPSEQ";
        par_cdPedidoVendaERPSEQ.Values.Add(cdPedidoVendaERPSEQ);

        ReportParameter par_cdAgenteComercialCooperativaPedidoVenda = new ReportParameter();
        par_cdAgenteComercialCooperativaPedidoVenda.Name = "cdAgenteComercialCooperativaPedidoVenda";
        par_cdAgenteComercialCooperativaPedidoVenda.Values.Add(cdAgenteComercialCooperativaPedidoVenda);

        ReportParameter par_cdCronogramaSafraSEQ = new ReportParameter();
        par_cdCronogramaSafraSEQ.Name = "cdCronogramaSafraSEQ";
        par_cdCronogramaSafraSEQ.Values.Add(cdCronogramaSafraSEQ);

        ReportParameter par_cdClienteFaturamentoPedidoVenda = new ReportParameter();
        par_cdClienteFaturamentoPedidoVenda.Name = "cdClienteFaturamentoPedidoVenda";
        par_cdClienteFaturamentoPedidoVenda.Values.Add(cdClienteFaturamentoPedidoVenda);

        ReportParameter par_cdClienteEntregaPedidoVenda = new ReportParameter();
        par_cdClienteEntregaPedidoVenda.Name = "cdClienteEntregaPedidoVenda";
        par_cdClienteEntregaPedidoVenda.Values.Add(cdClienteEntregaPedidoVenda);

        ReportParameter par_cdIndicadorMoedaPedidoVenda = new ReportParameter();
        par_cdIndicadorMoedaPedidoVenda.Name = "cdIndicadorMoedaPedidoVenda";
        par_cdIndicadorMoedaPedidoVenda.Values.Add(cdIndicadorMoedaPedidoVenda);

        ReportParameter par_cdIndicadorStatusPedidoVenda = new ReportParameter();
        par_cdIndicadorStatusPedidoVenda.Name = "cdIndicadorStatusPedidoVenda";
        par_cdIndicadorStatusPedidoVenda.Values.Add(cdIndicadorStatusPedidoVenda);

        ReportParameter par_cdPessoaOrigemFaturamento = new ReportParameter();
        par_cdPessoaOrigemFaturamento.Name = "cdPessoaOrigemFaturamento";
        par_cdPessoaOrigemFaturamento.Values.Add(cdPessoaOrigemFaturamento);


        ReportParameter[] parametros = { par_TipoRelatorio, par_cdPedidoVendaSEQ, par_cdPedidoVendaERPSEQ, par_cdAgenteComercialCooperativaPedidoVenda, par_cdCronogramaSafraSEQ, par_cdClienteFaturamentoPedidoVenda, par_cdClienteEntregaPedidoVenda, par_cdIndicadorMoedaPedidoVenda, par_cdIndicadorStatusPedidoVenda, par_cdPessoaOrigemFaturamento };
                
        rptPrePedido.ShowParameterPrompts = false;
        rptPrePedido.ServerReport.ReportServerUrl = new Uri(ConfigurationSettings.AppSettings["Servidor_Relatorio"].ToString());
        rptPrePedido.ServerReport.ReportPath = ConfigurationSettings.AppSettings["Relatorio_PrePedido"].ToString();
        rptPrePedido.ServerReport.SetParameters(parametros);
    }
}
