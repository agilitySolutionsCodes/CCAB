using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        checkSession();

        Usuario u = (Usuario)Session["Usuario"];
        lbUsuario.Text = u.dsLoginPessoa + " - " + u.dsPerfilUsuario;

        // Codificação de Versão: Produção.Homologação.Qualidade.Desenvolvimento
        lbVersao.Text = "Versão 02.01.01.27";

        TreeView_Load((TreeView)this.FindControl("TreeView1"));

        Page.Title = ConfigurationManager.AppSettings["AppTitle"];

        //this.keepAlive();
    }
    
    protected void LogOut()
    {
        Session["Usuario"] = null;
        Session.Abandon();
    }

    internal void checkSession()
    {
        if (Session["Usuario"] == null)
            Response.Redirect("~/Default.aspx", true);
    }

    # region Tratamento TreeView Menu

    protected void TreeView_TreeNodeDataBound(object sender, TreeNodeEventArgs e)
    {
        if (e.Node.ValuePath == "1")
        {
            e.Node.Value = "0";
            e.Node.Text = "";
        }

        if (e.Node.NavigateUrl == "")
            e.Node.SelectAction = TreeNodeSelectAction.None;
        else
        {
            e.Node.SelectAction = TreeNodeSelectAction.Select;
            if (Request.Url.PathAndQuery.Contains(e.Node.NavigateUrl.Replace("~", "")))
                e.Node.Selected = true;
        }
    }

    public void TreeView_CollapseExpand(Object sender, EventArgs e)
    {
        TreeView tv = (TreeView)sender;
        tv.CollapseAll();
        
        TreeNode node = tv.SelectedNode;
        if(node != null)
            switch (node.Depth)
            {
                case 1:
                    {
                        if (tv.SelectedNode.Parent != null)
                            tv.SelectedNode.Parent.Expand();
                        break;
                    }
                case 2:
                    {
                        if (tv.SelectedNode.Parent.Parent != null)
                        {
                            tv.SelectedNode.Parent.Parent.Expand();
                            tv.SelectedNode.Parent.Expand();
                        }
                        break;
                    }
            }
    }

    public void TreeView_Load(TreeView tv)
    {   
        ItemMenu im = new ItemMenu();
        Usuario u = (Usuario)Session["Usuario"];
        DataSet ds = new DataSet();
        ds.Tables.Add(im.ObterLista(u.cdUsuario));

        tv.DataSource = new HierarchicalDataSet(ds, "cdItemMenuSEQ", "cdItemMenuSuperior");
        tv.DataBind();
    }

    #endregion

    protected void btnEncerrar_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("~/Default.aspx");

    }

    /*
    private void keepAlive()
    {
        int int_MilliSecondsTimeOut = 10000; // (this.Session.Timeout * 60000) - 300000; // 15 minutos
        string str_Script = @"
                            <script type='text/javascript'>
                            var count=0;
                            var max = 5; // Número de reconexões...
                            function Reconnect(){
                                count++;
                                if (count < max)
                                {
                                    var img = new Image(1,1);
                                    img.src = 'Reconnect.aspx';
                                }
                            }
                            window.setInterval('Reconnect()'," + 
                                int_MilliSecondsTimeOut.ToString()+ @");
                            </script>";

        this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Reconnect", str_Script);
    }
    */
}
