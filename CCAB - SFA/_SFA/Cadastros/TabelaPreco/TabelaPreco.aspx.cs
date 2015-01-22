using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_TabelaPreco_TabelaPreco : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            Session["ShowMessage"] = false;

        lbNomeTela.Text = "Tabela de Preço";

        if (Session["Usuario"] == null)
            Response.Redirect("~/Default.aspx", true);
    }

    protected void btVoltar_Click(object sender, EventArgs e)
    {
        Session["ShowMessage"] = false;
        Response.Redirect("TabelaPreco.aspx");
    }
}
