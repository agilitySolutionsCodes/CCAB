using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Comum_TrocarSenha : System.Web.UI.Page
{
    internal string _nometela = "";
    internal bool MostraDadosPai = true;
    internal long cdPessoaSEQ = 0;
    internal Conv.Lib lib = new Conv.Lib();

    public bool _successMsg = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //string _op = Page.Request.UrlReferrer.ToString().Contains("?") ? "&" : "?";
            //btVoltar.PostBackUrl = Page.Request.UrlReferrer.ToString().Contains("ta=ret")
            //                       ? Page.Request.UrlReferrer.ToString()
            //                       : Page.Request.UrlReferrer.ToString() +
            //                       _op + "ta=ret";
        }

        //if (Request.QueryString["tp"] == "pj")
        //{
        //    cdPessoaSEQ = Convert.ToInt64(Session["PJcdPessoaSEQ"]);
        //    _nometela = "Pessoa Jurídica - Troca de Senha";
        //}
        //else if (Request.QueryString["tp"] == "pf")
        //{
        //    cdPessoaSEQ = Convert.ToInt64(Session["PFcdPessoaSEQ"]);
        //    _nometela = "Pessoa Física - Troca de Senha";
        //}

        Usuario loUsuario = new Usuario();
        loUsuario = (Usuario)Session["Usuario"];
        cdPessoaSEQ = loUsuario.cdUsuario;
        lbNomeTela.Text = "Troca de Senha";
            
    }

    protected void btAction_OnClick(object sender, EventArgs e)
    {
        string msg = "Senha alterada com sucesso.";

        if (Session["Usuario"] != null)
        {
            Pessoa ps = new Pessoa();
            Padrao pd = new Padrao();
            Usuario u = (Usuario)Session["Usuario"];

            string dsSenhaCodificada;

            if (txtNovaSenha1.Text.Trim() == "" || txtNovaSenha2.Text.Trim() == "")
            {
                msg = "Os Campos Nova Senha e Confirmação devem ser preenchidos.";
                txtNovaSenha1.Focus();
            }

            if (txtNovaSenha1.Text.Trim() != txtNovaSenha2.Text.Trim())
            {
                msg = "Os campos Nova Senha e Confirmação não são iguais.";
                txtNovaSenha1.Focus();
            }

            dsSenhaCodificada = pd.Codificar(txtNovaSenha1.Text.Trim());
            if (pd.Erro != "")
                msg = pd.Erro;

            ps.AlterarSenha(u.cdUsuario, dsSenhaCodificada, u.cdUsuario);
            if (ps.Erro != "")
            {
                _successMsg = false;
                msg = ps.Erro;
                CustomValidator1.IsValid = false;
                CustomValidator1.ErrorMessage = msg;
            }
            _successMsg = true;

            return;
        }
        else
            Response.Redirect("~/Default.aspx");
    }
}

