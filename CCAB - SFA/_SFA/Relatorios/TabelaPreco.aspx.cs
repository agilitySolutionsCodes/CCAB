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

public partial class _SFA_Relatorios_TabelaPreco : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
           
        string cdPessoaSEQ = Request.QueryString["cdPessoaSEQ"];
        string cdCronogramaSafraSEQ = Request.QueryString["cdCronogramaSafraSEQ"];
        string cdTipoProduto = Request.QueryString["cdTipoProduto"];  

        ReportParameter parCdPessoaSEQ = new ReportParameter();
        parCdPessoaSEQ.Name = "cdPessoaSEQ";
        parCdPessoaSEQ.Values.Add(cdPessoaSEQ);

        ReportParameter parCdCronogramaSafraSEQ = new ReportParameter();
        parCdCronogramaSafraSEQ.Name = "cdCronogramaSafraSEQ";
        parCdCronogramaSafraSEQ.Values.Add(cdCronogramaSafraSEQ);

        ReportParameter parCdTipoProduto = new ReportParameter();
        parCdTipoProduto.Name = "cdTipoProduto";
        parCdTipoProduto.Values.Add(cdTipoProduto);

        ReportParameter[] parametros = { parCdPessoaSEQ, parCdCronogramaSafraSEQ, parCdTipoProduto };

        rptTabelaPreco.ShowParameterPrompts = false;
        rptTabelaPreco.ServerReport.ReportServerUrl = new Uri(ConfigurationSettings.AppSettings["Servidor_Relatorio"].ToString());
        rptTabelaPreco.ServerReport.ReportPath = ConfigurationSettings.AppSettings["Relatorio_TabelaPrecos"].ToString();
        rptTabelaPreco.ServerReport.SetParameters(parametros);
    }
}
