using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_ProdutoHistorico_Filtro : System.Web.UI.UserControl
{    
    protected void Page_Load(object sender, EventArgs e)
    {
        long _cdProdutoSEQ = Session["cdProdutoSEQ"].ToString() == "" ? 0 : Convert.ToInt64(Session["cdProdutoSEQ"]);
        
        GridView gv = (GridView)Parent.FindControl("Resultado1").FindControl("GridView1");
        Produto obj = new Produto();

        gv.DataSource = obj.ObterListaHistorico(_cdProdutoSEQ).AsDataView();
        gv.DataBind();    
    }
}
