using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Hélcio 11/02/2009 - consistir se objeto usuário ainda existe
        if (Session["Usuario"] == null)
            Response.Redirect("~/Default.aspx", true);

        Usuario loUsuario = new Usuario();
        loUsuario = (Usuario)Session["Usuario"];

        ////Grid Atualização Cadastral
        //Alerta loAlterta = new Alerta();
        //DataTable loDataTable;
        //loDataTable = loAlterta.ObterLista_AtualizacaoCadastro(loUsuario.cdUsuario);
        //grdAtualizacaoCadastral.DataSource = loDataTable;
        //grdAtualizacaoCadastral.DataBind();


        ////Grid Meus Anúncios
        //Anuncio loAnuncio = new Anuncio();
        //loDataTable = loAnuncio.ObterLista(loUsuario.cdUsuario, 0, "", 4);
        ////grdMeusAnuncios.DataSource = loDataTable;
        ////grdMeusAnuncios.DataBind();


    }


    protected void GridView_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("~/_SFA/MinhaCentral/AtualizarCadastro/AtualizarCadastro.aspx");
    }

    protected void btCadastro_OnClick(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/_SFA/MinhaCentral/AtualizarCadastro/AtualizarCadastro.aspx");
    }
    protected void btAnuncio_OnClick(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/_SFA/MinhaCentral/MeusAnuncios/MeusAnuncios.aspx");
    }
    protected void grdMeusAnuncios_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void grdMeusAnuncios_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Usuario loUsuario = new Usuario();
        loUsuario = (Usuario)Session["Usuario"];

        //Grid Meus Anúncios
        //Anuncio loAnuncio = new Anuncio();
        //DataTable loDataTable;
        //loDataTable = loAnuncio.ObterLista(loUsuario.cdUsuario, 0, "", 4);
        //grdMeusAnuncios.PageIndex = e.NewPageIndex;
        //grdMeusAnuncios.DataSource = loDataTable;
        //grdMeusAnuncios.DataBind();


    }

}
