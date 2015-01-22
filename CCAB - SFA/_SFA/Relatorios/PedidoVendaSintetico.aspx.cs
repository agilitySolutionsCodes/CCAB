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

public partial class _SFA_Relatorios_PedidoVendaSintetico : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
           
        string cdPedidoVendaSEQ = Request.QueryString["CdPedidoVendaSEQ"];
        string cdAgenteComercialCooperativaPedidoVenda = Request.QueryString["cdAgenteComercialCooperativaPedidoVenda"];
        string cdCronogramaSafraSEQ = Request.QueryString["cdCronogramaSafraSEQ"];
        string cdIndicadorStatusPedidoVenda = Request.QueryString["cdIndicadorStatusPedidoVenda"];
        string cdIndicadorMoedaPedidoVenda = Request.QueryString["cdIndicadorMoedaPedidoVenda"];
        string cdClienteFaturamentoPedidoVenda = Request.QueryString["cdClienteFaturamentoPedidoVenda"];
        string cdClienteEntregaPedidoVenda = Request.QueryString["cdClienteEntregaPedidoVenda"];
        string cdPessoaOrigemFaturamento = Request.QueryString["cdPessoaOrigemFaturamento"];
        string blExibirPreco = Request.QueryString["blExibirPreco"];

        ReportParameter parCdPedidoVendaSEQ = new ReportParameter();
        parCdPedidoVendaSEQ.Name = "cdPedidoVendaSEQ";
        if (cdPedidoVendaSEQ != null && cdPedidoVendaSEQ != "") parCdPedidoVendaSEQ.Values.Add(cdPedidoVendaSEQ);

        ReportParameter parCdAgenteComercialCooperativaPedidoVenda = new ReportParameter();
        parCdAgenteComercialCooperativaPedidoVenda.Name = "cdAgenteComercialCooperativaPedidoVenda";
        if (cdAgenteComercialCooperativaPedidoVenda != null && cdAgenteComercialCooperativaPedidoVenda != "") parCdAgenteComercialCooperativaPedidoVenda.Values.Add(cdAgenteComercialCooperativaPedidoVenda);

        ReportParameter parCdCronogramaSafraSEQ = new ReportParameter();
        parCdCronogramaSafraSEQ.Name = "cdCronogramaSafraSEQ";
        if (cdCronogramaSafraSEQ != null && cdCronogramaSafraSEQ != "") parCdCronogramaSafraSEQ.Values.Add(cdCronogramaSafraSEQ);

        ReportParameter parCdIndicadorStatusPedidoVenda = new ReportParameter();
        parCdIndicadorStatusPedidoVenda.Name = "cdIndicadorStatusPedidoVenda";
        if (cdIndicadorStatusPedidoVenda != null && cdIndicadorStatusPedidoVenda != "") parCdIndicadorStatusPedidoVenda.Values.Add(cdIndicadorStatusPedidoVenda);

        ReportParameter parCdIndicadorMoedaPedidoVenda = new ReportParameter();
        parCdIndicadorMoedaPedidoVenda.Name = "cdIndicadorMoedaPedidoVenda";
        if (cdIndicadorMoedaPedidoVenda != null && cdIndicadorMoedaPedidoVenda != "") parCdIndicadorMoedaPedidoVenda.Values.Add(cdIndicadorMoedaPedidoVenda);

        ReportParameter parCdClienteFaturamentoPedidoVenda = new ReportParameter();
        parCdClienteFaturamentoPedidoVenda.Name = "cdClienteFaturamentoPedidoVenda";
        if (cdClienteFaturamentoPedidoVenda != null && cdClienteFaturamentoPedidoVenda != "") parCdClienteFaturamentoPedidoVenda.Values.Add(cdClienteFaturamentoPedidoVenda);

        ReportParameter parCdClienteEntregaPedidoVenda = new ReportParameter();
        parCdClienteEntregaPedidoVenda.Name = "cdClienteEntregaPedidoVenda";
        if (cdClienteEntregaPedidoVenda != null && cdClienteEntregaPedidoVenda != "") parCdClienteEntregaPedidoVenda.Values.Add(cdClienteEntregaPedidoVenda);

        ReportParameter parCdPessoaOrigemFaturamento = new ReportParameter();
        parCdPessoaOrigemFaturamento.Name = "cdPessoaOrigemFaturamento";
        if (cdPessoaOrigemFaturamento != null && cdPessoaOrigemFaturamento != "") parCdPessoaOrigemFaturamento.Values.Add(cdPessoaOrigemFaturamento);

        ReportParameter parBlExibirPreco = new ReportParameter();
        parBlExibirPreco.Name = "blExibirPreco";
        if (blExibirPreco != null && blExibirPreco != "") parBlExibirPreco.Values.Add((blExibirPreco == "S").ToString());

        ReportParameter[] parametros = {parCdPedidoVendaSEQ, parCdAgenteComercialCooperativaPedidoVenda, parCdClienteEntregaPedidoVenda, parCdCronogramaSafraSEQ, parCdIndicadorMoedaPedidoVenda, parCdIndicadorStatusPedidoVenda, parBlExibirPreco};

        rptPedidoVendaSintetico.ShowParameterPrompts = false;
        rptPedidoVendaSintetico.ServerReport.ReportServerUrl = new Uri(ConfigurationSettings.AppSettings["Servidor_Relatorio"].ToString());
        rptPedidoVendaSintetico.ServerReport.ReportPath = ConfigurationSettings.AppSettings["Relatorio_PedidoVendaSintetico"].ToString();
        rptPedidoVendaSintetico.ServerReport.SetParameters(parametros);

    }
}
