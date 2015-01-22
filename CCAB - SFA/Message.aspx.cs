using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Message : System.Web.UI.Page
{
    public string MessageType;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            switch (Request.QueryString["tp"])
            {
                case "err": // Erro
                {
                    Image1.ImageUrl = "~/imgsCCAB/error.png";
                    string _url = (Request["errorUrl"] == null || Request["errorUrl"] == "") ? Request.Url.ToString() : Request["errorUrl"];

                    if (_url.Contains("?"))
                        _url = _url.Remove(Request.Url.ToString().IndexOf("?"));

                    string _msg = Request.QueryString["msg"];
                    string _msgHTML = _msg.Replace("\n", "<br>");

                    MessageType = "Erro";
                    lblSource.Text = "<b>Descri��o</b>:<br><br>" +
                                     "Ocorreu uma exce��o na tentativa de execu��o do recurso " + _url; 
                    lblMessage.Text = "<b>Mensagem</b>:<br><br><font color='red'>" + _msgHTML + "</font>";

                    errMsg.Value = "Origem: " + Request.Url.ToString() + "\n\nDescri��o: " + _msg;
                    break;
                }
                case "info": // Feedback / Informa��o
                {
                    Image1.ImageUrl = "~/imgsCCAB/info.png";
                    MessageType = "Informa��o";
                    lblSource.Text = "";
                    lblMessage.Text = "<b>Mensagem</b>:<br><br><font color='blue'>" + Request.QueryString["msg"] + "</font>";
                    break;
                }
                case "exp": // Login vencido (autentica��o expirada)
                {
                    Image1.ImageUrl = "~/imgsCCAB/warning.png";
                    MessageType = "Sess�o expirou";
                    lblSource.Text = "";
                    lblMessage.Text = "A sess�o expirou. Clique no bot�o abaixo para reiniciar.";
                    btFechar.Text = "Reiniciar";
                    btFechar.OnClientClick = "location.href('Default.aspx');return false;";
                    break;
                }
            }
        }
        ModalPopupExtender1.Show();
    }
}
