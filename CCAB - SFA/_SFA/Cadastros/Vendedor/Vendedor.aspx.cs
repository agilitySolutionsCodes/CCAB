using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_Vendedor_Vendedor : System.Web.UI.Page
{
    internal string _nometela = "Agente Comercial";
    internal bool MostraDadosPai = false;

    // Necessário se o módulo possui campo CNPJ (complementa zeros à esquerda)
    internal string CNPJControl = "";
    // Insert
    internal string DisableOnInsertForm = "";
    internal string VanishOnInsertForm = "";
    internal string ControlFocusOnInsert = "";
    // Update
    internal string DisableOnUpdateForm = "";
    internal string VanishOnUpdateForm = "";
    internal string ControlFocusOnUpdate = "dsLoginPessoa";
    // View
    internal string DisableOnViewForm = "dsLoginPessoa;cdIndicadorTipoAcessoPessoa;cdIndicadorPrimeiroAcessoPessoa;cdIndicadorSenhaBloqueadaPessoa;cdGrupoAcessoSEQ;enEmailPrincipalPessoa";
    internal string VanishOnViewForm = "";
    // Delete
    internal string ControlToShowInDeleteMessage = "";

    internal Conv.Lib lib = new Conv.Lib();
    internal Label lbOperacao;
    internal FormView fv;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["VendedorGridViewSelected"] = "0";

            lib.VerificarAcessoBotao("AgenteComercial", btEdit);
            lib.VerificarAcessoBotao("AgenteComercial", btView);

            //lib.VerificarAcessoBotao("VendedorHistorico", btHistorico);
        }

        lbNomeTela.Text = _nometela;
        fv = (FormView)Formulario1.FindControl("FormView1");
        lbOperacao = (Label)Formulario1.FindControl("lbOperacao");

        if (Session["Usuario"] == null)
            Response.Redirect("~/Default.aspx", true);
        else
        {
            Usuario u = (Usuario)Session["Usuario"];
            if (u.cdIndicadorTipoAcessoPessoa != 1)
                DisableOnUpdateForm += "";
        }
    }

    protected void btView_OnClick(object sender, EventArgs e)
    {
        if (checkRowID())
            ConfigForm("View");
    }

    protected void btEdit_OnClick(object sender, EventArgs e)
    {
        if (checkRowID())
            ConfigForm("Edit");
    }

    protected void ConfigForm(string _acao)
    {
        string _titulo = "", _actionText = "salvar", _cancelText = "cancelar";
        string _actionOnClientClick = "", _actionCommandName = "";
        bool _actionVisible = true;
        FormView fv = (FormView)Formulario1.FindControl("FormView1");

        LoadData();

        TabContainer tc = (TabContainer)fv.Row.FindControl("TabContainer1");

        switch (_acao)
        {
            case "View":
                {
                    DisableControls(DisableOnViewForm, "disable");
                    DisableControls(VanishOnViewForm, "vanish");
                    _titulo = "Visualizar";
                    _actionVisible = false;
                    _cancelText = "fechar";
                    break;
                }
            case "Edit":
                {
                    _titulo = "Alterar";
                    _actionCommandName = "AlterarVendedor";
                    DisableControls(DisableOnUpdateForm, "disable");
                    DisableControls(VanishOnUpdateForm, "vanish");
                    TabPanel tp = (TabPanel)tc.FindControl("TabPanel4");
                    TextBox t = (TextBox)tp.FindControl(ControlFocusOnUpdate);
                    if(t != null) t.Focus();
                    break;
                }
        }

        lbOperacao.Text = _titulo + " Registro";

        // Config do Botão de Ação
        Button btA = (Button)Formulario1.FindControl("btAction");
        btA.Text = _actionText;
        btA.Visible = _actionVisible;
        btA.OnClientClick = _actionOnClientClick;
        btA.CommandName = _actionCommandName;

        // Config do Botão de Cancelamento
        Button btC = (Button)Formulario1.FindControl("btCancel");
        btC.Text = _cancelText;

        ModalPopupExtender mp = (ModalPopupExtender)Formulario1.FindControl("ModalPopupExtender1");
        mp.Show();
    }

    internal void LoadData()
    {
        Pessoa obj = new Pessoa();
        fv.ChangeMode(FormViewMode.Edit);
        fv.DataSource = obj.ObterVendedor(Convert.ToInt64(Session["VendedorGridViewSelected"]));
        fv.DataBind();
    }

    internal void DisableControls(string _ControlNames, string _mode)
    {
        if (_ControlNames == "") return;

        TabContainer tc = (TabContainer)fv.FindControl("TabContainer1");

        foreach (TabPanel tp in tc.Tabs)
            DisableControlsInContainer(_ControlNames, _mode, (Control)tp);
    }

    internal void DisableControlsInContainer(string _ControlNames, string _mode, Control _container)
    {
        string[] _controls = _ControlNames.Split(new Char[] { ';' });
        foreach (string _controlName in _controls)
        {
            if (_controlName.Trim() != "")
            {
                Control c = (Control)_container.FindControl(_controlName);
                if (c != null)
                {
                    switch (c.GetType().Name)
                    {
                        case "Label":
                            Label l = (Label)c;
                            if (_mode == "disable") l.Enabled = false;
                            if (_mode == "vanish") l.Visible = false;
                            break;
                        case "TextBox":
                            TextBox t = (TextBox)c;
                            if (_mode == "disable") t.Enabled = false;
                            if (_mode == "vanish") t.Visible = false;
                            break;
                        case "DropDownList":
                            DropDownList d = (DropDownList)c;
                            if (_mode == "disable") d.Enabled = false;
                            if (_mode == "vanish") d.Visible = false;
                            break;
                    }
                }
            }
        }
    }

    internal bool checkRowID()
    {
        if (Session["VendedorGridViewSelected"] == null)
            Response.Redirect("~/Message.aspx?tp=exp&msg=", true);
        else
            if (Session["VendedorGridViewSelected"].ToString() == "0")
            {
                CustomValidator1.IsValid = false;
                CustomValidator1.ErrorMessage = "Nenhum registro foi selecionado.";
                return false;
            }
        
        return true;
    }

    protected void btHistorico_OnClick(object sender, EventArgs e)
    {
        if (checkRowID())
        {
            GridView gv = (GridView)Resultado1.FindControl("GridView1");
            Session["cdPessoaSEQ"] = Session["VendedorGridViewSelected"];
            Session["nuCNPJCPFPessoa"] = gv.SelectedRow.Cells[2].Text;
            Session["nmPessoa"] = gv.SelectedRow.Cells[3].Text;
            Session["cdPessoaERP"] = gv.SelectedRow.Cells[1].Text;

            Response.Redirect("~/_SFA/Cadastros/VendedorHistorico/VendedorHistorico.aspx");
        }
    }
}
