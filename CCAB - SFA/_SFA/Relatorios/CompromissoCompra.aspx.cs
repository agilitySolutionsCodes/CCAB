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

public partial class _SFA_Relatorios_CompromissoCompra : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
           
        string CdCompromissoCompraSEQ = Request.QueryString["CdCompromissoCompraSEQ"];

        ReportParameter parCdCompromissoCompraSEQ = new ReportParameter();
        parCdCompromissoCompraSEQ.Name = "cdCompromissoCompraSEQ";
        parCdCompromissoCompraSEQ.Values.Add(CdCompromissoCompraSEQ);

        ReportParameter[] parametros = { parCdCompromissoCompraSEQ};

        rptCompromissoCompra.ShowParameterPrompts = false;
        rptCompromissoCompra.ServerReport.ReportServerUrl = new Uri(ConfigurationSettings.AppSettings["Servidor_Relatorio"].ToString());
        rptCompromissoCompra.ServerReport.ReportPath = ConfigurationSettings.AppSettings["Relatorio_CompromissoCompra"].ToString();
        rptCompromissoCompra.ServerReport.SetParameters(parametros);
    }
}
