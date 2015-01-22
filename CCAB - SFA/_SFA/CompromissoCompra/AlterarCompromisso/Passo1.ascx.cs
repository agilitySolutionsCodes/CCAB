using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;
using Conv;

public partial class _SFA_CompromissoCompra_AlterarCompromisso_Passo1 : System.Web.UI.UserControl
{
    PVPasso1 p1;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["cdCompromissocompra"] == null)
            return;

        if (!IsPostBack)
        {
            Usuario u = (Usuario)Session["Usuario"];
            Session["cdUsuario"] = u.cdUsuario;
            Create_Passo1Obj();
        }
        else
            p1 = (PVPasso1)Session["PVPasso1"];

        Update_PageControls();
    }


    protected void Create_Passo1Obj()
    {
        Session["PVPasso1"] = null;

        CompromissoCompra obj = new CompromissoCompra();
        DataTable tb = obj.ObterResumoDadosTMP(Convert.ToInt64(Session["cdCompromissoCompra"].ToString()));

        if (tb.Rows.Count > 0)
        {
            DataRow r = tb.Rows[0];
            p1 = new PVPasso1();

            p1.nrPedidoVenda = Session["cdCompromissoCompraGrid"].ToString();
            p1.cdStatus = r["cdIndicadorStatusCompromissoCompra"].ToString();
            p1.nmStatus = r["dsIndicadorStatusCompromissoCompra"].ToString();
            p1.cdAgente = r["cdAgenteComercialCooperativaCompromissoCompra"].ToString();
            p1.nmAgente = r["dsAgenteComercialCooperativaCompromissoCompra"].ToString();
            p1.cdSafra = r["cdCronogramaSafraSEQ"].ToString();
            p1.nmSafra = r["dsCronogramaSafra"].ToString();
            p1.cdMoeda = r["cdIndicadorMoedaCompromissoCompra"].ToString();
            p1.nmMoeda = r["dsIndicadorMoedaCompromissoCompra"].ToString();
            p1.cdOrigemFaturamento = r["cdPessoaOrigemFaturamento"].ToString();
            p1.nmOrigemFaturamento = r["dsPessoaOrigemFaturamento"].ToString();
        }
    }

    protected void Update_PageControls()
    {
        cdAgente.DataBind();
        cdAgente.SelectedValue = p1.cdAgente;

        cdCronogramaSafraSEQ.DataBind();
        cdCronogramaSafraSEQ.SelectedValue = p1.cdSafra;

        cdMoeda.DataBind();
        cdMoeda.SelectedValue = p1.cdMoeda;

        cdCompromisso.Text = p1.nrPedidoVenda;

        cdStatus.DataBind();
        cdStatus.SelectedValue = p1.cdStatus;

        cdPessoaOrigemFaturamento.DataBind();
        cdPessoaOrigemFaturamento.SelectedValue = p1.cdOrigemFaturamento;

    }

    protected void Page_UnLoad(object sender, EventArgs e)
    {
        Session["PVPasso1"] = p1;
    }
}
