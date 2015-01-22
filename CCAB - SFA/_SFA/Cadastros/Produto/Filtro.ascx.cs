using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_Produto_Filtro : System.Web.UI.UserControl
{
    internal Conv.Lib lib = new Conv.Lib();

    protected void Page_Load(object sender, EventArgs e)
    {
        cdIndicadorLiberadoPedidoProduto.DataBind();
        cdIndicadorLiberadoPedidoProduto.Items.Insert(0, new ListItem("", "0"));

        string _value = cdIndicadorLiberadoPedidoProdutoValue.Value;
        cdIndicadorLiberadoPedidoProduto.SelectedValue = _value == "" ? "0" : _value;

        if (!IsPostBack)
        {
            lib.VerificarAcessoBotao("Produto", btPesquisar);
            cdProdutoERP.Focus();

            dropDownListFornecedor.DataBind();
            dropDownListFornecedor.Items.Insert(0, new ListItem("", "0"));

            dropDownListTipoProduto.DataBind();
            dropDownListTipoProduto.Items.Insert(0, new ListItem("", "0"));
        }
        else
        {
            SaveFilter();
        }

        RestoreFilter();
    }

    protected void btPesquisar_OnClick(object sender, EventArgs e)
    {
        string _value = Session["cdIndicadorLiberadoPedidoProdutoValue"].ToString();
        int _liberado = _value == "" ? 0 : Convert.ToInt32(_value);

        GridView gv = (GridView)Parent.FindControl("Resultado1").FindControl("GridView1");
        Produto pd = new Produto();

        gv.DataSource = pd.ObterLista(Session["cdProdutoERP"].ToString(), Session["dsProduto"].ToString(), _liberado, Convert.ToInt32(Session["dropDownListTipoProduto"]), 0).AsDataView();        
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

            if (c is DropDownList)
            {
                DropDownList ctrl = (DropDownList)c;
                _key = ctrl.ID;
                _value = ctrl.SelectedValue;
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
}
