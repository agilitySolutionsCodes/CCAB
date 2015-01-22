using AjaxControlToolkit;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_Vencimento_Formulario : System.Web.UI.UserControl
{
    internal ListItemCollection CustomComboInit = new ListItemCollection();

    protected void Page_Load(object sender, EventArgs e)
    {
        // Combos que devem ter o valor "forçado" na inicialização 
        // CustomComboInit_Add("ComboID1", "ComboValue1", false);
        // CustomComboInit_Add("ComboID2", "ComboValue2", false); 

        Label lb = (Label)Parent.FindControl("lbNomeTela");
        lbNomeTela.Text = lb.Text;
    }

    protected void RadioButtonListInit(object sender, EventArgs e)
    {
        Label lb = (Label)FormView1.FindControl("dsCronogramaSafra");
        if (lb != null) lb.Text = Session["dsCronogramaSafraHistorico"] != null 
                                  ? Session["dsCronogramaSafraHistorico"].ToString() 
                                  : "";
        
        HiddenField h = (HiddenField)FormView1.FindControl("cdCronogramaSafraSEQ");
        h.Value = Session["cdCronogramaSafraSEQ"].ToString();

        h = (HiddenField)FormView1.FindControl("cdTipoCronogramaSafraVencimento");
        if (h.Value == "") h.Value = "1";

        TextBox t = (TextBox)FormView1.FindControl("pcCorrecaoPrecoTipoCulturaVencimento");
        if (t.Text == "") t.Text = "0,0000";

        t = (TextBox)FormView1.FindControl("pcDescontoPontualidade");
        if (t.Text == "") t.Text = "0,0000";

        RadioButtonList rbl = (RadioButtonList)sender;
        rbl.SelectedIndex = Convert.ToInt32(h.Value) - 1;
      
        RadioButtonListSelectedIndexChanged(sender, e);
    }

    protected void RadioButtonListSelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList rbl = (RadioButtonList)sender;
        Panel pn = (Panel)FormView1.FindControl("Panel9");
        HiddenField h = (HiddenField)FormView1.FindControl("cdTipoCronogramaSafraVencimento");
        if (rbl.SelectedIndex == 1)
        {
            pn.Visible = true;
            h.Value = "2";
        }
        else
        {
            pn.Visible = false;
            h.Value = "1";
        }
        UpdatePanel up = (UpdatePanel)FormView1.FindControl("UpdateVencimento");
        up.Update();
    }

    protected void btAction_OnClick(object sender, EventArgs e)
    {

        //ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "Alerta", "alert('TESTE');", true);

        Button bt = (Button)sender;
        Conv.ReflectObject<CronogramaSafraVencimento> ro = new Conv.ReflectObject<CronogramaSafraVencimento>();
        string msg = ro.Execute(bt.CommandName, FormView1.Row);

        SetCombosSelectedValues();
        
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
        GridView gv = (GridView)Parent.FindControl("Resultado1").FindControl("GridView1");
        CronogramaSafraVencimento obj = new CronogramaSafraVencimento();

        gv.DataSource = obj.ObterLista(Convert.ToInt64(Session["cdCronogramaSafraSEQ"])).AsDataView();
        gv.DataBind();
    }

    protected void btCancel_OnClick(object sender, EventArgs e)
    {
        ModalPopupExtender1.Hide();
    }
}
