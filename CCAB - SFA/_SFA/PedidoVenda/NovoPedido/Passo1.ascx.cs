using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;
using Conv;

public partial class _SFA_PedidoVenda_NovoPedido_Passo1 : System.Web.UI.UserControl
{
    PVPasso1 p1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Usuario u = (Usuario)Session["Usuario"];
            Session["cdUsuario"] = u.cdUsuario;
            
            Session["cdPedidoVenda"] = null;
            Session["PVPasso1"] = null;
            Session["PVPasso1OLD"] = null;

            p1 = new PVPasso1();

            DesabilitaTodasCombos();

            Pessoa pessoa = new Pessoa();
            cdAgente.DataSource = pessoa.ObterListaPedidoAgente(u.cdUsuario, 1);
            cdAgente.DataBind();
            cdAgente.Items.Insert(0, new ListItem("", "0"));
            pessoa = null;

            CronogramaSafra cronogramasafra = new CronogramaSafra();
            cdCronogramaSafraSEQ.DataSource = cronogramasafra.ObterLista("", 1, "", 0, 0);
            cdCronogramaSafraSEQ.DataBind();
            cdCronogramaSafraSEQ.Items.Insert(0, new ListItem("", "0"));
            cronogramasafra = null;

        }
        else
            p1 = (PVPasso1)Session["PVPasso1"];
    }

    protected void Page_UnLoad(object sender, EventArgs e)
    {
        Session["PVPasso1"] = p1;
    }

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
        if (cdCliente == "0")
            return;

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

    protected void cdAgente_PreRender(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (cdAgente.Items.Count == 0)
            {
                p1 = new PVPasso1();
                return;
            }

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
            if (cdAgente.SelectedValue != "0")
            {
                p1.cdAgente = cdAgente.SelectedValue;
                p1.nmAgente = cdAgente.SelectedItem.Text;
            }
        }  
    }

    protected void cdAgente_SelectedIndexChanged(object sender, EventArgs e)
    {

        MontarCombos();

        p1.cdAgente = null;
        p1.nmAgente = null;
        if (cdAgente.SelectedIndex > 0)
        {
            p1.cdAgente = cdAgente.SelectedValue;
            p1.nmAgente = cdAgente.SelectedItem.Text;
        }

        MontarComboSafra();


        //if (cdAgente.SelectedValue != "0")
        //{
        //    cdClienteFaturamento.DataBind();
            
        //    cdClienteFaturamento.Items.Insert(0, new ListItem("", "0"));

        //    p1.cdAgente = cdAgente.SelectedValue;
        //    p1.nmAgente = cdAgente.SelectedItem.Text;
        //    cdClienteFaturamento.Enabled = true;
        //}
        //else
        //{
        //    LinkClienteFaturamento.Enabled = false;
        //    LinkClienteEntrega.Enabled = false;
        //    cdPessoaOrigemFaturamento.Items.Clear();
        //    cdClienteFaturamento.Items.Clear();
        //    cdClienteFaturamento.Enabled = false;
        //    cdClienteEntrega.Items.Clear();;
        //    cdClienteEntrega.Enabled = false;
        //    cdCronogramaSafraSEQ.SelectedIndex = -1;
        //    cdMoeda.SelectedIndex = -1;

        //    p1 = new PVPasso1();
        //}

        //ObterTiposProduto();2
        //CarregaOrigemFaturamento();
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

    protected void cdOrigemFaturamento_SelectedIndexChanged(object sender, EventArgs e)
    {
        cdMoeda.Items.Clear();
        cdMoeda.Enabled = false;

        p1.cdMoeda = null;
        p1.nmMoeda = null;

        if (cdPessoaOrigemFaturamento.SelectedIndex > 0)
        {
            cdMoeda.Enabled = true;

            CompromissoCompra compromissocompra = new CompromissoCompra();
            cdMoeda.DataSource = compromissocompra.ObterMoeda(Convert.ToInt32(cdAgente.SelectedValue), Convert.ToInt32(cdCronogramaSafraSEQ.SelectedValue), Convert.ToInt32(cdPessoaOrigemFaturamento.SelectedValue));
            cdMoeda.DataBind();
            cdMoeda.Items.Insert(0, new ListItem("", "0"));
            compromissocompra = null;
        }

        p1.cdOrigemFaturamento = null;
        p1.nmOrigemFaturamento = null;
        if (cdPessoaOrigemFaturamento.SelectedIndex > 0)
        {
            p1.cdOrigemFaturamento = cdPessoaOrigemFaturamento.SelectedValue;
            p1.nmOrigemFaturamento = cdPessoaOrigemFaturamento.SelectedItem.Text;
        }

        //p1.cdOrigemFaturamento = cdPessoaOrigemFaturamento.SelectedValue;
        //p1.nmOrigemFaturamento = cdPessoaOrigemFaturamento.SelectedItem.Text;
        //p1.cdMoeda = null;
        //p1.nmMoeda = null;

        //cdMoeda.DataBind();
        //if (cdMoeda.Items.FindByValue("0") == null)
        //    cdMoeda.Items.Insert(0, new ListItem("", "0"));

        //CarregaTipoPedido();
    }

    protected void cdClienteFaturamento_SelectedIndexChanged(object sender, EventArgs e)
    {
        MontarComboEntrega();

        p1.cdFaturamento = null;
        p1.nmFaturamento = null;
        if (cdClienteFaturamento.SelectedIndex > 0)
        {
            p1.cdFaturamento = cdClienteFaturamento.SelectedValue;
            p1.nmFaturamento = cdClienteFaturamento.SelectedItem.Text;
        }

        //    p1.cdFaturamento = cdClienteFaturamento.SelectedValue;
        //    p1.nmFaturamento = cdClienteFaturamento.SelectedItem.Text;

        //if (cdClienteFaturamento.SelectedValue != "0" & dropDownListTipoPedido.SelectedValue != "" & dropDownListTipoPedido.SelectedValue != "0")
        //{
        //    Pessoa pessoa = new Pessoa();

        //    if (dropDownListTipoPedido.SelectedValue == "1")
        //    {
        //        cdClienteEntrega.DataSource = pessoa.ObterListaPedidoClienteEntrega(Convert.ToInt64(cdClienteFaturamento.SelectedValue));
        //    }
        //    else
        //    {
        //        cdClienteEntrega.DataSource = pessoa.ObterListaPedidoClienteFaturamento(Convert.ToInt64(cdAgente.SelectedValue));
        //    }

        //    cdClienteEntrega.DataBind();
        //    cdClienteEntrega.Items.Insert(0, new ListItem("", "0"));

        //    pessoa = null;

        //    LinkClienteFaturamento.Enabled = true;
        //    LinkClienteEntrega.Enabled = true;
        //    cdClienteEntrega.Enabled = true;

        //    p1.cdFaturamento = cdClienteFaturamento.SelectedValue;
        //    p1.nmFaturamento = cdClienteFaturamento.SelectedItem.Text;

        //    if (cdClienteEntrega.SelectedValue != "0")
        //    {
        //        p1.cdEntrega = cdClienteEntrega.SelectedValue;
        //        p1.nmEntrega = cdClienteEntrega.SelectedItem.Text;
        //    }

        //}
        //else
        //{
        //    LinkClienteFaturamento.Enabled = false;
        //    LinkClienteEntrega.Enabled = false;
        //    cdClienteEntrega.Items.Clear(); ;
        //    cdClienteEntrega.Enabled = false;
            
        //    p1.cdFaturamento = null;
        //    p1.nmFaturamento = null;

        //    p1.cdEntrega = null;
        //    p1.nmEntrega = null;
        //}
    }

    protected void cdClienteEntrega_SelectedIndexChanged(object sender, EventArgs e)
    {
        p1.cdEntrega = null;
        p1.nmEntrega = null;
        if (cdClienteEntrega.SelectedIndex > 0)
        {
            p1.cdEntrega = cdClienteEntrega.SelectedValue;
            p1.nmEntrega = cdClienteEntrega.SelectedItem.Text;
        }

        //p1.cdEntrega = cdClienteEntrega.SelectedValue;
        //p1.nmEntrega = cdClienteEntrega.SelectedItem.Text;
    }

    protected void cdSafra_SelectedIndexChanged(object sender, EventArgs e)
    {

        MontarCombos();

        p1.cdSafra = null;
        p1.nmSafra = null;
        if (cdCronogramaSafraSEQ.SelectedIndex > 0)
        {
            p1.cdSafra = cdCronogramaSafraSEQ.SelectedValue;
            p1.nmSafra = cdCronogramaSafraSEQ.SelectedItem.Text;
        }

        //p1.cdSafra = cdCronogramaSafraSEQ.SelectedValue;
        //p1.nmSafra = cdCronogramaSafraSEQ.SelectedItem.Text;

        //cdMoeda.DataBind();
        
        //if(cdMoeda.Items.FindByValue("0") == null)
        //    cdMoeda.Items.Insert(0, new ListItem("", "0"));
        
        //if (cdMoeda.SelectedIndex >= 0)
        //{
        //    p1.cdMoeda = cdMoeda.SelectedValue;
        //    p1.nmMoeda = cdMoeda.SelectedItem.Text;
        //}
        //else
        //{
        //    p1.cdMoeda = null;
        //    p1.nmMoeda = null;
        //}

        //ObterTiposProduto();
        //CarregaOrigemFaturamento();



    }

    protected void cdMoeda_SelectedIndexChanged(object sender, EventArgs e)
    {

        p1.cdMoeda = null;
        p1.nmMoeda = null;
        if (cdMoeda.SelectedIndex > 0)
        {
            p1.cdMoeda = cdMoeda.SelectedValue;
            p1.nmMoeda = cdMoeda.SelectedItem.Text;
        }

        //if (cdMoeda.SelectedValue.ToString() != "")
        //{
        //    p1.cdMoeda = cdMoeda.SelectedValue;
        //    p1.nmMoeda = cdMoeda.SelectedItem.Text;
        //}
    }


    private void ObterTiposProduto()
    {
        //Retorna Tipo Produto
        CronogramaSafraPrincipioAtivo Obj = new CronogramaSafraPrincipioAtivo();

        switch (Obj.ObterTipoProduto(Convert.ToInt32(cdCronogramaSafraSEQ.SelectedValue), Convert.ToInt32(cdAgente.SelectedValue)))
        {
            case 1:
                dropDownListRegraProduto.DataSourceID = "ObjectDataSourcePrincipioAtivo";
                dropDownListRegraProduto.DataBind();
                break;

            case 2:
                dropDownListRegraProduto.DataSourceID = "ObjectDataSourceProdutoAcabado";
                dropDownListRegraProduto.DataBind();
                break;

            case 3:
                dropDownListRegraProduto.DataSourceID = "dataSourceTipoProduto";
                dropDownListRegraProduto.DataBind();
                break;

            default:
                dropDownListRegraProduto.Items.Clear();
                dropDownListRegraProduto.DataBind();
                break;
        }


        dropDownListRegraProduto.Items.Insert(0, new ListItem("", "0"));
        dropDownListRegraProduto.SelectedIndex = 0;

        p1.cdTipoProduto = dropDownListRegraProduto.SelectedValue; 
    }

    protected void dropDownListRegraProduto_SelectedIndexChanged(object sender, EventArgs e)
    {
        p1.cdTipoProduto = null;
        p1.nmTipoProduto = null;
        if (dropDownListRegraProduto.SelectedIndex > 0)
        {
            p1.cdTipoProduto = dropDownListRegraProduto.SelectedValue;
            p1.nmTipoProduto = dropDownListRegraProduto.SelectedItem.Text;
        }
        

    }

    private void CarregaOrigemFaturamento()
    {
        if (!Convert.ToInt32(cdAgente.SelectedValue).Equals(0)  && !Convert.ToInt32(cdCronogramaSafraSEQ.SelectedValue).Equals(0))
        {
            CronogramaSafraOrigemFaturamento Obj = new CronogramaSafraOrigemFaturamento();



            cdPessoaOrigemFaturamento.DataValueField = "cdOrigemFaturamentoSEQ";
            cdPessoaOrigemFaturamento.DataTextField = "dsFaturamento";
            cdPessoaOrigemFaturamento.DataSource = Obj.ObterLista(Convert.ToInt32(cdCronogramaSafraSEQ.SelectedValue), Convert.ToInt32(cdAgente.SelectedValue));
            cdPessoaOrigemFaturamento.DataBind();

            CarregaTipoPedido();
            cdPessoaOrigemFaturamento.Items.Insert(0, new ListItem("", "0"));
            cdPessoaOrigemFaturamento.SelectedIndex = 0;
            
        }
    }

    private void CarregaTipoPedido()
    {
        if (!string.IsNullOrEmpty(cdPessoaOrigemFaturamento.SelectedValue) && !Convert.ToInt32(cdPessoaOrigemFaturamento.SelectedValue).Equals(0))
        {





            //CronogramaSafraContaOrdem Obj = new CronogramaSafraContaOrdem();

            //if (Obj.Existe(Convert.ToInt32(cdCronogramaSafraSEQ.SelectedValue), Convert.ToInt32(cdAgente.SelectedValue)))
            //{
            //    dropDownListTipoPedido.DataSourceID = "objectDataSourceTipoPedido";
            //}
            //else
            //{
            //    dropDownListTipoPedido.DataSourceID = "objectDataSourceTipoPedidoVenda";
            //}

            MontarComboTipoPedido();

        }
        else
        {
            dropDownListTipoPedido.Items.Clear();
        }

        //cdClienteFaturamento.Items.Clear();
        cdClienteEntrega.Items.Clear();

    }


    private void MontarComboTipoPedido()
    {
        CodigoReferenciado codigoreferenciado = new CodigoReferenciado();
        CronogramaSafraContaOrdem cronogramasafracontaordem = new CronogramaSafraContaOrdem();
        CronogramaSafraCessaoCredito cronogramasafracessaocredito = new CronogramaSafraCessaoCredito();

        int contador = 0;



        dropDownListTipoPedido.DataSource = codigoreferenciado.ObterLista("DMESPINDICADORTIPOPEDIDO");
        dropDownListTipoPedido.DataBind();


        if (cronogramasafracontaordem.ExisteCarga(Convert.ToInt32(cdCronogramaSafraSEQ.SelectedValue), Convert.ToInt32(cdAgente.SelectedValue)) == false)
        {
            //Retiro o Conta e Ordem da Combo
            while (contador < dropDownListTipoPedido.Items.Count)
            {
                dropDownListTipoPedido.SelectedIndex = contador;

                if (Convert.ToInt32(dropDownListTipoPedido.SelectedValue) == 2)
                {
                    dropDownListTipoPedido.Items.RemoveAt(contador);
                    break;
                }
                contador = contador + 1;
            }


            
        }


        if (cronogramasafracessaocredito.ExisteCarga(Convert.ToInt32(cdCronogramaSafraSEQ.SelectedValue), Convert.ToInt32(cdAgente.SelectedValue), 3) == false)
        {
            //Retiro o Conta e Cessão Crédito Normal
            while (contador < dropDownListTipoPedido.Items.Count)
            {
                dropDownListTipoPedido.SelectedIndex = contador;

                if (Convert.ToInt32(dropDownListTipoPedido.SelectedValue) == 3)
                {
                    dropDownListTipoPedido.Items.RemoveAt(contador);
                    break;
                }
                contador = contador + 1;
            }
        }

        if (cronogramasafracessaocredito.ExisteCarga(Convert.ToInt32(cdCronogramaSafraSEQ.SelectedValue), Convert.ToInt32(cdAgente.SelectedValue), 4) == false)
        {
            //Retiro o Conta e Cessão Crédito Conta e Ordem
            while (contador < dropDownListTipoPedido.Items.Count)
            {
                dropDownListTipoPedido.SelectedIndex = contador;

                if (Convert.ToInt32(dropDownListTipoPedido.SelectedValue) == 4)
                {
                    dropDownListTipoPedido.Items.RemoveAt(contador);
                    break;
                }
                contador = contador + 1;
            }
        }


        dropDownListTipoPedido.Items.Insert(0, new ListItem("", "0"));
        dropDownListTipoPedido.SelectedIndex = 0;
    }

    protected void dropDownListTipoPedido_SelectedIndexChanged(object sender, EventArgs e)
    {

        MontarComboEntrega();

        p1.cdTipoPedido = null;
        p1.nmTipoPedido = null;
        if (dropDownListTipoPedido.SelectedIndex > 0)
        {
            p1.cdTipoPedido = dropDownListTipoPedido.SelectedValue;
            p1.nmTipoPedido = dropDownListTipoPedido.SelectedItem.Text;
        }

        //if (dropDownListTipoPedido.SelectedValue.ToString() != "")
        //{
        //    p1.cdTipoPedido = dropDownListTipoPedido.SelectedValue;
        //    p1.nmTipoPedido = dropDownListTipoPedido.SelectedItem.Text;


        //    cdClienteFaturamento.SelectedIndex = 0;
        //    cdClienteEntrega.Items.Clear();
        //    cdClienteEntrega.Enabled = false;
        //}
    }

    private void MontarCombos()
    {
        
        DesabilitarCliente();
        DesabilitaTodasCombos();

        if (cdAgente.SelectedIndex > 0 & cdCronogramaSafraSEQ.SelectedIndex > 0)
        {
            MontarComboClienteFaturamento();
            MontarTodasCombos();
        }
        else
        {
            if (cdAgente.SelectedIndex > 0)
            {
                MontarComboClienteFaturamento();
            }
        }
    }

    private void DesabilitarCliente()
    {
        LinkClienteFaturamento.Enabled = false;
        LinkClienteEntrega.Enabled = false;
        cdClienteFaturamento.Items.Clear();
        cdClienteFaturamento.Enabled = false;
        cdClienteEntrega.Items.Clear(); ;
        cdClienteEntrega.Enabled = false;

        p1.cdFaturamento = null;
        p1.nmFaturamento = null;

        p1.cdEntrega = null;
        p1.nmEntrega = null;

    }

    private void MontarComboClienteFaturamento()
    {
        cdClienteFaturamento.DataBind();

        cdClienteFaturamento.Items.Insert(0, new ListItem("", "0"));

        cdClienteFaturamento.Enabled = true;
        LinkClienteFaturamento.Enabled = true;
    }

    private void DesabilitaTodasCombos()
    {
        //Limpo todas as Combos
        dropDownListRegraProduto.Items.Clear();
        cdPessoaOrigemFaturamento.Items.Clear();
        dropDownListTipoPedido.Items.Clear();
        cdMoeda.Items.Clear();

        dropDownListRegraProduto.Enabled = false;
        cdPessoaOrigemFaturamento.Enabled = false;
        dropDownListTipoPedido.Enabled = false;
        cdMoeda.Enabled = false;

        p1.cdTipoProduto = null;
        p1.nmTipoProduto = null;

        p1.cdOrigemFaturamento = null;
        p1.nmOrigemFaturamento = null;

        p1.cdTipoPedido = null;
        p1.nmTipoPedido = null;

        p1.cdMoeda = null;
        p1.nmMoeda = null;
    }

    private void MontarTodasCombos()
    {
        //Monto todas as Combos
        dropDownListRegraProduto.Enabled = true;
        cdPessoaOrigemFaturamento.Enabled = true;
        dropDownListTipoPedido.Enabled = true;
        //cdMoeda.Enabled = true;


        CronogramaSafraPrincipioAtivo Obj = new CronogramaSafraPrincipioAtivo();

        switch (Obj.ObterTipoProduto(Convert.ToInt32(cdCronogramaSafraSEQ.SelectedValue), Convert.ToInt32(cdAgente.SelectedValue)))
        {
            case 1:
                dropDownListRegraProduto.DataSourceID = "ObjectDataSourcePrincipioAtivo";
                dropDownListRegraProduto.DataBind();
                break;

            case 2:
                dropDownListRegraProduto.DataSourceID = "ObjectDataSourceProdutoAcabado";
                dropDownListRegraProduto.DataBind();
                break;

            case 3:
                dropDownListRegraProduto.DataSourceID = "dataSourceTipoProduto";
                dropDownListRegraProduto.DataBind();
                break;

            default:
                dropDownListRegraProduto.Items.Clear();
                dropDownListRegraProduto.DataBind();
                break;
        }

        dropDownListRegraProduto.Items.Insert(0, new ListItem("", "0"));


        CronogramaSafraOrigemFaturamento cronogramasafraorigemfaturamento = new CronogramaSafraOrigemFaturamento();
        cdPessoaOrigemFaturamento.DataValueField = "cdOrigemFaturamentoSEQ";
        cdPessoaOrigemFaturamento.DataTextField = "dsFaturamento";
        cdPessoaOrigemFaturamento.DataSource = cronogramasafraorigemfaturamento.ObterLista(Convert.ToInt32(cdCronogramaSafraSEQ.SelectedValue), Convert.ToInt32(cdAgente.SelectedValue));
        cdPessoaOrigemFaturamento.DataBind();
        cdPessoaOrigemFaturamento.Items.Insert(0, new ListItem("", "0"));
        cronogramasafraorigemfaturamento = null;


        MontarComboTipoPedido();

        //CronogramaSafraContaOrdem Obj2 = new CronogramaSafraContaOrdem();

        //if (Obj2.Existe(Convert.ToInt32(cdCronogramaSafraSEQ.SelectedValue), Convert.ToInt32(cdAgente.SelectedValue)))
        //{
        //    dropDownListTipoPedido.DataSourceID = "objectDataSourceTipoPedido";
        //}
        //else
        //{
        //    dropDownListTipoPedido.DataSourceID = "objectDataSourceTipoPedidoVenda";
        //}

        //dropDownListTipoPedido.DataBind();

        //dropDownListTipoPedido.Items.Insert(0, new ListItem("", "0"));
        


    }


    private void MontarComboEntrega()
    {

        cdClienteEntrega.Items.Clear();
        cdClienteEntrega.Enabled = false;
        LinkClienteEntrega.Enabled = false;

        p1.cdEntrega = null;
        p1.nmEntrega = null;

        if (dropDownListTipoPedido.SelectedIndex > 0 & cdClienteFaturamento.SelectedIndex > 0)
        {
            cdClienteEntrega.Enabled = true;
            LinkClienteEntrega.Enabled = true;

            Pessoa pessoa = new Pessoa();

            if (dropDownListTipoPedido.SelectedValue == "1" | dropDownListTipoPedido.SelectedValue == "3")
            {
                cdClienteEntrega.DataSource = pessoa.ObterListaPedidoClienteEntrega(Convert.ToInt64(cdClienteFaturamento.SelectedValue));
            }
            else
            {
                cdClienteEntrega.DataSource = pessoa.ObterListaPedidoClienteFaturamento(Convert.ToInt64(cdAgente.SelectedValue));
            }

            cdClienteEntrega.DataBind();
            cdClienteEntrega.Items.Insert(0, new ListItem("", "0"));

            pessoa = null;

        }

    }
    protected void cdAgente_PreRender1(object sender, EventArgs e)
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
            MontarComboSafra();
        }
    }
}
