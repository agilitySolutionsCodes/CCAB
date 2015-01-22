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

public partial class _SFA_Cadastros_MinhaCentral_Usuario_Formulario : System.Web.UI.UserControl
{
    internal ListItemCollection CustomComboInit = new ListItemCollection();
    public bool _successMsg = false;
    public bool blnColaborador;

    protected void Page_Load(object sender, EventArgs e)
    {
        Usuario u = (Usuario)Session["Usuario"];

        HiddenField h = (HiddenField)FormView1.FindControl("cdIndicadorTipoPerfilPessoa");
        blnColaborador = "4,5".Contains(h.Value);

        h = (HiddenField)FormView1.FindControl("cdUsuarioUltimaAlteracao");
        h.Value = u.cdUsuario.ToString();

        if(blnColaborador)
            TurnControlsOnOff();
    }

    protected void btAction_OnClick(object sender, EventArgs e)
    {
        SetCombosSelectedValues();

        string msg = "";

        Conv.ReflectObject<Pessoa> ro = new Conv.ReflectObject<Pessoa>();
        
        HiddenField h = (HiddenField)FormView1.FindControl("cdIndicadorTipoPerfilPessoa");

        FormView1.ChangeMode(FormViewMode.ReadOnly);
        switch (h.Value)
        {
            case "1":
                msg = ro.Execute("AlterarCliente", FormView1.Row);
                break;
            case "3":
                msg = ro.Execute("AlterarVendedor", FormView1.Row);
                break;
            case "4":
            case "5":
                msg = ro.Execute("AlterarColaborador", FormView1.Row);
                break;
        }
        
        if (msg == "")
        {
            Session["FormViewDataItem"] = null;
            Session["FormViewInsertComboValues"] = null;
            _successMsg = true;
        }
        else
        {
            CustomValidator1.IsValid = false;
            CustomValidator1.ErrorMessage = msg;
        }
    }

    internal void TurnControlsOnOff()
    {
        FormViewRow row = FormView1.Row;

        foreach (Control c in row.Controls[0].Controls)
        {
            if(c is TextBox)
            {
                TextBox t = (TextBox)c;
                t.Enabled = blnColaborador;
            }
            if(c is DropDownList)
            {
                DropDownList d = (DropDownList)c;
                d.Enabled = blnColaborador;
            }
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
}
