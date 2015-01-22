using AjaxControlToolkit;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_PrecoPontualidade_Formulario : System.Web.UI.UserControl
{
    internal ListItemCollection CustomComboInit = new ListItemCollection();

    protected void Page_Load(object sender, EventArgs e)
    {
        Label lb = (Label)Parent.FindControl("lbNomeTela");
        lbNomeTela.Text = lb.Text;
        lblMensagen.Visible = false;  
    }

    protected void btAction_OnClick(object sender, EventArgs e)
    {
        Button bt = (Button)sender;

        switch (bt.CommandName)
        { 
            case "Incluir" :
                if (!Existe()) { return; };
                 break;

            case "Excluir" :
                if (!ValidaSafraExistente()) { return; };
                
                CronogramaSafraVencimentoCooperativa Obj = new CronogramaSafraVencimentoCooperativa();
                Obj.Excluir(Convert.ToInt32(Session["GridViewSelected"]));

                break;

            case "Alterar":
                if (!ValidaSafraExistente()) { return; };
                break;

        }


        HiddenField h = (HiddenField)FormView1.FindControl("cdCronogramaSafraVencimentoSEQ");
        h.Value = Session["cdVencimentoSEQ"].ToString();


        Conv.ReflectObject<CronogramaSafraVencimentoCooperativa> ro = new Conv.ReflectObject<CronogramaSafraVencimentoCooperativa>();
        string msg = ro.Execute(bt.CommandName, FormView1.Row);

        if (msg == "")
            RefreshGridView();
        else
        {
            CustomValidator1.IsValid = false;
            CustomValidator1.ErrorMessage = msg;
            ModalPopupExtender1.Show();
        }  
       
        
    }

    private bool Existe()
    {
        CronogramaSafraVencimentoCooperativa Obj = new CronogramaSafraVencimentoCooperativa();
        DropDownList cdCooperativaSEQ = (DropDownList)FormView1.FindControl("cdCooperativaSEQ");

        //if (Obj.Existe(Convert.ToInt32(Session["cdCronogramaSafraSEQ"]), Convert.ToInt32(cdCooperativaSEQ.SelectedValue)))
        //{
        //    lblMensagen.Text = "Já existe uma regra cadastrada para essa cooperativa!";
        //    lblMensagen.Visible = true;
        //    ModalPopupExtender1.Show();
        //    return false; 
        //}

        return true;
    }

    private bool ValidaTipoProduto()
    {
        #region Verifica se foi selecionado apenas um Tipo de Produto

        DropDownList cdIndicadorPrincipioAtivo = (DropDownList)FormView1.FindControl("cdIndicadorPrincipioAtivo");
        DropDownList cdIndicadorProdutoAcabado = (DropDownList)FormView1.FindControl("cdIndicadorProdutoAcabado");

        if (cdIndicadorPrincipioAtivo.SelectedValue.Equals("1") && cdIndicadorProdutoAcabado.SelectedValue.Equals("1"))
        {
            lblMensagen.Text = "Selecione apenas um Tipo de Produto. Ex:(Produto Acabado ou Principio Ativo)";
            lblMensagen.Visible = true;
            ModalPopupExtender1.Show();
            return false;
        }
        else
        {
            lblMensagen.Visible = false;
        }

        #endregion      

        lblMensagen.Visible = false;  

        return true;
    }

    private bool ValidaSafraExistente()
    {
        #region Verifica se já existem preços cadastrados para o Produto

        PessoaTabelaPrecoProduto Obj = new PessoaTabelaPrecoProduto();

        if (Obj.ExistePrecoProduto(Convert.ToInt32(Session["cdCronogramaSafraSEQ"]), Convert.ToInt32(Session["cdCooperativaSEQ"])))
        {
            lblMensagen.Text = "Existe uma tabela de preços cadastrada para essa Safra, será necessário deletá-la antes de continuar!";
            lblMensagen.Visible = true;
            ModalPopupExtender1.Show();
            return false;
        }

        #endregion

        lblMensagen.Visible = false;

        return true;
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
        CronogramaSafraVencimentoCooperativa obj = new CronogramaSafraVencimentoCooperativa();

        gv.DataSource = obj.ObterLista(Convert.ToInt64(Session["cdVencimentoSEQ"])).AsDataView();
        gv.DataBind();
    }

    protected void btCancel_OnClick(object sender, EventArgs e)
    {
        ModalPopupExtender1.Hide();        
    }

 
}
