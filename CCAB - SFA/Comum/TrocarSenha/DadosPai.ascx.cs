using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Comum_TrocarSenha_DadosPai : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //StringBuilder sb = new StringBuilder();
        //if (Request.QueryString["tp"] == "pj")
        //{
        //    try
        //    {   
        //        sb.Append("CNPJ: " + Session["PJCNPJ"].ToString());
        //        sb.Append(" - ");
        //        if (Session["PJERP"] != null && Session["PJERP"].ToString() != "" && Session["PJERP"].ToString() != "&nbsp;")
        //        {
        //            sb.Append("Cód. ERP: " + Session["PJERP"].ToString());
        //            sb.Append(" - ");
        //        }
        //        sb.Append("Razão Social: " + Session["PJRazaoSocial"].ToString());
        //    }
        //    catch { Response.Redirect("~/_SFA/Cadastros/PessoaJuridica/PessoaJuridica.aspx"); }
        //}
        //else
        //{
        //    try
        //    {
        //        sb.Append("CPF: " + Session["PFCPF"].ToString());
        //        sb.Append(" - ");
        //        if (Session["PFERP"] != null && Session["PFERP"].ToString() != "" && Session["PFERP"].ToString() != "&nbsp;")
        //        {
        //            sb.Append("Cód. ERP: " + Session["PFERP"].ToString());
        //            sb.Append(" - ");
        //        }
        //        sb.Append("Nome: " + Session["PFNome"].ToString());
        //    }
        //    catch { Response.Redirect("~/_SFA/Cadastros/PessoaFisica/PessoaFisica.aspx"); }
        //}
        //lbDadosPai.Text = sb.ToString();
    }
}
