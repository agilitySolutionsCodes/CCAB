using AjaxControlToolkit;
using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_BloquearCompromisso_BloquearCompromisso : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            Session["ShowMessage"] = false;

        lbNomeTela.Text = "Bloquear Compromisso";
    }

    protected void btLiberarPedido_Click(object sender, EventArgs e)
    {
        Session["ShowMessage"] = false;
        Response.Redirect("BloquearCompromisso.aspx");
    }
}
