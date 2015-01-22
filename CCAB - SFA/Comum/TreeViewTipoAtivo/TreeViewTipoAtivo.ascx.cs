using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;

public partial class _Comum_TreeViewTipoAtivo : System.Web.UI.UserControl
{
    #region Propriedades

    public int Width { get; set; }
    public int Height { get; set; }
    public string AssociatedHiddenFieldValue { get; set; }
    public string AssociatedHiddenFieldText { get; set; }
    public bool ShowResetButton { get; set; }

    #endregion Propriedades

    protected void Page_Load(object sender, EventArgs e)
    {
        TreeView_Load((TreeView)this.FindControl("TreeView1"));

        if (this.Height == 0) this.Height = 100;
        if (this.Width == 0) this.Width = 100;

        DivContainer.Style.Add("height", this.Height.ToString() + "px");
        Panel1.Width = Unit.Pixel(this.Width);
        Panel1.Height = Unit.Pixel(this.Height - 10);
        
        if(ShowResetButton)
        {
            btLimparTipoAtivo.Visible = true;

            HiddenField h1 = (HiddenField)Parent.FindControl(AssociatedHiddenFieldValue);
            
            string _HiddenTextID = "";
            if (AssociatedHiddenFieldText != null)
            {
                HiddenField h2 = (HiddenField)Parent.FindControl(AssociatedHiddenFieldText);
                if (h2 != null) _HiddenTextID = h2.ClientID;
            }

            string js = "LimparTipoAtivo('theForm." + h1.ClientID + "', 'theForm." + dsTipoAtivo.ClientID + "', 'theForm." + _HiddenTextID + "')";
            btLimparTipoAtivo.Attributes.Add("onClick", js);
        }
    }    

    # region Tratamento TreeView

    protected void TreeView_TreeNodeDataBound(object sender, TreeNodeEventArgs e)
    {
        //if (e.Node.Depth == 2) // Último nível
        //{
            HiddenField h1 = (HiddenField)Parent.FindControl(AssociatedHiddenFieldValue);
            string _HiddenTextID = "";
            if (AssociatedHiddenFieldText != null)
            {
                HiddenField h2 = (HiddenField)Parent.FindControl(AssociatedHiddenFieldText);
                if (h2 != null) _HiddenTextID = h2.ClientID;
            }

            e.Node.SelectAction = TreeNodeSelectAction.Select;
            e.Node.NavigateUrl = "javascript: NodeClick('theForm." + h1.ClientID + "', 'theForm." + dsTipoAtivo.ClientID + "', 'theForm." + _HiddenTextID + "', '" + e.Node.Value + "', '" + e.Node.Text + "')";
        //}
        //else
        //    e.Node.SelectAction = TreeNodeSelectAction.Expand;
    }

    /*
    // Call the procedure using the TreeView.
    private void ConfigNodes(TreeView tv)
    {
        TreeNodeCollection nodes = tv.Nodes;
        foreach (TreeNode n in nodes)
        {
            PrintRecursive(n);
        }
    }

    private void PrintRecursive(TreeNode treeNode)
    {
        // Print the node.
        //System.Diagnostics.Debug.WriteLine(treeNode.Text);
        //MessageBox.Show(treeNode.Text);
        // Print each node recursively.
        foreach (TreeNode tn in treeNode.Nodes)
        {
            PrintRecursive(tn);
        }
    }
    */

    public void TreeView_CollapseExpand(object sender, EventArgs e)
    {
        TreeView tv = (TreeView)sender;

        TreeView_SetNodeHasChildren(tv);

        tv.CollapseAll();

        TreeNode node = tv.SelectedNode;
        if (node != null)
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

    public void TreeView_SetNodeHasChildren(TreeView tv)
    {   
        foreach (TreeNode node in tv.Nodes)
        {
            if (node.ChildNodes.Count != 0)
            {
                node.SelectAction = TreeNodeSelectAction.Expand;
                node.NavigateUrl = "";
                foreach (TreeNode node1 in node.ChildNodes)
                {
                    if (node1.ChildNodes.Count > 0)
                    {
                        node1.SelectAction = TreeNodeSelectAction.Expand;
                        node1.NavigateUrl = "";
                    }
                }
            }
        }
        
    }

    public void TreeView_Load(TreeView tv)
    {
        //TipoAtivo ta = new TipoAtivo();
        
        //DataSet ds = new DataSet();
        //ds.Tables.Add(ta.ObterTreeView());

        //tv.DataSource = new HierarchicalDataSet(ds, "cdTipoAtivoSEQ", "cdTipoAtivoSuperior");
        //tv.DataBind();
    }
    #endregion
}
