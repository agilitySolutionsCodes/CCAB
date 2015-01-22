using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_Produto_Produto : System.Web.UI.Page
{
    internal string _nometela = "Produto";
    internal bool MostraDadosPai = false;

    // Necessário se o módulo possui campo Cta (complementa zeros à direita)
    internal string CPFControl = "";
    // Insert
    internal string DisableOnInsertForm = "";
    internal string VanishOnInsertForm = "";
    internal string ControlFocusOnInsert = "dsProduto";
    // Update
    internal string DisableOnUpdateForm = "cdProdutoERP;dsUnidadeProduto;dsProduto;qtEmbalagemProduto;qtPesoLiquidoProduto;qtPesoBrutoProduto;wkProduto";
    internal string VanishOnUpdateForm = "";
    internal string ControlFocusOnUpdate = "dsProduto";
    // Delete
    internal string ControlToShowInDeleteMessage = "";

    internal Conv.Lib lib = new Conv.Lib();
    internal Label lbOperacao;
    internal FormView fv;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["ProdutoGridViewSelected"] = "0";

            //lib.VerificarAcessoBotao("Produto", btIncluir);
            lib.VerificarAcessoBotao("Produto", btEdit);
            lib.VerificarAcessoBotao("Produto", btView);

            //lib.VerificarAcessoBotao("ProdutoHistorico", btHistorico);
        }

        lbNomeTela.Text = _nometela;
        fv = (FormView)Formulario1.FindControl("FormView1");
        lbOperacao = (Label)Formulario1.FindControl("lbOperacao");
    }
    
    protected void btIncluir_OnClick(object sender, EventArgs e)
    {
        ConfigForm("Insert");
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

    protected void btDelete_OnClick(object sender, EventArgs e)
    {
        if(checkRowID()) 
            ConfigForm("Delete");
    }

    protected void ConfigForm(string _acao)
    {
        string _titulo = "", _actionText = "salvar", _cancelText = "cancelar";
        string _actionOnClientClick = "", _actionCommandName = "";
        bool _actionVisible = true;
        FormView fv = (FormView)Formulario1.FindControl("FormView1");

        if (_acao != "Insert")
            LoadData();

        switch (_acao)
        {
            case "Insert":
                {
                    _titulo = "Incluir";
                    _actionCommandName = "Incluir";
                    fv.ChangeMode(FormViewMode.Insert);
                    fv.DataBind();
                    DisableControls(DisableOnInsertForm, "disable");
                    DisableControls(VanishOnInsertForm, "vanish");
                    TextBox t = (TextBox)fv.FindControl(ControlFocusOnInsert);
                    t.Focus();
                    break;
                }
            case "View":
                {
                    /* Só para o Cta por ser numérico no BD */
                    if (CPFControl != "") CheckCPFLength();

                    lib.DisableControls();
                    _titulo = "Visualizar";
                    _actionVisible = false;
                    _cancelText = "fechar";
                    break;
                }
            case "Edit":
                {
                    _titulo = "Alterar";
                    _actionCommandName = "Alterar";

                    /* Só para o Cta por ser numérico no BD */
                    if(CPFControl != "") CheckCPFLength();

                    DisableControls(DisableOnUpdateForm, "disable");
                    DisableControls(VanishOnUpdateForm, "vanish");
                    TextBox t = (TextBox)fv.FindControl(ControlFocusOnUpdate);
                    t.Focus();
                    break;
                }
            case "Delete":
                {
                    /* Só para o Cta por ser numérico no BD */
                    if (CPFControl != "") CheckCPFLength();

                    lib.DisableControls();
                    _titulo = "Excluir";
                    _actionText = "excluir";
                    _actionCommandName = "Excluir";

                    TextBox t = (TextBox)fv.FindControl(ControlToShowInDeleteMessage);
                    _actionOnClientClick = "return Confirmacao('" + t.Text + "')";
                    _cancelText = "cancelar";
                    break;
                }
        }

        lbOperacao.Text = _titulo + " Registro";

        HiddenField h = (HiddenField)fv.FindControl("cdUsuarioUltimaAlteracao");
        Usuario u = (Usuario)Session["Usuario"];
        if (u == null) Response.Redirect("~/Default.aspx", true);
        h.Value = u.cdUsuario.ToString();

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

    internal void CheckCPFLength()
    {
        TextBox t = (TextBox)fv.FindControl(CPFControl);
        if (t.Text != "" && t.Text.Trim().Length < 11)
        {
            string s = "00000000000" + t.Text;
            t.Text = s.Substring(s.Length - 11, 11);
        }
    }

    internal void LoadData()
    {
        Produto pd = new Produto();
        fv.ChangeMode(FormViewMode.Edit);
        fv.DataSource = pd.Obter(Convert.ToInt64(Session["ProdutoGridViewSelected"]));
        fv.DataBind();
    }

    internal void DisableControls(string _ControlNames, string _mode)
    {
        if (_ControlNames == "") return;

        FormViewRow row = fv.Row;

        string[] _controls = _ControlNames.Split(new Char[] { ';' });
        foreach (string _controlName in _controls)
        {
            if (_controlName.Trim() != "")
            {
                Control c = (Control)row.FindControl(_controlName);
                switch (c.GetType().Name)
                {
                    case "Label":
                        Label l = (Label)c;
                        if (_mode == "disable") l.Enabled = false;
                        if (_mode == "vanish") l.Visible = false;
                        break;
                    case "TextBox":
                        TextBox t = (TextBox)c;
                        if(_mode == "disable") t.Enabled = false;
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

    internal bool checkRowID()
    {
        if (Session["ProdutoGridViewSelected"] == null)
            Response.Redirect("~/Message.aspx?tp=exp&msg=", true);
        else
            if (Session["ProdutoGridViewSelected"].ToString() == "0")
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
            PrepareCall();
            Response.Redirect("~/_SFA/Cadastros/ProdutoHistorico/ProdutoHistorico.aspx");
        }
    }

    protected void PrepareCall()
    {
        GridView gv = (GridView)Resultado1.FindControl("GridView1");

        Session["cdProdutoSEQ"] = Session["ProdutoGridViewSelected"];
        Session["dsProdutoHistorico"] = gv.SelectedRow.Cells[2].Text;
    }
}
