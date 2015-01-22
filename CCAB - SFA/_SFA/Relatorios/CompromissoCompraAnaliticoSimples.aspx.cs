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

public partial class _SFA_Relatorios_CompromissoCompraAnaliticoSimples : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
           
        string cdCompromissoCompraSEQ = Request.QueryString["CdCompromissoCompraSEQ"];
        string cdAgenteComercialCooperativaCompromissoCompra = Request.QueryString["cdAgenteComercialCooperativaCompromissoCompra"];
        string cdCronogramaSafraSEQ = Request.QueryString["cdCronogramaSafraSEQ"];
        string cdIndicadorStatusCompromissoCompra = Request.QueryString["cdIndicadorStatusCompromissoCompra"];
        string cdIndicadorMoedaCompromissoCompra = Request.QueryString["cdIndicadorMoedaCompromissoCompra"];
        string cdPessoaOrigemFaturamento = Request.QueryString["cdPessoaOrigemFaturamento"];
        string blExibirPreco = Request.QueryString["blExibirPreco"];

        ReportParameter parCdCompromissoCompraSEQ = new ReportParameter();
        parCdCompromissoCompraSEQ.Name = "cdCompromissoCompraSEQ";
        if (cdCompromissoCompraSEQ != null && cdCompromissoCompraSEQ != "") parCdCompromissoCompraSEQ.Values.Add(cdCompromissoCompraSEQ);

        ReportParameter parCdAgenteComercialCooperativaCompromissoCompra = new ReportParameter();
        parCdAgenteComercialCooperativaCompromissoCompra.Name = "cdAgenteComercialCooperativaCompromissoCompra";
        if (cdAgenteComercialCooperativaCompromissoCompra != null && cdAgenteComercialCooperativaCompromissoCompra != "") parCdAgenteComercialCooperativaCompromissoCompra.Values.Add(cdAgenteComercialCooperativaCompromissoCompra);

        ReportParameter parCdCronogramaSafraSEQ = new ReportParameter();
        parCdCronogramaSafraSEQ.Name = "cdCronogramaSafraSEQ";
        if (cdCronogramaSafraSEQ != null && cdCronogramaSafraSEQ != "") parCdCronogramaSafraSEQ.Values.Add(cdCronogramaSafraSEQ);

        ReportParameter parCdIndicadorStatusCompromissoCompra = new ReportParameter();
        parCdIndicadorStatusCompromissoCompra.Name = "cdIndicadorStatusCompromissoCompra";
        if (cdIndicadorStatusCompromissoCompra != null && cdIndicadorStatusCompromissoCompra != "") parCdIndicadorStatusCompromissoCompra.Values.Add(cdIndicadorStatusCompromissoCompra);

        ReportParameter parCdIndicadorMoedaCompromissoCompra = new ReportParameter();
        parCdIndicadorMoedaCompromissoCompra.Name = "cdIndicadorMoedaCompromissoCompra";
        if (cdIndicadorMoedaCompromissoCompra != null && cdIndicadorMoedaCompromissoCompra != "") parCdIndicadorMoedaCompromissoCompra.Values.Add(cdIndicadorMoedaCompromissoCompra);

        ReportParameter parCdPessoaOrigemFaturamento = new ReportParameter();
        parCdPessoaOrigemFaturamento.Name = "cdPessoaOrigemFaturamento";
        if (cdPessoaOrigemFaturamento != null && cdPessoaOrigemFaturamento != "") parCdPessoaOrigemFaturamento.Values.Add(cdPessoaOrigemFaturamento);
        
        ReportParameter parBlExibirPreco = new ReportParameter();
        parBlExibirPreco.Name = "blExibirPreco";
        if (blExibirPreco != null && blExibirPreco != "") parBlExibirPreco.Values.Add((blExibirPreco == "S").ToString());


        ReportParameter[] parametros = { parCdCompromissoCompraSEQ, parCdAgenteComercialCooperativaCompromissoCompra, parCdCronogramaSafraSEQ, parCdIndicadorMoedaCompromissoCompra, parCdIndicadorStatusCompromissoCompra, parCdPessoaOrigemFaturamento, parBlExibirPreco };

        rptCompromissoCompraAnaliticoSimples.ShowParameterPrompts = false;
        rptCompromissoCompraAnaliticoSimples.ServerReport.ReportServerUrl = new Uri(ConfigurationSettings.AppSettings["Servidor_Relatorio"].ToString());
        rptCompromissoCompraAnaliticoSimples.ServerReport.ReportPath = ConfigurationSettings.AppSettings["Relatorio_CompromissoCompraAnaliticoSimples"].ToString();

        rptCompromissoCompraAnaliticoSimples.ServerReport.SetParameters(parametros);

    }
}
