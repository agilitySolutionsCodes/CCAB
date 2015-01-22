using AjaxControlToolkit;
using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_ExcluirCompromisso_ExcluirCompromisso : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            Session["ShowMessage"] = false;

        lbNomeTela.Text = "Excluir Compromisso";
    }

    protected void btExcluirPedido_Click(object sender, EventArgs e)
    {
        Session["ShowMessage"] = false;
        Response.Redirect("ExcluirCompromisso.aspx");
    }
}
