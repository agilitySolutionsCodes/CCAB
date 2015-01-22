using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Comum_OnDemandSearch : System.Web.UI.UserControl
{
    #region Propriedades

    public int Width { get; set; }
    public string CssClass { get; set; }
    private string Value { get; set; }
    private string Text { get; set; }
    public string InitialMessage { get; set; }
    public string AssociatedHiddenFieldValue { get; set; }
    public string DataValueField { get; set; }
    public string DataTextField { get; set; }

    #endregion Propriedades

    protected void Page_Init(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (CssClass != String.Empty)
            {
                this.TextBox1.CssClass = this.CssClass;
                this.ListBox1.CssClass = this.CssClass;
                this.ListBox1.BorderColor = System.Drawing.Color.Transparent;
                this.ListBox1.BorderStyle = BorderStyle.None;
                this.ListBox1.BorderWidth = Unit.Pixel(1);
            }

            if (this.DataValueField == null || this.DataTextField == null)
            {
                this.TextBox1.Text = "*** ERRO: [DataValueField e/ou DataTextField] não definidos";
                return;
            }

            if (Width == 0) Width = 100;

            this.TextBox1.Width = Unit.Pixel(this.Width - 4); // 25 (com o botão)

            this.ListBox1.Width = Unit.Pixel(this.Width);
            this.ListBox1.DataValueField = this.DataValueField;
            this.ListBox1.DataTextField = this.DataTextField;

            // Configuração da tecla "Seta para Baixo":
            // Transfere foco do TextBox para a Lista sem AssyncPostBack.
            // Demais teclas: AssyncPostBack
            StringBuilder sb = new StringBuilder("javascript:");
            sb.Append("if(event.keyCode == 40){event.cancelBubble=true;" + this.ListBox1.ClientID + ".focus();event.returnValue=false;}");
            sb.Append("else " + Page.ClientScript.GetPostBackEventReference(this.TextBox1, "@@@@@buttonAssyncPostBack") + ";");
            this.TextBox1.Attributes.Add("onKeyUp", sb.ToString());

            // Posicionamento do cursor após o último caracter do TextBox
            sb = new StringBuilder("javascript: _text = this.value; this.focus(); this.value = _text;");
            this.TextBox1.Attributes.Add("onfocus", sb.ToString());

            // Tecla "Enter" na Lista: Seleciona item e executa AssyncPostBack
            sb = new StringBuilder("javascript:");
            sb.Append("if(event.keyCode == 13)" + Page.ClientScript.GetPostBackEventReference(this.TextBox1, "@@@@@buttonAssyncPostBack") + "; ");
            sb.Append("else {event.cancelBubble = true; event.returnValue = true;}");
            this.ListBox1.Attributes.Add("onKeyDown", sb.ToString());

            // Double Click na Lista: Seleciona item e executa AssyncPostBack
            sb = new StringBuilder("javascript:");
            sb.Append(Page.ClientScript.GetPostBackEventReference(this.TextBox1, "@@@@@buttonAssyncPostBack") + "; ");
            this.ListBox1.Attributes.Add("ondblclick", sb.ToString());
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.ListBox1.SelectedItem != null)
        {
            this.Value = this.ListBox1.SelectedItem.Value;
            this.Text = this.ListBox1.SelectedItem.Text;
        }

        // Inicializa o conteúdo do TextBox e deixa o texto selecionado
        if (this.TextBox1.Text == String.Empty)
        {
            this.ListBox1.Visible = false;
            this.TextBox1.ForeColor = System.Drawing.Color.Gray;
            this.TextBox1.Text = this.InitialMessage;
            this.TextBox1.Attributes.Add("onClick", "javascript:this.form." + this.TextBox1.ClientID + ".focus(); this.form." + this.TextBox1.ClientID + ".select();");
        }
        else
        {
            this.TextBox1.ForeColor = System.Drawing.Color.Black;
            LoadData();
        }
    }

    protected void LoadData()
    {
        /* Custom...
        Usuario u = new Usuario();
        Pessoa p = new Pessoa();
        this.ListBox1.Items.Clear();
        this.ListBox1.DataSource = p.ObterListaOnDemandERP(this.TextBox1.Text, 3, u.cdUsuario).AsDataView();
        this.ListBox1.DataBind();
        this.ListBox1.Visible = true;
        this.TextBox1.Focus();
        */
    }

    /*
    protected void Button_Click(object sender, EventArgs e)
    {
        if (this.ListBox1.Items.Count > 0)
            this.ListBox1.Visible = true;
        else
            this.ListBox1.Visible = false;
    }
    */
    protected void SelectedIndexChanged(object sender, EventArgs e)
    {
        if (AssociatedHiddenFieldValue != null)
        {
            HiddenField h = (HiddenField)Parent.FindControl(AssociatedHiddenFieldValue);
            h.Value = this.Value;
            this.TextBox1.Text = this.Text;
            this.ListBox1.Visible = false;
        }
        else
        {
            this.TextBox1.Text = "*** ERRO: [AssociatedHiddenFieldValue] não definido";
            this.ListBox1.Visible = false;
        }
    }
}
