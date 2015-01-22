using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_Cadastros_MinhaCentral_Usuario_UsuarioEdicao : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Usuario"] == null)
            Response.Redirect("~/Default.aspx", true);

        lbNomeTela.Text = "Atualizar Cadastro";

        Usuario u = (Usuario)Session["Usuario"];
        
        if (u.cdPerfilUsuario == 2) // Empresa CCAB
            Response.Redirect("~/Home.aspx", true);

        ObjectDataSource ds = (ObjectDataSource)Formulario1.FindControl("ObjectDataSource12");
        ds.SelectMethod = "";
        switch (u.cdPerfilUsuario)
        {
            case 1: // Cliente 
                ds.SelectMethod = "ObterCliente";
                break;
            case 3: // Agente Comercial
                ds.SelectMethod = "ObterVendedor";
                break;
            case 4: // Colaborador Agente
            case 5: // Colaborador CCAB
                ds.SelectMethod = "ObterColaborador";
                break;
        }
        ds.SelectParameters["cdPessoaSEQ"].DefaultValue = u.cdUsuario.ToString();

        FormView fv = (FormView)Formulario1.FindControl("FormView1");
        fv.DefaultMode = FormViewMode.Edit;

    }
}
