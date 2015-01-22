using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;

public partial class _SFA_CompromissoCompra_AlterarCompromisso_Resultado : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
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
        string _value;

        _value = Session["cdAgenteValue"].ToString();
        long _agente = _value == "" ? 0 : Convert.ToInt64(_value);

        //_value = Session["cdPessoaOrigemFaturamento"].ToString();
        //long _origem = _value == "" ? 0 : Convert.ToInt64(_value);
        long _origem = 0;

        _value = Session["cdCronogramaSafraSEQValue"].ToString();
        long _safra = _value == "" ? 0 : Convert.ToInt64(_value);

        _value = Session["cdMoedaValue"].ToString();
        long _moeda = _value == "" ? 0 : Convert.ToInt64(_value);

        _value = Session["cdStatusValue"].ToString();
        long _status = _value == "" ? 0 : Convert.ToInt64(_value);

        _value = Session["cdCompromisso"].ToString();
        long _pedido = _value == "" ? 0 : Convert.ToInt64(_value);

        GridView gv = (GridView)Parent.FindControl("Resultado1").FindControl("GridView1");
        CompromissoCompra obj = new CompromissoCompra();

        gv.DataSource = obj.ObterListaCompromissoCompra(_agente,
                                                  _safra,
                                                  _moeda,
                                                  _pedido,
                                                  _status,
                                                  _origem).AsDataView();
        gv.DataBind(); 
    }

    protected void GridView_OnClick(object sender, EventArgs e)
    {
        LinkButton bt = (LinkButton)sender;
        CompromissoCompra obj = new CompromissoCompra();
        string msg = obj.IncluirTmp_Alteracao(Convert.ToInt64(bt.CommandArgument));
        
        if (msg == "")
        {
            Session["cdCompromissoCompraGrid"] = bt.CommandArgument;
            Session["cdCompromissoCompra"] = obj.tmpCompromissoCompraSEQ;
            Response.Redirect("AlterarCompromisso.aspx", true);
        }
        else
        {
            CustomValidator cv = (CustomValidator)Parent.FindControl("CustomValidator1");
            cv.IsValid = false;
            cv.ErrorMessage = msg;
        }
    }
}
