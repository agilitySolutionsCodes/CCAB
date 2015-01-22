using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;
using Conv;

public partial class _SFA_CompromissoCompra_NovoCompromisso_Passo1 : System.Web.UI.UserControl
{
    PVPasso1 p1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Usuario u = (Usuario)Session["Usuario"];
            Session["cdUsuario"] = u.cdUsuario;
            
            Session["cdCompromissoCompra"] = null;
            Session["PVPasso1"] = null;
            Session["PVPasso1OLD"] = null;

            p1 = new PVPasso1();

            cdPessoaOrigemFaturamento.Enabled = false;
            //cdPessoaOrigemFaturamento.DataBind();
            //cdPessoaOrigemFaturamento.Items.Insert(0, new ListItem("", "0"));

            cdCronogramaSafraSEQ.DataBind();
            cdCronogramaSafraSEQ.Items.Insert(0, new ListItem("", "0"));

            cdMoeda.DataBind();
            cdMoeda.Items.Insert(0, new ListItem("", "0"));
        }
        else
            p1 = (PVPasso1)Session["PVPasso1"];
    }


    private void MontarComboSafra()
    {

        CronogramaSafra cronogramasafra = new CronogramaSafra();

        cdCronogramaSafraSEQ.DataSourceID = null;
        cdCronogramaSafraSEQ.DataSource = cronogramasafra.ObterLista("", 1, "", Convert.ToInt64(cdAgente.SelectedValue.ToString()), 1);
        cdCronogramaSafraSEQ.DataBind();
        cdCronogramaSafraSEQ.Items.Insert(0, new ListItem("", "0"));
        cronogramasafra = null;

    }

    protected void Page_UnLoad(object sender, EventArgs e)
    {
        Session["PVPasso1"] = p1;
    }

    protected void cdAgente_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (cdAgente.Items.Count == 0)
            {
                p1 = new PVPasso1();
                return;
            }

            if (cdAgente.Items.Count != 1)
            {
                cdAgente.DataBind();
                cdAgente.Items.Insert(0, new ListItem("", "0"));
            }

            if (cdAgente.SelectedValue != "0")
            {
                p1.cdAgente = cdAgente.SelectedValue;
                p1.nmAgente = cdAgente.SelectedItem.Text;
            }
            MontarComboSafra();
            MontarComboOrigemFaturamento();
        }  
    }

    protected void cdAgente_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (cdAgente.SelectedValue != "0")
        {
            p1.cdAgente = cdAgente.SelectedValue;
            p1.nmAgente = cdAgente.SelectedItem.Text;
        }
        //else
        //    p1 = new PVPasso1();
        
        MontarComboSafra();
        MontarComboOrigemFaturamento();
    }

    protected void cdOrigemFaturamento_SelectedIndexChanged(object sender, EventArgs e)
    {
        p1.cdOrigemFaturamento = cdPessoaOrigemFaturamento.SelectedValue;
        p1.nmOrigemFaturamento = cdPessoaOrigemFaturamento.SelectedItem.Text;
        //p1.cdMoeda = null;
        //p1.nmMoeda = null;
    }

    protected void cdSafra_SelectedIndexChanged(object sender, EventArgs e)
    {
        p1.cdSafra = cdCronogramaSafraSEQ.SelectedValue;
        p1.nmSafra = cdCronogramaSafraSEQ.SelectedItem.Text;

        MontarComboOrigemFaturamento();
    }

    protected void cdMoeda_SelectedIndexChanged(object sender, EventArgs e)
    {
        p1.cdMoeda = cdMoeda.SelectedValue;
        p1.nmMoeda = cdMoeda.SelectedItem.Text;
    }

    private void MontarComboOrigemFaturamento()
    {
        Int32 cdCronogramaSafraSEQ_aux = 0;
        if (cdCronogramaSafraSEQ.SelectedValue.ToString() != "")
        {
            cdCronogramaSafraSEQ_aux = Convert.ToInt32(cdCronogramaSafraSEQ.SelectedValue);
        }

        if (Convert.ToInt64(cdAgente.SelectedValue) != 0 & cdCronogramaSafraSEQ_aux != 0)
        {
            cdPessoaOrigemFaturamento.Enabled = true;

            CronogramaSafraOrigemFaturamento cronogramasafraorigemfaturamento = new CronogramaSafraOrigemFaturamento();

            cdPessoaOrigemFaturamento.DataValueField = "cdOrigemFaturamentoSEQ";
            cdPessoaOrigemFaturamento.DataTextField = "dsFaturamento";
            cdPessoaOrigemFaturamento.DataSource = cronogramasafraorigemfaturamento.ObterLista(cdCronogramaSafraSEQ_aux, Convert.ToInt32(cdAgente.SelectedValue));
            cdPessoaOrigemFaturamento.DataBind();
            cdPessoaOrigemFaturamento.Items.Insert(0, new ListItem("", "0"));

            cronogramasafraorigemfaturamento = null;
        }
        else
        {
            cdPessoaOrigemFaturamento.Enabled = false;
        }
    }
    protected void cdCronogramaSafraSEQ_PreRender(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            if (cdCronogramaSafraSEQ.Items.Count > 0)
            {
                p1.cdSafra = cdCronogramaSafraSEQ.SelectedValue;
                p1.nmSafra = cdCronogramaSafraSEQ.SelectedItem.Text;
            }
            else
            {
                p1.cdSafra = null;
                p1.nmSafra = null;
            }

            MontarComboOrigemFaturamento();
        }
    }
}
