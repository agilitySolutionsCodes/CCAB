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

public partial class _SFA_GrupoAcesso_Formulario : System.Web.UI.UserControl
{
    internal ListItemCollection CustomComboInit = new ListItemCollection();

    protected void Page_Load(object sender, EventArgs e)
    {
        // Combos que devem ter o valor "forçado" na inicialização 
        // CustomComboInit_Add("ComboID1", "ComboValue1", false);
        CustomComboInit_Add("cdIndicadorStatusGrupoAcesso", "1", false); 

        Label lb = (Label)Parent.FindControl("lbNomeTela");
        lbNomeTela.Text = lb.Text;
    }

    protected void btAction_OnClick(object sender, EventArgs e)
    {
        string msg = "";

        SetCombosSelectedValues();

        Button bt = (Button)sender;
        Conv.ReflectObject<GrupoAcesso> ro = new Conv.ReflectObject<GrupoAcesso>();
        msg = ro.Execute(bt.CommandName, FormView1.Row);

        if (msg == "")
            RefreshGridView();
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
        string _value = Session["cdIndicadorStatusGrupoAcessoValue"].ToString();
        long _status = _value == "" ? 0 : Convert.ToInt64(_value);

        GridView gv = (GridView)Parent.FindControl("Resultado1").FindControl("GridView1");
        GrupoAcesso obj = new GrupoAcesso();

        gv.DataSource = obj.ObterLista(Session["dsGrupoAcesso"].ToString(), _status).AsDataView();
        gv.DataBind();    
    }

    protected void btCancel_OnClick(object sender, EventArgs e)
    {
        ModalPopupExtender1.Hide();
    }
}
