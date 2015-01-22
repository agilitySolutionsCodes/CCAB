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

public partial class _SFA_Relatorios_PedidoVenda : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
           
        string CdPedidoVendaSEQ = Request.QueryString["CdPedidoVendaSEQ"];

        ReportParameter parCdPedidoVendaSEQ = new ReportParameter();
        parCdPedidoVendaSEQ.Name = "cdPedidoVendaSEQ";
        parCdPedidoVendaSEQ.Values.Add(CdPedidoVendaSEQ);

        ReportParameter[] parametros = { parCdPedidoVendaSEQ};

        rptPedidoVenda.ShowParameterPrompts = false;
        rptPedidoVenda.ServerReport.ReportServerUrl = new Uri(ConfigurationSettings.AppSettings["Servidor_Relatorio"].ToString());
        rptPedidoVenda.ServerReport.ReportPath = ConfigurationSettings.AppSettings["Relatorio_PedidoVenda"].ToString();
        rptPedidoVenda.ServerReport.SetParameters(parametros);
    }
}
