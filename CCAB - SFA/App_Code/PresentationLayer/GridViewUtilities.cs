using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GridViewUtilities
{
    [DefaultProperty("Text")]
    [ToolboxData("<{0}:GridViewRowSelector runat=\"server\"></{0}:GridViewRowSelector>")]
    public class GridViewRowSelector : RadioButton
    {
        protected override void Render(HtmlTextWriter writer)
        {
            HttpContext ctx = HttpContext.Current;
            string _prefix = ctx.Request.Path;
            _prefix = _prefix.Substring(_prefix.LastIndexOf("/"), _prefix.Length - _prefix.LastIndexOf("/"));
            _prefix = _prefix.Substring(_prefix.LastIndexOf("/") + 1, _prefix.LastIndexOf(".") - 1);

            GridViewRow row = (GridViewRow)this.NamingContainer;
            int currentIndex = row.RowIndex;
            int currentSelectedIndex = Convert.ToInt16(ctx.Session[_prefix + "GridViewIndex"]);
            GridView grid = (GridView)row.NamingContainer;
            this.Checked = (grid.SelectedIndex == currentIndex);
            this.Attributes.Add("onClick", "javascript:" + Page.ClientScript.GetPostBackEventReference(grid, "Select$" + currentIndex.ToString(), true));
            base.Render(writer);
        }

    }
}
