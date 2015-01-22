using AjaxControlToolkit;
using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_LiberarPedidoMicrosiga_LiberarPedidoMicrosiga : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            Session["ShowMessage"] = false;

        lbNomeTela.Text = "Liberar Pedido Microsiga";
    }

    protected void btLiberarPedido_Click(object sender, EventArgs e)
    {
        Session["ShowMessage"] = false;
        Response.Redirect("LiberarPedidoMicrosiga.aspx");
    }
}
