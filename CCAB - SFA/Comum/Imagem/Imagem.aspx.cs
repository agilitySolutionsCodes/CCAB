using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Comum_Imagem : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        /*
        AnuncioAnexo aa = new AnuncioAnexo();
        long cd;

        //Response.ContentType = "image/jpeg";

        cd = Convert.ToInt64(Request.QueryString["cd"]);
        if (aa.Obter(cd).Rows.Count > 0)
            Response.BinaryWrite((Byte[])aa.Obter(cd).Rows[0]["wkAnuncioAnexo"]);        
        
        Response.End();
        */
    }
}
