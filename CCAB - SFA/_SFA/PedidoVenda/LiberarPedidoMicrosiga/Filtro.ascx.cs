using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_LiberarPedidoMicrosiga_LiberarPedidoMicrosiga_Filtro : System.Web.UI.UserControl
{
    internal Conv.Lib lib = new Conv.Lib();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Usuario u = (Usuario)Session["Usuario"];
            Session["cdUsuario"] = u.cdUsuario;

            cdPessoaOrigemFaturamento.DataBind();
            cdPessoaOrigemFaturamento.Items.Insert(0, new ListItem("", "0"));
            cdCronogramaSafraSEQ.DataBind();
            cdCronogramaSafraSEQ.Items.Insert(0, new ListItem("", "0"));
            cdMoeda.DataBind();
            cdMoeda.Items.Insert(0, new ListItem("", "0"));
        }
        else
        {
            SaveFilter();
            RestoreFilter();
        }
    }

    protected void cdCronogramaSafraSEQAno_SelectedIndexChanged(object sender, EventArgs e)
    {
        MontarComboSafra();
    }


    private void MontarComboSafra()
    {
        CronogramaSafra cronogramasafra = new CronogramaSafra();

        cdCronogramaSafraSEQ.DataSourceID = null;
        cdCronogramaSafraSEQ.DataSource = cronogramasafra.ObterLista("", 0, cdCronogramaSafraSEQAno.SelectedValue.ToString(), Convert.ToInt64(cdAgente.SelectedValue.ToString()), 0);
        cdCronogramaSafraSEQ.DataBind();

        cronogramasafra = null;

    }

    protected void btPesquisar_OnClick(object sender, EventArgs e)
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

        DataTable dt = obj.ObterListaPedidoVendaLiberacaoMicrosiga(_agente,
                                                                   _safra, 
                                                                   _cliente,
                                                                   _entrega, 
                                                                   _moeda,
                                                                   _pedido,
                                                                   _origem,
                                                                   _tipopedido);

        Button bt = (Button)Parent.FindControl("Resultado1").FindControl("btAction");
        bt.Visible = dt.Rows.Count > 0;

        gv.DataSource = dt.AsDataView();

        gv.DataBind();   
        
    }

    internal void SaveFilter()
    {
        string _key = "";
        string _value = "";
        foreach (Control c in this.Controls)
        {
            if (c is GridView)
                break;
            
            if (c is TextBox)
            {
                TextBox ctrl = (TextBox)c;
                _key = ctrl.ID;
                _value = ctrl.Text;
            }

            if (c is HiddenField)
            {
                HiddenField ctrl = (HiddenField)c;
                _key = ctrl.ID;
                _value = ctrl.Value;
            }

            Session[_key] = _value;
        }
    }

    internal void RestoreFilter()
    {
        foreach (Control c in this.Controls)
        {
            if (c is GridView)
                break;
            
            if (c is TextBox)
            {
                TextBox ctrl = (TextBox)c;
                try
                {
                    ctrl.Text = Session[ctrl.ID].ToString();
                }
                catch (Exception) // 1ª exibição da página (valores não existem)
                {
                    ctrl.Text = "";
                }
            }

            if (c is HiddenField)
            {
                HiddenField ctrl = (HiddenField)c;
                try
                {
                    ctrl.Value = Session[ctrl.ID].ToString();
                }
                catch (Exception) // 1ª exibição da página (valores não existem)
                {
                    ctrl.Value = "";
                }
            }
        }
    }

    protected void cdAgente_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (cdAgente.Items.Count == 0)
                return;

            if (cdAgente.Items.Count == 1)
            {
                cdClienteFaturamento.DataBind();
                if (cdClienteFaturamento.Items.Count > 1)
                {
                    cdClienteFaturamento.Items.Insert(0, new ListItem("", "0"));
                }
                cdClienteFaturamento.Enabled = true;
            }
            else
            {
                cdAgente.DataBind();
                cdAgente.Items.Insert(0, new ListItem("", "0"));
            }

            cdTipoPedido.DataBind();
            cdTipoPedido.Items.Insert(0, new ListItem("", "0"));

            MontarComboSafra();
        }
        
    }

    protected void cdAgente_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (cdAgente.SelectedValue != "0")
        {
            cdClienteFaturamento.DataBind();

            cdClienteFaturamento.Items.Insert(0, new ListItem("", "0"));

            cdClienteFaturamento.Enabled = true;
        }
        else
        {
            cdClienteFaturamento.Items.Clear();
            cdClienteFaturamento.Enabled = false;
            cdClienteEntrega.Items.Clear(); ;
            cdClienteEntrega.Enabled = false;
            cdCronogramaSafraSEQ.SelectedIndex = -1;
            cdMoeda.SelectedIndex = -1;
        }
        MontarComboSafra();
    }

    protected void cdClienteFaturamento_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (cdClienteFaturamento.SelectedValue != "0")
        {
            cdClienteEntrega.DataBind();

            cdClienteEntrega.Items.Insert(0, new ListItem("", "0"));

            cdClienteEntrega.Enabled = true;
        }
        else
        {
            cdClienteEntrega.Items.Clear();
            cdClienteEntrega.Enabled = false;
        }
    }
}
