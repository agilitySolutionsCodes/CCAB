using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_Vencimento_Filtro : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        GridView gv = (GridView)Parent.FindControl("Resultado1").FindControl("GridView1");
        CronogramaSafraVencimento obj = new CronogramaSafraVencimento();

        gv.DataSource = obj.ObterLista(Convert.ToInt64(Session["cdCronogramaSafraSEQ"])).AsDataView();
        gv.DataBind();  
    }
}
