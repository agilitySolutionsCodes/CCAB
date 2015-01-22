using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;
using Conv;

public partial class _SFA_PedidoVenda_AlterarPedido_Passo1 : System.Web.UI.UserControl
{
    PVPasso1 p1;


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["cdPedidoVenda"] == null)
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

        PedidoVenda obj = new PedidoVenda();
        DataTable tb = obj.ObterResumoDadosTMP(Convert.ToInt64(Session["cdPedidoVenda"].ToString()));
        
        if (tb.Rows.Count > 0)
        {
            DataRow r = tb.Rows[0];
            p1 = new PVPasso1();

            p1.nrPedidoVenda = Session["cdPedidoVendaGrid"].ToString();
            p1.cdStatus = r["cdIndicadorStatusPedidoVenda"].ToString();
            p1.nmStatus = r["dsIndicadorStatusPedidoVenda"].ToString();
            p1.cdAgente = r["cdAgenteComercialCooperativaPedidoVenda"].ToString();
            p1.nmAgente = r["dsAgenteComercialCooperativaPedidoVenda"].ToString();
            p1.cdFaturamento = r["cdClienteFaturamentoPedidoVenda"].ToString();
            p1.nmFaturamento = r["dsClienteFaturamentoPedidoVenda"].ToString();
            p1.cdEntrega = r["cdClienteEntregaPedidoVenda"].ToString();
            p1.nmEntrega = r["dsClienteEntregaPedidoVenda"].ToString();
            p1.cdSafra = r["cdCronogramaSafraSEQ"].ToString();
            p1.nmSafra = r["dsCronogramaSafra"].ToString();
            p1.cdMoeda = r["cdIndicadorMoedaPedidoVenda"].ToString();
            p1.nmMoeda = r["dsIndicadorMoedaPedidoVenda"].ToString();
            p1.cdOrigemFaturamento = r["cdPessoaOrigemFaturamento"].ToString();
            p1.nmOrigemFaturamento = r["dsPessoaOrigemFaturamento"].ToString();
            p1.cdTipoPedido = r["cdTipoPedidoVenda"].ToString();
            p1.cdTipoProduto = r["cdTipoProduto"].ToString(); 
            

        }
    }

    protected void Update_PageControls()
    {
        cdAgente.DataBind();
        cdAgente.SelectedValue = p1.cdAgente;

        if (!IsPostBack)
        {
            cdClienteFaturamento.DataBind();
            cdClienteFaturamento.SelectedValue = p1.cdFaturamento;

            //Tipo de Pedido
            dropDownListTipoPedido.DataSourceID = "objectDataSourceTipoPedido";
            dropDownListTipoPedido.DataBind();
            dropDownListTipoPedido.SelectedValue = p1.cdTipoPedido;

            MontarComboEntrega();

        }

        cdCronogramaSafraSEQ.DataBind();
        cdCronogramaSafraSEQ.SelectedValue = p1.cdSafra;

        dropDownListRegraProduto.DataSourceID = "dataSourceTipoProduto";
        dropDownListRegraProduto.DataBind();
        dropDownListRegraProduto.SelectedValue = p1.cdTipoProduto;
        dropDownListRegraProduto.Enabled = false;
        
        cdPedido.Text = p1.nrPedidoVenda;

        cdStatus.DataBind();
        cdStatus.SelectedValue = p1.cdStatus;

        cdPessoaOrigemFaturamento.DataBind();
        cdPessoaOrigemFaturamento.SelectedValue = p1.cdOrigemFaturamento;


        Usuario u = (Usuario)Session["Usuario"];

        if (u.cdPerfilUsuario != 5 || Convert.ToInt16(p1.cdStatus) > 4)
        {
            if (!"1,4".Contains(p1.cdStatus))
            {
                cdClienteFaturamento.Enabled = false;
                cdClienteEntrega.Enabled = false;
            }
        }

        cdClienteFaturamento.Enabled = false;
        cdClienteEntrega.Enabled = true;
        dropDownListTipoPedido.Enabled = false;


    }

    private void MontarComboEntrega()
    {
        cdClienteEntrega.Items.Clear();
        if (p1.cdTipoPedido == "1")
        {
            Pessoa pessoa = new Pessoa();
            cdClienteEntrega.DataSource = pessoa.ObterListaPedidoClienteEntregaAlteracao(Convert.ToInt64(cdClienteFaturamento.SelectedValue));
            pessoa = null;

        }
        else
        {
            Pessoa pessoa = new Pessoa();
            cdClienteEntrega.DataSource = pessoa.ObterListaPedidoClienteFaturamento(Convert.ToInt64(cdAgente.SelectedValue));
            pessoa = null;
        }
        cdClienteEntrega.DataBind();
        cdClienteEntrega.SelectedValue = p1.cdEntrega;



    }

    protected void cdMoeda_PreRender(object sender, EventArgs e)
    {
        cdMoeda.DataBind();
        cdMoeda.SelectedValue = p1.cdMoeda;
    }

    //protected void dropDownListRegraProduto_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    p1.dropDownListRegraProduto = dropDownListRegraProduto.SelectedValue;
    //    p1.nmdropDownListRegraProduto = dropDownListRegraProduto.SelectedItem.Text;
    //}


    protected void dropDownListTipoPedido_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (dropDownListTipoPedido.SelectedValue.ToString() != "")
        {
            p1.cdTipoPedido = dropDownListTipoPedido.SelectedValue;
            p1.nmTipoPedido = dropDownListTipoPedido.SelectedItem.Text;

            MontarComboEntrega();
        }
    }

    protected void Page_UnLoad(object sender, EventArgs e)
    {
        Session["PVPasso1"] = p1;
    }

    protected void cdClienteFaturamento_SelectedIndexChanged(object sender, EventArgs e)
    {
        p1.cdFaturamento = cdClienteFaturamento.SelectedValue;
        p1.nmFaturamento = cdClienteFaturamento.SelectedItem.Text;
        
        cdClienteEntrega.DataBind();
        p1.cdEntrega = cdClienteEntrega.SelectedValue;
        p1.nmEntrega = cdClienteEntrega.SelectedItem.Text;        
    }

    protected void cdClienteEntrega_SelectedIndexChanged(object sender, EventArgs e)
    {
        p1.cdEntrega = cdClienteEntrega.SelectedValue;
        p1.nmEntrega = cdClienteEntrega.SelectedItem.Text;
    }

    # region Mostra Detalhe de Cliente

    protected void ClienteFaturamento_Link(object sender, EventArgs e)
    {
        ShowClientDetails(cdClienteFaturamento.SelectedValue);
    }

    protected void ClienteEntrega_Link(object sender, EventArgs e)
    {
        ShowClientDetails(cdClienteEntrega.SelectedValue);
    }

    protected void ShowClientDetails(string cdCliente)
    {
        FormView fv = (FormView)Formulario1.FindControl("FormView1");
        Pessoa obj = new Pessoa();
        fv.ChangeMode(FormViewMode.Edit);
        fv.DataSource = obj.ObterCliente(Convert.ToInt64(cdCliente));
        fv.DataBind();

        string DisableOnViewForm = "dsLoginPessoa;cdIndicadorTipoAcessoPessoa;cdIndicadorPrimeiroAcessoPessoa;cdIndicadorSenhaBloqueadaPessoa;cdGrupoAcessoSEQ";
        DisableControls(fv, DisableOnViewForm, "disable");

        // Impede a visualização do Tab de Segurança (TabPanel4)
        TabContainer tc = (TabContainer)fv.Row.FindControl("TabContainer1");
        TabPanel tp = (TabPanel)tc.FindControl("TabPanel4");
        tp.Visible = false;

        Label lb = (Label)fv.Parent.FindControl("lbOperacao");
        lb.Text = "Visualizar Registro";

        // Config do Botão de Ação
        Button btA = (Button)Formulario1.FindControl("btAction");
        btA.Visible = false;

        // Config do Botão de Cancelamento
        Button btC = (Button)Formulario1.FindControl("btCancel");
        btC.Text = "fechar";

        ModalPopupExtender mp = (ModalPopupExtender)Formulario1.FindControl("ModalPopupExtender1");
        mp.Show();
    }

    internal void DisableControls(FormView fv, string _ControlNames, string _mode)
    {
        if (_ControlNames == "") return;

        TabContainer tc = (TabContainer)fv.FindControl("TabContainer1");

        foreach (TabPanel tp in tc.Tabs)
            DisableControlsInContainer(_ControlNames, _mode, (Control)tp);
    }

    internal void DisableControlsInContainer(string _ControlNames, string _mode, Control _container)
    {
        string[] _controls = _ControlNames.Split(new Char[] { ';' });
        foreach (string _controlName in _controls)
        {
            if (_controlName.Trim() != "")
            {
                Control c = (Control)_container.FindControl(_controlName);
                if (c != null)
                {
                    switch (c.GetType().Name)
                    {
                        case "Label":
                            Label l = (Label)c;
                            if (_mode == "disable") l.Enabled = false;
                            if (_mode == "vanish") l.Visible = false;
                            break;
                        case "TextBox":
                            TextBox t = (TextBox)c;
                            if (_mode == "disable") t.Enabled = false;
                            if (_mode == "vanish") t.Visible = false;
                            break;
                        case "DropDownList":
                            DropDownList d = (DropDownList)c;
                            if (_mode == "disable") d.Enabled = false;
                            if (_mode == "vanish") d.Visible = false;
                            break;
                    }
                }
            }
        }
    }

    # endregion
}
