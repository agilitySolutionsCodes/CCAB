using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_ConsultarCompromisso_ConsultarCompromisso_Filtro : System.Web.UI.UserControl
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
            cdStatus.DataBind();
            cdStatus.Items.Insert(0, new ListItem("", "0"));

            int cdIndicadorStatus = 0;
            if (u.cdPerfilUsuario != 5)
            {
                cdIndicadorStatus = 1;
            }
            CronogramaSafra cronogramasafra = new CronogramaSafra();
            cdCronogramaSafraSEQ.DataSource = cronogramasafra.ObterLista("", cdIndicadorStatus, "", 0, 0);
            cdCronogramaSafraSEQ.DataBind();
            cdCronogramaSafraSEQ.Items.Insert(0, new ListItem("", "0"));
            cronogramasafra = null;

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

        _value = Session["cdCronogramaSafraSEQValue"].ToString();
        long _safra = _value == "" ? 0 : Convert.ToInt64(_value);

        _value = Session["cdMoedaValue"].ToString();
        long _moeda = _value == "" ? 0 : Convert.ToInt64(_value);

        _value = Session["cdStatusValue"].ToString();
        long _status = _value == "" ? 0 : Convert.ToInt64(_value);

        _value = Session["cdCompromisso"].ToString();
        long _pedido = _value == "" ? 0 : Convert.ToInt64(_value);

        CompromissoCompra obj = new CompromissoCompra();
        DataTable dt = obj.ObterListaCompromissoCompra(_agente,
                                                       _safra,
                                                       _moeda,
                                                       _pedido,
                                                       _status,
                                                       _origem);

        GridView gv = (GridView)Parent.FindControl("Resultado1").FindControl("GridView1");
        gv.DataSource = dt.AsDataView();
        gv.DataBind();

        Usuario u = (Usuario)Session["Usuario"];
        Pessoa pes = new Pessoa();
        DataTable dtPessoa = pes.ObterDadosPerfil(u.cdUsuario);
        int _cdIndicadorTipoPerfilPessoa = 0;
        if (dtPessoa != null && dtPessoa.Rows.Count > 0)
            _cdIndicadorTipoPerfilPessoa = Convert.ToInt32(dtPessoa.Rows[0]["cdIndicadorTipoPerfilPessoa"]);

        Button bt = (Button)Parent.FindControl("Resultado1").FindControl("btAction");
        bt.Visible = dt.Rows.Count > 0;
        bt.Attributes.Add("onclick", string.Format("javascript:ExibirRelatorioLista('{0}','{1}','{2}','{3}','{4}', '{5}', '{6}'); return false;", _pedido, _agente, _safra, _status, _moeda, _origem, (_cdIndicadorTipoPerfilPessoa ==5)?"S": "N"));

        Button btResumoSituacao = (Button)Parent.FindControl("Resultado1").FindControl("btResumoSituacao");
        btResumoSituacao.Visible = dt.Rows.Count > 0;

        btResumoSituacao.Attributes.Remove("onclick");
        btResumoSituacao.Attributes.Add("onclick", string.Format("javascript:ExibirRelatorioCompromissoCompraResumoPorSituacao('{0}','{1}','{2}','{3}','{4}', '{5}'); return false;", _pedido, _agente, _safra, _status, _moeda, _origem));

        Button btCompromissoCompraSintetico = (Button)Parent.FindControl("Resultado1").FindControl("btCompromissoCompraSintetico");
        btCompromissoCompraSintetico.Visible = dt.Rows.Count > 0;

        btCompromissoCompraSintetico.Attributes.Remove("onclick");
        btCompromissoCompraSintetico.Attributes.Add("onclick", string.Format("javascript:ExibirRelatorioCompromissoCompraSintetico('{0}','{1}','{2}','{3}','{4}', '{5}', '{6}'); return false;", _pedido, _agente, _safra, _status, _moeda, _origem, (_cdIndicadorTipoPerfilPessoa == 5) ? "S" : "N"));


        Button btCompromissoCompraAnaliticoSimples = (Button)Parent.FindControl("Resultado1").FindControl("btCompromissoCompraAnaliticoSimples");
        btCompromissoCompraAnaliticoSimples.Visible = dt.Rows.Count > 0;

        btCompromissoCompraAnaliticoSimples.Attributes.Remove("onclick");
        btCompromissoCompraAnaliticoSimples.Attributes.Add("onclick", string.Format("javascript:ExibirRelatorioCompromissoCompraAnaliticoSimples('{0}','{1}','{2}','{3}','{4}', '{5}', '{6}'); return false;", _pedido, _agente, _safra, _status, _moeda, _origem, (_cdIndicadorTipoPerfilPessoa == 5) ? "S" : "N"));
        
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

            if (cdAgente.Items.Count != 1)
            {
                cdAgente.DataBind();
                cdAgente.Items.Insert(0, new ListItem("", "0"));
            }
            MontarComboSafra();
        }
    }

    protected void cdAgente_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (cdAgente.SelectedValue == "0")
        {
            cdCronogramaSafraSEQ.SelectedIndex = -1;
            cdMoeda.SelectedIndex = -1;
            cdCompromisso.Text = "";
            cdStatus.SelectedIndex = -1;
        }
        MontarComboSafra();
    }

}
