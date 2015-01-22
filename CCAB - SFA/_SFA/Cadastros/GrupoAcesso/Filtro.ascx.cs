using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _SFA_GrupoAcesso_Filtro : System.Web.UI.UserControl
{
    internal Conv.Lib lib = new Conv.Lib();

    protected void Page_Load(object sender, EventArgs e)
    {
        cdIndicadorStatusGrupoAcesso.DataBind();
        cdIndicadorStatusGrupoAcesso.Items.Insert(0, new ListItem("", "0"));
        string _value = cdIndicadorStatusGrupoAcessoValue.Value;
        cdIndicadorStatusGrupoAcesso.SelectedValue = _value == "" ? "0" : _value;

        if (!IsPostBack)
        {
            lib.VerificarAcessoBotao("GrupoAcesso", btPesquisar);
            dsGrupoAcesso.Focus();
        }
        else
        {
            SaveFilter();
            RestoreFilter();
        }       
    }

    protected void btPesquisar_OnClick(object sender, EventArgs e)
    {
        string _value = Session["cdIndicadorStatusGrupoAcessoValue"].ToString();
        long _status = _value == "" ? 0 : Convert.ToInt64(_value);

        GridView gv = (GridView)Parent.FindControl("Resultado1").FindControl("GridView1");
        GrupoAcesso obj = new GrupoAcesso();

        gv.DataSource = obj.ObterLista(Session["dsGrupoAcesso"].ToString(), _status).AsDataView();
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
