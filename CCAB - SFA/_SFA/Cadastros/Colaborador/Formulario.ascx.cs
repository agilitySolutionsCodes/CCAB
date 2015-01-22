using AjaxControlToolkit;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_Colaborador_Formulario : System.Web.UI.UserControl
{
    internal ListItemCollection CustomComboInit = new ListItemCollection();

    protected void Page_Load(object sender, EventArgs e)
    {
        // Combos que devem ter o valor "forçado" na inicialização 
        // CustomComboInit_Add("ComboID1", "ComboValue1", false);
        // CustomComboInit_Add("ComboID2", "ComboValue2", false); ...

        Label lb = (Label)Parent.FindControl("lbNomeTela");
        lbNomeTela.Text = lb.Text;
        if (FormView1.CurrentMode == FormViewMode.Insert)
            SetCombosSelectedValues();
    }

    protected void btAction_OnClick(object sender, EventArgs e)
    {
        SetCombosSelectedValues();

        Button bt = (Button)sender;
        string msg = "";
        HiddenField h;
        DropDownList d;
        TextBox t;
        Usuario u = (Usuario)Session["Usuario"];
        Pessoa obj = new Pessoa();

        if (bt.CommandName == "AlterarColaborador")
        {
            TabContainer tc = (TabContainer)FormView1.FindControl("TabContainer1");
            TabPanel tp;

            // Recupera os campos "editáveis" do 1º TAB
            tp = (TabPanel)tc.FindControl("TabPanel1");

            t = (TextBox)tp.FindControl("nmPessoa");
            string _nmPessoa = t.Text;

            d = (DropDownList)tp.FindControl("cdIndicadorTipoPerfilPessoa");
            int _cdIndicadorTipoPerfilPessoa = Convert.ToInt32(d.SelectedValue);

            t = (TextBox)tp.FindControl("enEmailPrincipalPessoa");
            string _enEmailPrincipalPessoa = t.Text;

            d = (DropDownList)tp.FindControl("cdIndicadorStatusPessoa");
            int _cdIndicadorStatusPessoa = Convert.ToInt32(d.SelectedValue);

            d = (DropDownList)tp.FindControl("cdEmpresaColaboradorPessoa");
            int _cdEmpresaColaboradorPessoa = Convert.ToInt32(d.SelectedValue);

            // Recupera os campos "editáveis" do 4º TAB
            tp = (TabPanel)tc.FindControl("TabPanel4");

            h = (HiddenField)tp.FindControl("cdPessoaSEQ");
            long _cdPessoaSEQ = Convert.ToInt64(h.Value);

            d = (DropDownList)tp.FindControl("cdGrupoAcessoSEQ");
            long _cdGrupoAcessoSEQ = Convert.ToInt64(d.SelectedValue);

            long _cdUsuarioUltimaAlteracao = u.cdUsuario;

            d = (DropDownList)tp.FindControl("cdIndicadorTipoAcessoPessoa");
            int _cdIndicadorTipoAcessoPessoa = Convert.ToInt32(d.SelectedValue);

            d = (DropDownList)tp.FindControl("cdIndicadorPrimeiroAcessoPessoa");
            int _cdIndicadorPrimeiroAcessoPessoa = Convert.ToInt32(d.SelectedValue);

            d = (DropDownList)tp.FindControl("cdIndicadorSenhaBloqueadaPessoa");
            int _cdIndicadorSenhaBloqueadaPessoa = Convert.ToInt32(d.SelectedValue);

            t = (TextBox)tp.FindControl("dsLoginPessoa");
            string _dsLoginPessoa = t.Text;

            msg = obj.AlterarColaborador(_cdPessoaSEQ, _nmPessoa, _cdIndicadorTipoPerfilPessoa,
                                         _enEmailPrincipalPessoa, _cdEmpresaColaboradorPessoa,
                                         _cdIndicadorStatusPessoa, _cdIndicadorTipoAcessoPessoa,
                                         _dsLoginPessoa, _cdIndicadorPrimeiroAcessoPessoa,
                                         _cdIndicadorSenhaBloqueadaPessoa,
                                         _cdGrupoAcessoSEQ, _cdUsuarioUltimaAlteracao);
        }
        else // Inclusão
        {
            d = (DropDownList)FormView1.FindControl("cdIndicadorTipoPerfilPessoa");
            int _cdIndicadorTipoPerfilPessoa = Convert.ToInt32(d.SelectedValue);

            t = (TextBox)FormView1.FindControl("dsLoginPessoa");
            string _dsLoginPessoa = t.Text;

            t = (TextBox)FormView1.FindControl("nmPessoa");
            string _nmPessoa = t.Text;

            t = (TextBox)FormView1.FindControl("nuCNPJCPFPessoa");
            string _nuCNPJCPFPessoa = t.Text;

            t = (TextBox)FormView1.FindControl("enEmailPrincipalPessoa");
            string _enEmailPrincipalPessoa = t.Text;

            d = (DropDownList)FormView1.FindControl("cdEmpresaColaboradorPessoa");
            int _cdEmpresaColaboradorPessoa = Convert.ToInt32(d.SelectedValue);

            msg = obj.IncluirColaborador(_cdIndicadorTipoPerfilPessoa, 
                                         _dsLoginPessoa, 
                                         _nmPessoa,                       
                                         _nuCNPJCPFPessoa,
                                         _enEmailPrincipalPessoa,
                                         _cdEmpresaColaboradorPessoa,
                                         u.cdUsuario);
        }

        if (msg == "")
        {
            Session["FormViewDataItem"] = null;
            Session["FormViewInsertComboValues"] = null;
            RefreshGridView();
        }
        else
        {
            CustomValidator1.IsValid = false;
            CustomValidator1.ErrorMessage = msg;
            ModalPopupExtender1.Show();
        }  
    }

    protected void CustomComboInit_Add(string _comboID, string _comboValue, bool _enabled)
    {
        ListItem l;
        l = new ListItem(_comboID, _comboValue, _enabled);
        CustomComboInit.Add(l);
    }

    protected void ConfigCombo(object sender, EventArgs e)
    {
        if (FormView1.CurrentMode != FormViewMode.Insert)
        {
            DataRowView r = (DataRowView)FormView1.DataItem;

            {
                if (r == null)
                    r = (DataRowView)Session["FormViewDataItem"];
                else
                    Session["FormViewDataItem"] = r;
            }

            DropDownList d = (DropDownList)sender;

            ListItem l1 = d.Items.FindByValue("0");
            if (l1 == null)
                d.Items.Insert(0, new ListItem("", "0"));

            try
            {
                if (CustomComboInit.Count > 0) // Insert Mode
                {
                    if (CustomComboInit.FindByText(d.ID) != null)
                    {
                        d.SelectedValue = CustomComboInit.FindByText(d.ID).Value;
                        d.Enabled = CustomComboInit.FindByText(d.ID).Enabled;
                    }
                }
                else
                    d.SelectedValue = r[d.ID].ToString(); // Edit Mode
            }
            catch
            {
                d.SelectedValue = "0"; // Insert Mode
            }
        }
        else
        {
            ListItemCollection lic = (ListItemCollection)Session["FormViewInsertComboValues"];

            DropDownList d = (DropDownList)sender;

            ListItem l1 = d.Items.FindByValue("0");
            if (l1 == null)
                d.Items.Insert(0, new ListItem("", "0"));

            try
            {
                if (CustomComboInit.Count > 0) // Insert Mode
                {
                    if (CustomComboInit.FindByText(d.ID) != null)
                    {
                        d.SelectedValue = CustomComboInit.FindByText(d.ID).Value;
                        d.Enabled = CustomComboInit.FindByText(d.ID).Enabled;
                    }
                }
                else
                    d.SelectedValue = lic.FindByText(d.ID).Value; // Edit Mode
            }
            catch
            {
                d.SelectedValue = "0"; // Insert Mode
            }
        }
    }

    protected void SetCombosSelectedValues()
    {
        FormViewRow fr = FormView1.Row;

        if (FormView1.CurrentMode != FormViewMode.Insert)
        {
            DataRowView r = (DataRowView)FormView1.DataItem;

            if (r == null)
                r = (DataRowView)Session["FormViewDataItem"];

            foreach (Control c in fr.Controls[0].Controls)
            {
                if (c is DropDownList)
                {
                    DropDownList d = (DropDownList)c;
                    r[d.ID] = d.SelectedValue;
                }
            }
            Session["FormViewDataItem"] = r;
        }
        else
        {
            ListItemCollection lic = new ListItemCollection();

            foreach (Control c in fr.Controls[0].Controls)
            {
                if (c is DropDownList)
                {
                    DropDownList d = (DropDownList)c;
                    ListItem l = new ListItem(d.ID, d.SelectedValue);
                    lic.Add(l);
                }
            }
            Session["FormViewInsertComboValues"] = lic;
        }
    }
    
    protected void RefreshGridView()
    {
        string _value;

        string _cpf = Session["nuCNPJCPFPessoa"].ToString();

        _value = Session["cdIndicadorTipoPerfilPessoaValue"].ToString();
        int _perfil = _value == "" ? 0 : Convert.ToInt16(_value);

        _value = Session["cdEmpresaColaboradorPessoaValue"].ToString();
        int _empresa = _value == "" ? 0 : Convert.ToInt16(_value);

        _value = Session["cdIndicadorStatusPessoaValue"].ToString();
        int _status = _value == "" ? 0 : Convert.ToInt16(_value);

        _value = Session["cdIndicadorSenhaBloqueadaPessoaValue"].ToString();
        int _locked = _value == "" ? 0 : Convert.ToInt16(_value);

        _value = Session["cdPessoaERP"].ToString();
        Int64 cdPessoaSEQ = _value == "" ? 0 : Convert.ToInt64(_value);

        GridView gv = (GridView)Parent.FindControl("Resultado1").FindControl("GridView1");
        Pessoa obj = new Pessoa();

        gv.DataSource = obj.ObterListaColaborador(cdPessoaSEQ,
                                      Session["dsLoginPessoa"].ToString(),
                                      _cpf,
                                      Session["nmFoneticoPessoa"].ToString(),
                                      _status,
                                      _locked,
                                      _perfil,
                                      _empresa).AsDataView();
        gv.DataBind();
    }

    protected void btCancel_OnClick(object sender, EventArgs e)
    {
        ModalPopupExtender1.Hide();
    }
}
