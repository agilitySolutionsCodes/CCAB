using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_CronogramaSafraCooperativa_CronogramaSafraCooperativa : System.Web.UI.Page
{
    internal string _nometela = "Cronograma da Safra - Cooperativa";
    internal bool MostraDadosPai = true;

    // Necessário se o módulo possui campo CPF (complementa zeros à direita)
    internal string CPFControl = "";
    // Insert
    internal string DisableOnInsertForm = "";
    internal string VanishOnInsertForm = "";
    internal string ControlFocusOnInsert = "dtCronogramaSafraCooperativa";
    // Update
    internal string DisableOnUpdateForm = "";
    internal string VanishOnUpdateForm = "";
    internal string ControlFocusOnUpdate = "dtCronogramaSafraCooperativa";
    // Delete
    internal string ControlToShowInDeleteMessage = "dsCronogramaSafraCooperativa";

    internal Conv.Lib lib = new Conv.Lib();
    internal Label lbOperacao;
    internal FormView fv;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["CronogramaSafraCooperativaGridViewSelected"] = "0";
            string _op = Page.Request.UrlReferrer.ToString().Contains("?") ? "&" : "?";
            btVoltar.PostBackUrl = Page.Request.UrlReferrer.ToString().Contains("ta=ret")
                                   ? Page.Request.UrlReferrer.ToString()
                                   : Page.Request.UrlReferrer.ToString() +
                                   _op + "ta=ret";


            lib.VerificarAcessoBotao("RegraCronogramaSafraCooperativa", btIncluir);
            lib.VerificarAcessoBotao("RegraCronogramaSafraCooperativa", btEdit);
            lib.VerificarAcessoBotao("RegraCronogramaSafraCooperativa", btView);
            lib.VerificarAcessoBotao("RegraCronogramaSafraCooperativa", btDelete);

            //lib.VerificarAcessoBotao("CronogramaSafraCooperativaHistorico", btHistorico);
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

    private void SetValueDropDown(string dropDown, string hiddenFieldValue)
    {
        DropDownList dropDownList = (DropDownList)fv.FindControl(dropDown); 
        HiddenField hiddenField = (HiddenField)fv.FindControl(hiddenFieldValue); 

        dropDownList.SelectedValue = hiddenField.Value;
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
                    //t.Focus();
                    break;
                }
            case "View":
                {
                    /* Só para o Cta por ser numérico no BD */
                    if (CPFControl != "") CheckCPFLength();

                    SetValueDropDown("cdCooperativaSEQ", "hiddenFieldcdCooperativaSEQ");
                    SetValueDropDown("cdIndicadorSituacaoCooperativa", "hiddenFieldCronogramaSafraCooperativa"); 

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
                    if (CPFControl != "") CheckCPFLength();
                                        
                    DisableControls("cdCooperativaSEQ", "disable");

                    SetValueDropDown("cdCooperativaSEQ", "hiddenFieldcdCooperativaSEQ");
                    SetValueDropDown("cdIndicadorSituacaoCooperativa", "hiddenFieldCronogramaSafraCooperativa");                 
                    
                    break;
                    
                    
                }
            case "Delete":
                {
                    /* Só para o Cta por ser numérico no BD */
                    if (CPFControl != "") CheckCPFLength();

                    lib.DisableControls();

                    SetValueDropDown("cdCooperativaSEQ", "hiddenFieldcdCooperativaSEQ");
                    SetValueDropDown("cdIndicadorSituacaoCooperativa", "hiddenFieldCronogramaSafraCooperativa");                    
                    
                    _titulo = "Excluir";
                    _actionText = "excluir";
                    _actionCommandName = "Excluir";
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
        CronogramaSafraCooperativa obj = new CronogramaSafraCooperativa();
        fv.ChangeMode(FormViewMode.Edit);

        DataTable datatable = new DataTable();
        datatable = obj.Obter(Convert.ToInt64(Session["GridViewSelected"]));

        Session["cdCooperativaSEQ"] = datatable.Rows[0]["cdPessoaSEQ"];

        fv.DataSource = datatable;
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
        if (Session["GridViewSelected"] == null)
            Response.Redirect("~/Message.aspx?tp=exp&msg=", true);
        else
            if (Session["GridViewSelected"].ToString() == "0")
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
            Response.Redirect("~/_SFA/Cadastros/CronogramaSafraCooperativaHistorico/CronogramaSafraCooperativaHistorico.aspx");
        }
    }

    protected void PrepareCall()
    {
        GridView gv = (GridView)Resultado1.FindControl("GridView1");

        Session["cdCronogramaSafraCooperativaSEQ"] = Session["CronogramaSafraCooperativaGridViewSelected"];
        Session["dsCronogramaSafraCooperativaHistorico"] = gv.SelectedRow.Cells[2].Text;
    }

    
}
