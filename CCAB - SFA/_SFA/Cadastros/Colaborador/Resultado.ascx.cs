using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;

public partial class _SFA_Colaborador_Resultado : System.Web.UI.UserControl
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
            Session["ColaboradorGridViewSelected"] = GridView1.SelectedDataKey.Value.ToString();
            Session["ColaboradorGridViewIndex"] = GridView1.SelectedIndex;
        }
        catch
        {
            Session["ColaboradorGridViewSelected"] = "0";
            Session["ColaboradorGridViewIndex"] = "0";
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
        Int64 _cdPessoaSEQ = _value == "" ? 0 : Convert.ToInt64(_value);

        GridView gv = (GridView)Parent.FindControl("Resultado1").FindControl("GridView1");
        Pessoa obj = new Pessoa();

        gv.DataSource = obj.ObterListaColaborador(_cdPessoaSEQ,
                                      Session["dsLoginPessoa"].ToString(),
                                      _cpf,
                                      Session["nmFoneticoPessoa"].ToString(),
                                      _status,
                                      _locked,
                                      _perfil,
                                      _empresa).AsDataView();
        gv.DataBind();
    }

    protected void ReloadGridView()
    {
        BindGridView();
        GridView1.SelectedIndex = Convert.ToInt16(Session["ColaboradorGridViewIndex"]);
        try
        {
            Session["ColaboradorGridViewSelected"] = GridView1.SelectedDataKey.Value.ToString();
        }
        catch
        {
        }
    }
}
