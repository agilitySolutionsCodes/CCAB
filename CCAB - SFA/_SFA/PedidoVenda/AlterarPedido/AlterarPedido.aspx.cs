using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Conv;

public partial class _SFA_PedidoVenda_AlterarPedido : System.Web.UI.Page
{
    internal string _nometela = "Alterar Pedido de Venda";
    public string numPedido = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Usuario"] == null)
            Response.Redirect("~/Default.aspx", true);

        lbNomeTela.Text = _nometela;

        numPedido = Session["cdPedidoVenda"].ToString();

        btImprimir.Attributes.Remove("onclick");
        btImprimir.Attributes.Add("onclick", string.Format("javascript: ExibirRelatorioPedidoVenda({0}); return false;", (numPedido=="")? "0": numPedido));

    }

    # region Passo 1

    protected void btPasso1Avancar_OnClick(object sender, EventArgs e)
    {

        string msg = SalvaPasso1();

        if (msg != "")
        {
            CustomValidator1.IsValid = false;
            CustomValidator1.ErrorMessage = msg;
        }
        else
            MultiView1.ActiveViewIndex = 1;

    }


    protected string SalvaPasso1()
    {

        PedidoVenda obj = new PedidoVenda();
        PVPasso1 p1 = (PVPasso1)Session["PVPasso1"];

        return obj.ConsistirEntrega(Convert.ToInt32(p1.cdTipoPedido),
                             Convert.ToInt64(p1.cdFaturamento),
                             Convert.ToInt64(p1.cdEntrega));

    }

    
    #endregion

    # region Passo 2

    protected void btPasso2Avancar_OnClick(object sender, EventArgs e)
    {
        string msg = SalvaPasso2();

        if (msg != "")
        {
            CustomValidator1.IsValid = false;
            CustomValidator1.ErrorMessage = msg;
        }
        else 
            MultiView1.ActiveViewIndex = 2;
    }

    protected void btPasso2Retornar_OnClick(object sender, EventArgs e)
    {
        string msg = SalvaPasso2();

        if (msg != "")
        {
            CustomValidator1.IsValid = false;
            CustomValidator1.ErrorMessage = msg;
        }
        else 
            MultiView1.ActiveViewIndex = 0;
    }

    protected string SalvaPasso2()
    {
        PedidoVenda obj = new PedidoVenda();
        PVPasso1 p1 = (PVPasso1)Session["PVPasso1"];
        FarPoint.Web.Spread.FpSpread FpSpread1 = (FarPoint.Web.Spread.FpSpread)Passo2.FindControl("FpSpread1");

        return obj.SalvarTmp(GetValuesFromSpread(FpSpread1),
                             Convert.ToInt64(Session["cdUsuario"]),
                             Convert.ToInt64(p1.cdAgente),
                             Convert.ToInt64(p1.cdSafra),
                             Convert.ToInt64(p1.cdMoeda),
                             Convert.ToInt64(p1.cdOrigemFaturamento));
    }

    #endregion

    # region Passo 3

    protected void btPasso3Avancar_OnClick(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 3;
    }

    protected void btPasso3Retornar_OnClick(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
    }

    #endregion

    # region Passo 4
    
    protected void btPasso4Avancar_OnClick(object sender, EventArgs e)
    {
        string msg = SalvaPasso4();

        if (msg != "")
        {
            CustomValidator1.IsValid = false;
            CustomValidator1.ErrorMessage = msg;
        }
        else 
            MultiView1.ActiveViewIndex = 4;
    }

    protected string SalvaPasso4()
    {
        PedidoVenda obj = new PedidoVenda();
        PVPasso1 p1 = (PVPasso1)Session["PVPasso1"];
        FarPoint.Web.Spread.FpSpread FpSpread1 = (FarPoint.Web.Spread.FpSpread)Passo4.FindControl("FpSpread1");

        return obj.SalvarEntregaTmp(GetValuesFromSpread(FpSpread1),
                                    Convert.ToInt64(Session["cdUsuario"]),
                                    Convert.ToInt64(p1.cdAgente),
                                    Convert.ToInt64(p1.cdSafra));
    }

    protected void btPasso4Retornar_OnClick(object sender, EventArgs e)
    {
        string msg = SalvaPasso4();

        if (msg != "")
        {
            CustomValidator1.IsValid = false;
            CustomValidator1.ErrorMessage = msg;
        }
        else 
            MultiView1.ActiveViewIndex = 2;
    }

    #endregion

    # region Passo 5

    protected void btPasso5Salvar_OnClick(object sender, EventArgs e)
    {
        string msg = SalvaPasso5();

        if (msg != "")
        {
            CustomValidator1.IsValid = false;
            CustomValidator1.ErrorMessage = msg;
            return;
        }

        msg = finalizaPedido();
        if (msg != "")
        {
            CustomValidator1.IsValid = false;
            CustomValidator1.ErrorMessage = msg;
            return;
        }

        MultiView1.ActiveViewIndex = 5;
    }

    protected string SalvaPasso5()
    {
        PedidoVenda obj = new PedidoVenda();
        PVPasso1 p1 = (PVPasso1)Session["PVPasso1"];
        FarPoint.Web.Spread.FpSpread FpSpread1 = (FarPoint.Web.Spread.FpSpread)Passo5.FindControl("FpSpread1");

        return obj.SalvarCulturaTmp(GetValuesFromSpread(FpSpread1),
                                    Convert.ToInt64(Session["cdUsuario"]),
                                    Convert.ToInt64(p1.cdAgente),
                                    Convert.ToInt64(p1.cdSafra));
    }

    protected string finalizaPedido()
    {
        PedidoVenda obj = new PedidoVenda();
        PVPasso1 p1 = (PVPasso1)Session["PVPasso1"];
        string msg = "";

        //Salvo o Cliente de Entrega
        msg = obj.SalvarTmp(Convert.ToInt64(Session["cdPedidoVenda"]),
                                   Convert.ToInt64(p1.cdEntrega));

        if (msg != "") return msg;


        //Salvo o Pedido
        msg = obj.SalvaPedidoAlteracao(Convert.ToInt64(Session["cdUsuario"]),
                                              Convert.ToInt64(Session["cdPedidoVenda"]),
                                              Convert.ToInt64(Session["cdPedidoVendaGrid"]));

        if (msg != "") return msg;

        numPedido = Session["cdPedidoVendaGrid"].ToString();

        btImprimir.Attributes.Remove("onclick");
        btImprimir.Attributes.Add("onclick", string.Format("javascript: ExibirRelatorioPedidoVenda({0}); return false;", numPedido));

        //Session["cdPedidoVenda"] = null;

        //Session["cdPedidoVenda"] = null;
        //Session["cdPedidoVendaGrid"] = null;

        return msg;
    }

    protected void btPasso5Retornar_OnClick(object sender, EventArgs e)
    {
        string msg = SalvaPasso5();

        if (msg != "")
        {
            CustomValidator1.IsValid = false;
            CustomValidator1.ErrorMessage = msg;
        }
        else 
            MultiView1.ActiveViewIndex = 3;
    }

    #endregion

    # region Passo 6

    protected void btAlterarPedido_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("~/_SFA/PedidoVenda/AlterarPedido/SelecionarPedido.aspx", true);
    }

    protected void btImprimir_OnClick(object sender, EventArgs e)
    {
        
    }

    #endregion

    # region Métodos comuns a todos os passos

    // Este método é executado pelos botões de cancelamento de todos os Passos
    protected void btCancelar_OnClick(object sender, EventArgs e)
    {
        PedidoVenda obj = new PedidoVenda();

        string msg = obj.ExcluirTmp(Convert.ToInt64(Session["cdPedidoVenda"]));

        if (msg == "")
            Response.Redirect("~/_SFA/PedidoVenda/AlterarPedido/SelecionarPedido.aspx", true);
        else
        {
            CustomValidator1.IsValid = false;
            CustomValidator1.ErrorMessage = msg;
        }  
    }

    protected ListItemCollection GetValuesFromSpread(FarPoint.Web.Spread.FpSpread FpSpread1)
    {
        FpSpread1.SaveChanges();

        ListItemCollection lic = new ListItemCollection();
        ListItem l;

        for (int lin = 1; lin < FpSpread1.Rows.Count; lin++)
        {
            string _key = "", _value = "";
            for (int col = 4; col < FpSpread1.Columns.Count; col++)
            {
                if (col % 2 == 0) // Coluna Par (KEY)
                {
                    _key = FpSpread1.Cells[lin, col].Value == null ? "" : FpSpread1.Cells[lin, col].Value.ToString();
                    if (_key == String.Empty)
                        _key = FpSpread1.Cells[lin, col].Value == null ? "" : FpSpread1.Cells[lin, col].Value.ToString();

                    // Atribui "" à chave inválida para que o par venha a ser desprezado 
                    if (!_key.Contains("-")) _key = String.Empty;
                }
                else // Coluna Impar (VALUE)
                {
                    _value = FpSpread1.Cells[lin, col].Value == null ? "" : FpSpread1.Cells[lin, col].Value.ToString();
                    if (_value == String.Empty)
                        _value = FpSpread1.Cells[lin, col].Value == null ? "" : FpSpread1.Cells[lin, col].Value.ToString();

                    if (_key != String.Empty && _value != String.Empty)
                    {
                        l = new ListItem(_key, _value);
                        lic.Add(l);
                    }
                    _key = "";
                    _value = "";
                }
            }
        }

        return lic;
    } 

    #endregion
}
