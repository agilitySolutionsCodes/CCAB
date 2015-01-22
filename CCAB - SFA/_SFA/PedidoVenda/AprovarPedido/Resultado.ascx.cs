using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_PedidoVenda_AprovarPedido_Resultado : System.Web.UI.UserControl
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

        _value = Session["cdPessoaOrigemFaturamentoValue"].ToString();
        long _origem = _value == "" ? 0 : Convert.ToInt64(_value);

        _value = Session["cdClienteFaturamentoValue"].ToString();
        long _cliente = _value == "" ? 0 : Convert.ToInt64(_value);

        _value = Session["cdClienteEntregaValue"].ToString();
        long _entrega = _value == "" ? 0 : Convert.ToInt64(_value);

        _value = Session["cdCronogramaSafraSEQValue"].ToString();
        long _safra = _value == "" ? 0 : Convert.ToInt64(_value);

        _value = Session["cdMoedaValue"].ToString();
        long _moeda = _value == "" ? 0 : Convert.ToInt64(_value);

        _value = Session["cdPedido"].ToString();
        long _pedido = _value == "" ? 0 : Convert.ToInt64(_value);

        _value = Session["cdTipoPedidoValue"].ToString();
        long _tipopedido = _value == "" ? 0 : Convert.ToInt64(_value);


        GridView gv = (GridView)Parent.FindControl("Resultado1").FindControl("GridView1");

        PedidoVenda obj = new PedidoVenda();

        DataTable dt = obj.ObterListaPedidoVendaAprovacao(_agente,
                                                         _safra,
                                                         _cliente,
                                                         _entrega,
                                                         _moeda,
                                                         _pedido,
                                                         _origem,
                                                         _tipopedido);

        btAction.Visible = dt.Rows.Count > 0;
        btAction2.Visible = dt.Rows.Count > 0;

        GridView1.DataSource = dt.AsDataView();

        GridView1.DataBind();  
    }

    protected void btAction_Click(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder();
        string msg = "";

        int i = 0;
        while (i < GridView1.Rows.Count)
        {
            GridViewRow row = GridView1.Rows[i];

            CheckBox chk = (CheckBox)row.FindControl("chkSelect");

            if (chk.Checked)
            {
                if (sb.Length > 0) sb.Append(",");
                LinkButton lb = (LinkButton)GridView1.Rows[i].Cells[1].FindControl("Linkbutton1");
                sb.Append(lb.Text);
            }

            i++;
        }

        if (sb.Length > 0)
        {
            PedidoVenda obj = new PedidoVenda();
            msg = obj.AprovaPedidoCCAB(Convert.ToInt64(Session["cdUsuario"]), sb.ToString());
        }
        else
            msg = "Nenhum Pedido foi Selecionado";

        if (msg == "")
        {
            Session["ShowMessage"] = true;
        }
        else
        {
            CustomValidator cv = (CustomValidator)Parent.FindControl("CustomValidator1");
            cv.IsValid = false;
            cv.ErrorMessage = msg;
        }
        
        BindGridView();
    }



    protected void btAction2_Click(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder();
        string msg = "";

        int i = 0;
        while (i < GridView1.Rows.Count)
        {
            GridViewRow row = GridView1.Rows[i];

            CheckBox chk = (CheckBox)row.FindControl("chkSelect");

            if (chk.Checked)
            {
                if (sb.Length > 0) sb.Append(",");
                LinkButton lb = (LinkButton)GridView1.Rows[i].Cells[1].FindControl("Linkbutton1");
                sb.Append(lb.Text);
            }

            i++;
        }

        if (sb.Length > 0)
        {
            PedidoVenda obj = new PedidoVenda();
            msg = obj.RejeitarPedidoCCAB(Convert.ToInt64(Session["cdUsuario"]), sb.ToString());
        }
        else
            msg = "Nenhum Pedido foi Selecionado";

        if (msg == "")
        {
            Session["ShowMessage"] = true;
        }
        else
        {
            CustomValidator cv = (CustomValidator)Parent.FindControl("CustomValidator1");
            cv.IsValid = false;
            cv.ErrorMessage = msg;
        }

        BindGridView();
    }

}
