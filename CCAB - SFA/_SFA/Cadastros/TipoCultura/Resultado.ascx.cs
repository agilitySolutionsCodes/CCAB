using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;

public partial class _SFA_TipoCultura_Resultado : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["ta"] == "ret") //retorno de sub módulo
            ReloadGridView();
        
        GridView_SelectedIndexChanged(sender, e);
    }

    protected void GridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            Session["TipoCulturaGridViewSelected"] = GridView1.SelectedDataKey.Value.ToString();
            Session["TipoCulturaGridViewIndex"] = GridView1.SelectedIndex;
        }
        catch
        {
            Session["TipoCulturaGridViewSelected"] = "0";
            Session["TipoCulturaGridViewIndex"] = "0";
            GridView1.SelectedIndex = 0;
        }
    }

    protected string ConvertSortDirectionToSql(SortDirection sortDirection)
    {
        string m_SortDirection = String.Empty;

        switch (sortDirection)
        {
            case SortDirection.Ascending:
            m_SortDirection = "ASC";
            break;

            case SortDirection.Descending:
            m_SortDirection = "DESC";
            break;
        }

        return m_SortDirection;
    }

    protected void GridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        BindGridView();

        GridView1.PageIndex = e.NewPageIndex;
        GridView1.DataBind();
    }

    protected void GridView_Sorting(object sender, GridViewSortEventArgs e)
    {
        BindGridView();
        DataView m_DataView = (DataView)GridView1.DataSource;

        if (m_DataView != null)
        {
            m_DataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);

            GridView1.DataSource = m_DataView;
            GridView1.DataBind();
        }
    }

    public void BindGridView()
    {
        string _value = Session["cdTipoCulturaSEQ"].ToString();
        long _cod = _value == "" ? 0 : Convert.ToInt64(_value);

        _value = Session["cdIndicadorStatusTipoCulturaValue"].ToString();
        int _status = _value == "" ? 0 : Convert.ToInt32(_value);

        GridView gv = (GridView)Parent.FindControl("Resultado1").FindControl("GridView1");
        TipoCultura obj = new TipoCultura();

        gv.DataSource = obj.ObterLista(_cod,
                                      Session["dsTipoCultura"].ToString(),
                                      _status).AsDataView();
        gv.DataBind();    
    }

    protected void ReloadGridView()
    {
        BindGridView();
        GridView1.SelectedIndex = Convert.ToInt16(Session["TipoCulturaGridViewIndex"]);
        //Session["TipoCulturaGridViewSelected"] = GridView1.SelectedDataKey.Value.ToString();
    }
}
