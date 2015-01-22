using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_Permissao_Permissao : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["PermissaoGridViewSelected"] = "0";
            string _op = Page.Request.UrlReferrer.ToString().Contains("?") ? "&" : "?";
            btVoltar.PostBackUrl = Page.Request.UrlReferrer.ToString().Contains("ta=ret")
                                   ? Page.Request.UrlReferrer.ToString()
                                   : Page.Request.UrlReferrer.ToString() +
                                   _op + "ta=ret";
        

            lbNomeTela.Text = "Permissões";

            StringBuilder sb = new StringBuilder();

            try
            {
                sb.Append("Grupo de Acesso: (" + Session["cdGrupoAcessoSEQ"].ToString() + ") " + Session["dsGrupoAcessoHistorico"].ToString());
            }
            catch { Response.Redirect("~/_SFA/Cadastros/GrupoAcesso/GrupoAcesso.aspx"); }

            lbDadosPai.Text = sb.ToString();

            LoadData();
        }
    }
    
    
    internal void LoadData()
    {
        GrupoAcesso obj = new GrupoAcesso();

        GridView1.DataSource = obj.ObterListaPermissao(Convert.ToInt64(Session["cdGrupoAcessoSEQ"])).AsDataView();
        GridView1.DataBind();  
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView drv = (DataRowView)e.Row.DataItem;
            CheckBox c;
            
            c = (CheckBox)e.Row.FindControl("chkPesquisar");
            c.Checked = Convert.ToBoolean(drv.Row["Pesquisar_Value"]);
            c.Enabled = Convert.ToBoolean(drv.Row["Pesquisar_Enabled"]);

            c = (CheckBox)e.Row.FindControl("chkIncluir");
            c.Checked = Convert.ToBoolean(drv.Row["Incluir_Value"]);
            c.Enabled = Convert.ToBoolean(drv.Row["Incluir_Enabled"]);

            c = (CheckBox)e.Row.FindControl("chkAlterar");
            c.Checked = Convert.ToBoolean(drv.Row["Alterar_Value"]);
            c.Enabled = Convert.ToBoolean(drv.Row["Alterar_Enabled"]);

            c = (CheckBox)e.Row.FindControl("chkExcluir");
            c.Checked = Convert.ToBoolean(drv.Row["Excluir_Value"]);
            c.Enabled = Convert.ToBoolean(drv.Row["Excluir_Enabled"]);

            c = (CheckBox)e.Row.FindControl("chkVisualizar");
            c.Checked = Convert.ToBoolean(drv.Row["Visualizar_Value"]);
            c.Enabled = Convert.ToBoolean(drv.Row["Visualizar_Enabled"]);
        }
    }

    protected void btSalvar_OnClick(object sender, EventArgs e)
    {
        DataTable dt = CreateDataTable();
        DataRowCollection rowCollection = dt.Rows;
        string msg = "";

        foreach (GridViewRow gr in GridView1.Rows)
        {
            if (gr.RowType == DataControlRowType.DataRow)
            {
                DataRow r = dt.NewRow();
                r["cdItemMenu"] = Convert.ToInt64(gr.Cells[0].Text); 
                //r["dsItemMenu"] = "";

                r["Pesquisar_Value"] = ((CheckBox)gr.FindControl("chkPesquisar")).Checked;
                r["Incluir_Value"] = ((CheckBox)gr.FindControl("chkIncluir")).Checked; 
                r["Alterar_Value"] = ((CheckBox)gr.FindControl("chkAlterar")).Checked; 
                r["Excluir_Value"] = ((CheckBox)gr.FindControl("chkExcluir")).Checked;
                r["Visualizar_Value"] = ((CheckBox)gr.FindControl("chkVisualizar")).Checked;

                /*
                r["Pesquisar_Enabled"] = ((CheckBox)gr.FindControl("chkPesquisar")).Enabled;
                r["Incluir_Enabled"] = ((CheckBox)gr.FindControl("chkIncluir")).Enabled;
                r["Alterar_Enabled"] = ((CheckBox)gr.FindControl("chkAlterar")).Enabled;
                r["Excluir_Enabled"] = ((CheckBox)gr.FindControl("chkExcluir")).Enabled;
                r["Visualizar_Enabled"] = ((CheckBox)gr.FindControl("chkVisualizar")).Enabled;
                */

                dt.Rows.Add(r);
            }
        }

        if (dt.Rows.Count > 0)
        {
            GrupoAcesso obj = new GrupoAcesso();
            msg = obj.SalvarPermissao(Convert.ToInt64(Session["cdGrupoAcessoSEQ"]), dt);
        }

        if (msg != "")
        {
            CustomValidator1.IsValid = false;
            CustomValidator1.ErrorMessage = msg;
        }  
        else
            Response.Redirect(btVoltar.PostBackUrl);
    }

    public DataTable CreateDataTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("cdItemMenu", System.Type.GetType("System.Int32"));
        //dt.Columns.Add("dsItemMenu", System.Type.GetType("System.String"));

        dt.Columns.Add("Pesquisar_Value", System.Type.GetType("System.Boolean"));
        dt.Columns.Add("Incluir_Value", System.Type.GetType("System.Boolean"));
        dt.Columns.Add("Alterar_Value", System.Type.GetType("System.Boolean"));
        dt.Columns.Add("Excluir_Value", System.Type.GetType("System.Boolean"));
        dt.Columns.Add("Visualizar_Value", System.Type.GetType("System.Boolean"));

        /*
        dt.Columns.Add("Pesquisar_Enabled", System.Type.GetType("System.Boolean"));
        dt.Columns.Add("Incluir_Enabled", System.Type.GetType("System.Boolean"));
        dt.Columns.Add("Alterar_Enabled", System.Type.GetType("System.Boolean"));
        dt.Columns.Add("Excluir_Enabled", System.Type.GetType("System.Boolean"));
        dt.Columns.Add("Visualizar_Enabled", System.Type.GetType("System.Boolean"));
        */

        return dt;
    }
}
