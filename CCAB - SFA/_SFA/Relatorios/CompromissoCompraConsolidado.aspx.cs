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

public partial class _SFA_Relatorios_CompromissoCompraConsolidado : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
           
        string cdAgenteComercialCooperativaCompromissoCompra = Request.QueryString["cdAgenteComercialCooperativaCompromissoCompra"];
        string cdCronogramaSafraSEQ = Request.QueryString["cdCronogramaSafraSEQ"];

        ReportParameter parCdAgenteComercialCooperativaCompromissoCompra = new ReportParameter();
        parCdAgenteComercialCooperativaCompromissoCompra.Name = "cdAgenteComercialCooperativaCompromissoCompra";
        if (cdAgenteComercialCooperativaCompromissoCompra != null && cdAgenteComercialCooperativaCompromissoCompra != "") parCdAgenteComercialCooperativaCompromissoCompra.Values.Add(cdAgenteComercialCooperativaCompromissoCompra);

        ReportParameter parCdCronogramaSafraSEQ = new ReportParameter();
        parCdCronogramaSafraSEQ.Name = "cdCronogramaSafraSEQ";
        if (cdCronogramaSafraSEQ != null && cdCronogramaSafraSEQ != "") parCdCronogramaSafraSEQ.Values.Add(cdCronogramaSafraSEQ);






        ReportParameter[] parametros = { parCdAgenteComercialCooperativaCompromissoCompra, parCdCronogramaSafraSEQ };

        rptCompromissoCompraConsolidado.ShowParameterPrompts = false;
        rptCompromissoCompraConsolidado.ServerReport.ReportServerUrl = new Uri(ConfigurationSettings.AppSettings["Servidor_Relatorio"].ToString());
        rptCompromissoCompraConsolidado.ServerReport.ReportPath = ConfigurationSettings.AppSettings["Relatorio_CompromissoCompraConsolidado"].ToString();

        

        rptCompromissoCompraConsolidado.ServerReport.SetParameters(parametros);

    }
}
