using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Conv;

public partial class _SFA_PedidoVenda_NovoPedido : System.Web.UI.Page
{
    internal string _nometela = "Novo Pedido de Venda";
    public string numPedido = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        lbNomeTela.Text = _nometela;

        if (Session["Usuario"] == null)
            Response.Redirect("~/Default.aspx", true);
    }

    # region Passo 1

    protected void btPasso1Avancar_OnClick(object sender, EventArgs e)
    {
        PedidoVenda obj = new PedidoVenda();
        PVPasso1 p1, p2;

        p1 = (PVPasso1)Session["PVPasso1"];
        string msg = ValuesOK(p1);

        if (msg == "")
        {
            if (Session["PVPasso1OLD"] != null)
            {
                p2 = (PVPasso1)Session["PVPasso1OLD"];
                if (!p1.Equals(p2))
                {
                    msg = obj.ExcluirTmp(Convert.ToInt64(Session["cdPedidoVenda"]));

                    if (msg == "")
                    {
                        Session["PVPasso1"] = null;
                        Session["PVPasso1OLD"] = null;
                        TextBox t = (TextBox)Passo2.FindControl("valorTotal");
                        t.Text = "0,0000";
                        msg = IncluirPedidoVenda(obj, p1);
                        Session["PVPasso1"] = p1;
                    }
                }
            }
            else
                msg = IncluirPedidoVenda(obj, p1);      
        }

        if (msg == "")
            MultiView1.ActiveViewIndex = 1;
        else
        {
            CustomValidator1.IsValid = false;
            CustomValidator1.ErrorMessage = msg;
        }   
    }

    protected string IncluirPedidoVenda(PedidoVenda obj, PVPasso1 p1)
    {
        string msg = "";
        msg = obj.IncluirTmp_Inclusao(Convert.ToInt64(p1.cdAgente),
                                      Convert.ToInt64(p1.cdSafra),
                                      Convert.ToInt64(p1.cdFaturamento),
                                      Convert.ToInt64(p1.cdEntrega),
                                      Convert.ToInt64(p1.cdMoeda),
                                      Convert.ToInt64(Session["cdUsuario"]),
                                      Convert.ToInt64(p1.cdOrigemFaturamento),
                                      Convert.ToInt32(p1.cdTipoPedido),
                                      Convert.ToInt32(p1.cdTipoProduto));
        if (msg == "")
            Session["cdPedidoVenda"] = obj.tmpPedidoVendaSEQ;

        return msg;
    }

    protected string ValuesOK(PVPasso1 p1)
    {
        if (p1.cdAgente == null | p1.nmAgente == null |
            p1.cdSafra == null | p1.nmSafra == null |
            p1.cdTipoProduto == null | p1.nmTipoProduto == null |
            p1.cdOrigemFaturamento == null | p1.nmOrigemFaturamento == null |
            p1.cdTipoPedido == null | p1.nmTipoPedido == null |
            p1.cdFaturamento == null | p1.nmFaturamento == null |
            p1.cdEntrega == null | p1.nmEntrega == null |
            p1.cdMoeda == null | p1.nmMoeda == null) 
            return("Todos os campos são obrigatórios");

        return "";
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
        Session["PVPasso1OLD"] = Session["PVPasso1"];

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
        string msg = obj.SalvaPedidoInclusao(Convert.ToInt64(Session["cdPedidoVenda"]),
                                             Convert.ToInt64(Session["cdUsuario"]));

        if (msg != "") return msg;

        numPedido = obj.cdPedidoVendaSEQ.ToString();
        
        btImprimir.Attributes.Remove("onclick");
        btImprimir.Attributes.Add("onclick", string.Format("javascript: ExibirRelatorioPedidoVenda({0}); return false;", numPedido));

        Session["cdPedidoVenda"] = null;

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

    protected void btNovoPedido_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("~/_SFA/PedidoVenda/NovoPedido/NovoPedido.aspx", true);
    }

    #endregion

    # region Métodos comuns a todos os passos

    // Este método é executado pelos botões de cancelamento de todos os Passos
    protected void btCancelar_OnClick(object sender, EventArgs e)
    {
        PedidoVenda obj = new PedidoVenda();

        string msg = obj.ExcluirTmp(Convert.ToInt64(Session["cdPedidoVenda"]));

        if (msg == "")
            Response.Redirect("~/_SFA/PedidoVenda/NovoPedido/NovoPedido.aspx", true);
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
