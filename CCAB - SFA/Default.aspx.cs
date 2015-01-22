using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml;

public partial class _Default : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        
        switch (Request.QueryString["prm"])
        {
            case "esqueci":
                lblPrincipal.Text = "Para receber sua senha, por favor informe seu login:";
                panLogin.Visible = false;
                panTroca.Visible = true;
                txtUsuarioSenha.Focus();

                break;
            default:
                txtUsuario.Focus();
                break;
        }

        Page.Title = ConfigurationManager.AppSettings["AppTitle"];
    }

    protected void btnSenha_Click(object sender, EventArgs e)
    {
        Pessoa loPessoa = new Pessoa();
        DataTable loDataTableLogin = new DataTable();
        Padrao loPadrao = new Padrao();

        Int64 cdPessoaSEQ;
        string nmNome;

        string dsSenhaLoginPessoa;

        lblMensagem.Text = "";

        if (txtUsuarioSenha.Text.Trim() == "")
        {
            lblMensagem.Text = "O Campo Usuário deve ser preenchido.";
            txtUsuarioSenha.Focus();
            return;
        }

        txtUsuarioSenha.Text = txtUsuarioSenha.Text.ToUpper();

        //Verifico se o Usuário existe na base de dados
        loDataTableLogin = loPessoa.ObterDadosLogin(txtUsuarioSenha.Text.Trim());
        if (loPessoa.Erro != "")
        {
            lblMensagem.Text = loPessoa.Erro;
            return;
        }

        cdPessoaSEQ = Convert.ToInt64(loDataTableLogin.Rows[0]["cdPessoaSEQ"]);
        nmNome = loDataTableLogin.Rows[0]["nmNome"].ToString().ToUpper();
        dsSenhaLoginPessoa = loDataTableLogin.Rows[0]["dsSenhaLoginPessoa"].ToString();
        dsSenhaLoginPessoa = loPadrao.Decodificar(dsSenhaLoginPessoa);
        if (loPadrao.Erro != "")
        {
            lblMensagem.Text = loPadrao.Erro;
            return;
        }

        if (cdPessoaSEQ == 0)
        {
            lblMensagem.Text = "Usuário não encontrado.";
            txtUsuarioSenha.Focus();
            return;
        }

        //Envio da senha para a fila
        loPessoa.IncluirSolicitacaoEnvioEmail(cdPessoaSEQ, nmNome, dsSenhaLoginPessoa, cdPessoaSEQ);
        if (loPessoa.Erro != "")
        {
            lblMensagem.Text = loPessoa.Erro;
            return;
        }

        lblMensagem.Text = nmNome + ", dentro de alguns instantes sua senha será enviada para seu e-mail cadastrado no Portal.";

        panTroca.Visible = false;
        lblPrincipal.Visible = false;
        panOk.Visible = true;

    }


    protected void btnOk_Click(object sender, EventArgs e)
    {
        try
        {
            Pessoa loPessoa = new Pessoa();
            DataTable loDataTableLogin = new DataTable();
            DataTable loDataTablePerfil = new DataTable();
            Padrao loPadrao = new Padrao();

            Int64 cdPessoaSEQ;
            string nmNome;
            string dsLoginPessoa;
            int cdIndicadorTipoAcessoPessoa;
            int cdIndicadorPessoa;

            int cdIndicadorTipoPerfilPessoa;

            string dsSenhaCodificada;

            bool LoginBloqueado;
            bool PrimeiroAcesso;

            lblMensagem.Text = "";

            if (txtUsuario.Text.Trim() == "")
            {
                lblMensagem.Text = "O Campo Usuário deve ser preenchido.";
                txtUsuario.Focus();
                return;
            }

            txtUsuario.Text = txtUsuario.Text.ToUpper();

            if (txtSenha.Text.Trim() == "")
            {
                lblMensagem.Text = "O Campo Senha deve ser preenchido.";
                txtSenha.Focus();
                return;
            }


            dsSenhaCodificada = loPadrao.Codificar(txtSenha.Text.Trim());
            if (loPadrao.Erro != "")
            {
                lblMensagem.Text = loPadrao.Erro;
                return;
            }

            //Verifico se o Usuário e Senha são válidos
            loDataTableLogin = loPessoa.ObterDadosLogin(txtUsuario.Text.Trim(), dsSenhaCodificada);
            if (loPessoa.Erro != "")
            {
                lblMensagem.Text = loPessoa.Erro;
                return;
            }


            if (loDataTableLogin.Rows.Count > 0)
            {
                cdPessoaSEQ = Convert.ToInt64(loDataTableLogin.Rows[0]["cdPessoaSEQ"]);
                nmNome = loDataTableLogin.Rows[0]["nmNome"].ToString().ToUpper();
                dsLoginPessoa = txtUsuario.Text.Trim();
                cdIndicadorTipoAcessoPessoa = Convert.ToInt32(loDataTableLogin.Rows[0]["cdIndicadorTipoAcessoPessoa"]);
                cdIndicadorPessoa = Convert.ToInt32(loDataTableLogin.Rows[0]["cdIndicadorPessoa"]);
                cdIndicadorTipoPerfilPessoa = Convert.ToInt32(loDataTableLogin.Rows[0]["cdIndicadorTipoPerfilPessoa"]);
            }
            else
            {
                lblMensagem.Text = "Erro na tentativa de Obter os Dados da Pessoa, favor entrar em contato com a CCAB.";
                txtUsuario.Focus();
                return;
            }

            //Crio a Session de Usuário
            Usuario loUsuario = new Usuario();
            loUsuario.cdUsuario = cdPessoaSEQ;
            loUsuario.nmUsuario = nmNome;
            loUsuario.dsLoginPessoa = dsLoginPessoa;
            loUsuario.cdIndicadorTipoAcessoPessoa = cdIndicadorTipoAcessoPessoa;
            loUsuario.cdIndicadorPessoa = cdIndicadorPessoa;
            loUsuario.cdPerfilUsuario = cdIndicadorTipoPerfilPessoa;
            Session["Usuario"] = loUsuario;



            if (cdPessoaSEQ == 0)
            {
                lblMensagem.Text = "Usuário ou Senha inválidos.";
                txtUsuario.Focus();
                return;
            }


            //Crio a Session de Segurança
            ItemMenu loItemMenu = new ItemMenu();
            DataTable loDataTableItemMenu;
            loDataTableItemMenu = loItemMenu.ObterListaSeguranca(cdPessoaSEQ);
            Session["Seguranca"] = loDataTableItemMenu;


            //Verifico se o usuário está bloqueado
            LoginBloqueado = loPessoa.VerificarLoginBloqueado(cdPessoaSEQ);
            if (loPessoa.Erro != "")
            {
                lblMensagem.Text = loPessoa.Erro;
                return;
            }

            if (LoginBloqueado == true)
            {
                lblMensagem.Text = "Usuário bloqueado, favor entrar em contato com a CCAB.";
                txtUsuario.Focus();
                return;

            }


            //Verifico se é o primeiro acesso
            PrimeiroAcesso = loPessoa.VerificarPrimeiroAcesso(cdPessoaSEQ);
            if (loPessoa.Erro != "")
            {
                lblMensagem.Text = loPessoa.Erro;
                return;
            }

            if (PrimeiroAcesso == true)
            {
                lblPrincipal.Visible = false;
                panLogin.Visible = false;
                panTermoUso.Visible = true;
                btnConcordo.Enabled = false;

                //Populando o Termo de Uso
                string lsArquivo;
                lsArquivo = Server.MapPath("~\\") + "Configuracao.xml";

                XmlDocument loXmlDocument = new XmlDocument();
                loXmlDocument.Load(lsArquivo);

                string lsDado;
                XmlNode loXmlNode;

                loXmlNode = loXmlDocument.SelectSingleNode("/Configuracao/TermoUso");
                lsDado = loXmlNode.InnerText;

                return;

            }


            CodigoReferenciado loCodigoReferenciado = new CodigoReferenciado();
            DataTable loDataTableCodigoReferenciado;
            loDataTableCodigoReferenciado = loCodigoReferenciado.Obter("DMESPINDICADORTIPOPERFIL", loUsuario.cdPerfilUsuario);
            if (loDataTableCodigoReferenciado.Rows.Count == 1)
            {
                loUsuario.dsPerfilUsuario = loDataTableCodigoReferenciado.Rows[0]["wkDominioCodigoReferenciado"].ToString();
            }
            else
            {
                lblMensagem.Text = "Erro na tentativa de Obter o Perfil, favor entrar em contato com a CCAB.";
                txtUsuario.Focus();
                return;
            }

            Session["Usuario"] = loUsuario;
            Response.Redirect("Home.aspx");
        }

        catch (Exception loException)
        {
            lblMensagem.Text = loException.Message;
        }
    }


    protected void btnTrocarSenha_Click(object sender, EventArgs e)
    {
        Pessoa loPessoa = new Pessoa();
        Padrao loPadrao = new Padrao();

        string dsSenhaCodificada;

        lblMensagem.Text = "";

        if (txtSenhaTroca.Text.Trim() == "" | txtSenhaConfirmacao.Text.Trim() == "")
        {
            lblMensagem.Text = "Os Campos Senha Nova e Confirmação devem ser preenchidos.";

            txtSenhaTroca.Focus();
            return;

        }

        if (txtSenhaTroca.Text.Trim() != txtSenhaConfirmacao.Text.Trim())
        {
            lblMensagem.Text = "Os Campos Senha Nova e Confirmação devem conter os mesmos valores.";

            txtSenhaTroca.Focus();
            return;

        }


        dsSenhaCodificada = loPadrao.Codificar(txtSenhaTroca.Text.Trim());
        if (loPadrao.Erro != "")
        {
            lblMensagem.Text = loPadrao.Erro;
            return;
        }

        loPessoa.AlterarSenha(Convert.ToInt64(lblPessoaSeq.Text), dsSenhaCodificada, Convert.ToInt64(lblPessoaSeq.Text));
        if (loPessoa.Erro != "")
        {
            lblMensagem.Text = loPessoa.Erro;
            return;
        }

        lblPrincipal.Visible = false;
        lblMensagem.Text = "Sua senha foi trocada, por favor efetue o login novamente.";

        panTrocaSenha.Visible = false;
        panTrocaSenha.Visible = false;
        panOk.Visible = true;



    }
    
    protected void btnOkGeral_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }

    protected void btnConcordo_Click(object sender, EventArgs e)
    {
        Usuario loUsuario = new Usuario();
        loUsuario = (Usuario)Session["Usuario"];


        lblPrincipal.Text = "Este é seu primeiro acesso, portanto é necessário trocar sua senha.";
        panTermoUso.Visible = false;
        panLogin.Visible = false;
        panTrocaSenha.Visible = true;
        panUsuarioTroca.Text = loUsuario.dsLoginPessoa;
        lblPessoaSeq.Text = loUsuario.cdUsuario.ToString();
        txtSenhaTroca.Focus();
        return;

    }

    protected void btnDiscordo_Click(object sender, EventArgs e)
    {
        panTermoUso.Visible = false;
        Session.Abandon();
        Response.Redirect("~/Default.aspx");
    }

    protected void chkTermo_CheckedChanged(object sender, EventArgs e)
    {
        btnConcordo.Enabled = chkTermo.Checked;
    }
}
