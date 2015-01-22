//
// Climb High - Biblioteca de Classes (Parcial)
// Hélcio Bertolin, 2003 - 2009
//
using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ConvWebControls
{
    public enum TextBoxType { Text, Date, Numeric  }

    public abstract class TextBoxBase : System.Web.UI.WebControls.TextBox
    {
        #region Propriedades

        public TextBoxType Type { get; set; }
        public int DecimalPlaces { get; set; }
        public bool ApplyFormat { get; set; }
        public bool IsValid { get; set; }
        public bool IsRequired { get; set; }
        public bool StrictText { get; set; }

        #endregion Propriedades
    }

    [DefaultProperty("Text")]
    [ToolboxData("<{0}:TextBox runat=\"server\"></{0}:TextBox>")]
    public class TextBox : TextBoxBase
    {
        protected override void Render(HtmlTextWriter writer)
        {
            // Default (se type não for declarado): TextBoxType.Text
            if (this.DecimalPlaces > 0) this.ApplyFormat = true; // Formatting é Default para valores decimais

            switch (this.Type)
            {
                case TextBoxType.Text:
                    {
                        string _onKeyPressScript = "javascript: avoidEnter();";
                        if (this.StrictText) _onKeyPressScript += " validateStrictText(this);";
                        this.Attributes.Add("onKeyPress", _onKeyPressScript);
                        this.Attributes.Add("onfocus", "javascript:this.form." + this.ClientID + ".value=this.value; " + this.ClientID + ".focus(); this.form." + this.ClientID + ".select();");
                        break;
                    }
                case TextBoxType.Numeric:
                    {
                        this.Attributes.Add("onKeyPress", "javascript:validateKeys(this);");
                        this.Attributes.Add("onfocus", "javascript:this.form." + this.ClientID + ".value=unFormatValue(this); " + this.ClientID + ".focus(); this.form." + this.ClientID + ".select();");

                        if (this.ApplyFormat)
                            this.Attributes.Add("onblur", "javascript:this.value=formatValue(this);");

                        this.Attributes.Add("style", "text-align: right;");
                        this.Attributes.Add("DecimalPlaces", this.DecimalPlaces.ToString());
                        break;
                    }
                case TextBoxType.Date:
                    {
                        //this.ToolTip = "Digite somente números. Formato: DDMMAAAA";
                        this.Attributes.Add("onKeyPress", "javascript:chkDate(this);");
                        this.Attributes.Add("onfocus", "javascript:this.form." + this.ClientID + ".focus(); this.form." + this.ClientID + ".select();"); // + this.ClientID + ".value=unFormatDate(this); " 
                        this.Attributes.Add("onblur", "javascript:this.value=formatDate(this);");

                        this.Columns = 9;
                        this.MaxLength = 10;

                        break;
                    }
            }

            this.Attributes.Add("IsRequired", this.IsRequired.ToString());
            this.Attributes.Add("IsValid", this.IsValid.ToString());

            base.Render(writer);
        }
    }
}
