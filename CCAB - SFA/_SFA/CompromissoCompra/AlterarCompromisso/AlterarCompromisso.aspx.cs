using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Conv;

public partial class _SFA_CompromissoCompra_AlterarCompromisso : System.Web.UI.Page
{
    internal string _nometela = "Alterar Compromisso de Compra";
    public string numCompromisso = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["cdCompromissoCompra"] == null) return;

        if (Session["Usuario"] == null)
            Response.Redirect("~/Default.aspx", true);

        lbNomeTela.Text = _nometela;

        numCompromisso = Session["cdCompromissoCompra"].ToString();
    }

    # region Passo 1

    protected void btPasso1Avancar_OnClick(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;   
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
        CompromissoCompra obj = new CompromissoCompra();
        PVPasso1 p1 = (PVPasso1)Session["PVPasso1"];
        FarPoint.Web.Spread.FpSpread FpSpread1 = (FarPoint.Web.Spread.FpSpread)Passo2.FindControl("FpSpread1");

        return obj.SalvarTmp(GetValuesFromSpread(FpSpread1),
                             Convert.ToInt64(Session["cdUsuario"]),
                             Convert.ToInt64(p1.cdAgente),
                             Convert.ToInt64(p1.cdSafra));
    }

    #endregion

    # region Passo 3

    protected void btPasso3Salvar_OnClick(object sender, EventArgs e)
    {
        string msg = finalizaCompromisso();
        
        if (msg != "")
        {
            CustomValidator1.IsValid = false;
            CustomValidator1.ErrorMessage = msg;
            return;
        }
        
        MultiView1.ActiveViewIndex = 3;
    }

    protected void btPasso3Retornar_OnClick(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
    }

    protected string finalizaCompromisso()
    {
        CompromissoCompra obj = new CompromissoCompra();
        string msg = obj.SalvaCompromissoAlteracao(Convert.ToInt64(Session["cdUsuario"]),
                                                   Convert.ToInt64(Session["cdCompromissoCompra"]),
                                                   Convert.ToInt64(Session["cdCompromissoCompraGrid"]));

        if (msg != "") return msg;

        numCompromisso = Session["cdCompromissoCompraGrid"].ToString();

        btImprimir.Attributes.Remove("onclick");
        btImprimir.Attributes.Add("onclick", string.Format("javascript: ExibirRelatorioCompromissoCompra({0}); return false;", numCompromisso));

        Session["cdCompromissoCompra"] = null;

        return msg;
    }

    #endregion

    # region Passo 4

    protected void btAlterarCompromisso_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("~/_SFA/CompromissoCompra/AlterarCompromisso/SelecionarCompromisso.aspx", true);
    }

    #endregion

    # region Métodos comuns a todos os passos

    // Este método é executado pelos botões de cancelamento de todos os Passos
    protected void btCancelar_OnClick(object sender, EventArgs e)
    {
        CompromissoCompra obj = new CompromissoCompra();

        string msg = obj.ExcluirTmp(Convert.ToInt64(Session["cdCompromissoCompra"]));

        if (msg == "")
            Response.Redirect("~/_SFA/CompromissoCompra/AlterarCompromisso/SelecionarCompromisso.aspx", true);
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
