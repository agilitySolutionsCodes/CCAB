using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_PedidoVenda_ConsultarPedido_Resultado : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Usuario u = (Usuario)Session["Usuario"];
        //if (u.cdPerfilUsuario != 5)
        //    btnPrePedido.Enabled = false;
    }

    protected void btViewERP_Click(object sender, EventArgs e)
    {
        LinkButton bt = (LinkButton)sender;
        Session["cdPedidoSFA"] = bt.CommandArgument;

        Button btnImprimirTodos = (Button)Parent.FindControl("Formulario1").FindControl("btnImprimirTodos");
        btnImprimirTodos.Attributes.Remove("onclick");
        //btnImprimirTodos.Attributes.Add("onclick", string.Format("javascript:ExibirRelatorioPrePedido('{0}','{1}'); return false;", Session["cdPedidoSFA"].ToString(), 0));
        btnImprimirTodos.Attributes.Add("onclick", string.Format("javascript:ExibirRelatorioPrePedido('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}'); return false;", 'T', Session["cdPedidoSFA"].ToString(), 0, 0, 0, 0, 0, 0, 0, 0));
        

        ModalPopupExtender mp = (ModalPopupExtender)Parent.FindControl("Formulario1").FindControl("ModalPopupExtender1");
        mp.Show();
    }

    protected void RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView drv = (DataRowView)e.Row.DataItem;
            int _status = Convert.ToInt32(drv.Row["cdIndicadorStatusPedidoVenda"]);
            Usuario u = (Usuario)Session["Usuario"];

            //if (_status < 5 || u.cdPerfilUsuario != 5)
            if (_status < 5)
            {
                LinkButton bt = (LinkButton)e.Row.FindControl("btViewERP");
                bt.Enabled = false;
            }

            if (_status == 7 || _status == 8) // Erro no Microsiga
            {
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FF0000");
            }
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

        _value = Session["cdStatusValue"].ToString();
        long _status = _value == "" ? 0 : Convert.ToInt64(_value);

        _value = Session["cdPedido"].ToString();
        long _pedido = _value == "" ? 0 : Convert.ToInt64(_value);

        _value = Session["cdTipoPedidoValue"].ToString();
        long _tipopedido = _value == "" ? 0 : Convert.ToInt64(_value);


        GridView gv = (GridView)Parent.FindControl("Resultado1").FindControl("GridView1");

        PedidoVenda obj = new PedidoVenda();

        DataTable dt = obj.ObterListaPedidoVenda(_agente,
                                                 _safra,
                                                 _cliente,
                                                 _entrega,
                                                 _moeda,
                                                 _pedido,
                                                 _status,
                                                 _origem,
                                                 _tipopedido); 
        
        btAction.Visible = dt.Rows.Count > 0;

        GridView1.DataSource = dt.AsDataView();

        GridView1.DataBind();

    }
}
