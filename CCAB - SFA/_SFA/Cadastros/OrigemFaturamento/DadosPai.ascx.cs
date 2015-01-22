using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_Cadastros_OrigemFaturamento_DadosPai : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder();

        try
        {
            sb.Append("Nome da Safra: " + Session["dsCronogramaSafraHistorico"].ToString());
            //sb.Append(" - ");
        }
        catch { Response.Redirect("~/_SFA/Cadastros/CronogramaSafra/CronogramaSafra.aspx"); }

        lbDadosPai.Text = sb.ToString();
    }
}
