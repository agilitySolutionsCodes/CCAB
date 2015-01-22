using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_Cliente_Filtro : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Conv.Lib lib = new Conv.Lib();

        Usuario u = (Usuario)Session["Usuario"];
        Session["cdUsuario"] = u.cdUsuario;

        string _value;

        cdIndicadorPessoa.DataBind();
        cdIndicadorPessoa.Items.Insert(0, new ListItem("", "0"));
        _value = cdIndicadorPessoaValue.Value;
        cdIndicadorPessoa.SelectedValue = _value == "" ? "0" : _value;

        cdIndicadorStatusPessoa.DataBind();
        cdIndicadorStatusPessoa.Items.Insert(0, new ListItem("", "0"));
        _value = cdIndicadorStatusPessoaValue.Value;
        cdIndicadorStatusPessoa.SelectedValue = _value == "" ? "0" : _value;

        cdIndicadorSenhaBloqueadaPessoa.DataBind();
        cdIndicadorSenhaBloqueadaPessoa.Items.Insert(0, new ListItem("", "0"));
        _value = cdIndicadorSenhaBloqueadaPessoaValue.Value;
        cdIndicadorSenhaBloqueadaPessoa.SelectedValue = _value == "" ? "0" : _value;

        cdPessoaCooperativaSEQ.DataBind();
        cdPessoaCooperativaSEQ.Items.Insert(0, new ListItem("", "0"));
        _value = cdPessoaCooperativaSEQValue.Value;
        cdPessoaCooperativaSEQ.SelectedValue = _value == "" ? "0" : _value;

        cdPessoaRepresentanteSEQ.DataBind();
        cdPessoaRepresentanteSEQ.Items.Insert(0, new ListItem("", "0"));
        _value = cdPessoaRepresentanteSEQValue.Value;
        cdPessoaRepresentanteSEQ.SelectedValue = _value == "" ? "0" : _value;

        if (!IsPostBack)
        {
            lib.VerificarAcessoBotao("Cliente", btPesquisar);
            cdPessoaERP.Focus();
        }
        else
        {
            SaveFilter();
            RestoreFilter();
        }

    }

    protected void btPesquisar_OnClick(object sender, EventArgs e)
    {
        string _value;

        string _cnpj = Session["nuCNPJCPFPessoa"].ToString();

        _value = Session["cdPessoaCooperativaSEQValue"].ToString();
        int _cooperativa = _value == "" ? 0 : Convert.ToInt16(_value);

        _value = Session["cdPessoaRepresentanteSEQValue"].ToString();
        int _representante = _value == "" ? 0 : Convert.ToInt16(_value);

        _value = Session["cdIndicadorPessoaValue"].ToString();
        int _tipoPessoa = _value == "" ? 0 : Convert.ToInt16(_value);

        _value = Session["cdIndicadorStatusPessoaValue"].ToString();
        int _status = _value == "" ? 0 : Convert.ToInt16(_value);

        _value = Session["cdIndicadorSenhaBloqueadaPessoaValue"].ToString();
        int _locked = _value == "" ? 0 : Convert.ToInt16(_value);

        GridView gv = (GridView)Parent.FindControl("Resultado1").FindControl("GridView1");
        Pessoa obj = new Pessoa();

        gv.DataSource = obj.ObterListaCliente(Session["cdPessoaERP"].ToString(),
                                      Session["dsLoginPessoa"].ToString(),
                                      _cnpj,
                                      Session["nmFoneticoPessoa"].ToString(),
                                      _status,
                                      _locked,
                                      _cooperativa,
                                      _representante, 
                                      _tipoPessoa).AsDataView();        
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
}
