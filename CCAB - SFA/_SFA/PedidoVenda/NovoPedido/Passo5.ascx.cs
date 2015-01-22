using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;
using Conv;

public partial class _SFA_PedidoVenda_NovoPedido_Passo5 : System.Web.UI.UserControl
{
    public string _moeda;

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (Session["cdPedidoVenda"] == null)
            return;

        PedidoVenda obj = new PedidoVenda();

        DataTable dt = obj.ObterListaCulturaGeral(Convert.ToInt64(Session["cdPedidoVenda"].ToString()));
        FpSpread1.CancelEdit();

        if (dt.Rows.Count > 0)
            PopulateSpread(dt);

        PVPasso1 p1 = (PVPasso1)Session["PVPasso1"];
        _moeda = p1.nmMoeda;
    }   

    protected void PopulateSpread(DataTable tb)
    {
        System.Globalization.NumberFormatInfo ninfo = new System.Globalization.NumberFormatInfo();
        ninfo.NumberDecimalDigits = 2;
        ninfo.NumberDecimalSeparator = ",";
        ninfo.NumberGroupSeparator = ".";

        FarPoint.Web.Spread.DoubleCellType c = new FarPoint.Web.Spread.DoubleCellType();
        c.NumberFormat = ninfo;
        c.FixedPoint = true;
        c.DecimalDigits = 2;
        c.FormatString = "###.###.##0,00";
        c.MinimumValue = 0;
        c.MaximumValue = 100000000;
        c.ErrorMessage = "Formato Inválido !";

        ConfigSpread(tb.Rows.Count, tb.Columns.Count);

        for (int lin = 0; lin < tb.Rows.Count; lin++)
        {
            for (int col = 0; col < tb.Columns.Count; col++)
            {
                FpSpread1.Cells[lin, col].Value = tb.Rows[lin][col].ToString();
                FpSpread1.Cells[lin, col].Margin = new FarPoint.Web.Spread.Inset(5, 1, 5, 1);
            }
        }
       
        for (int col = 0; col < tb.Columns.Count; col++)
        {
            // Esconde Colunas
            if (tb.Rows[0][col].ToString() == String.Empty || tb.Rows[0][col].ToString() == "0")
                FpSpread1.Sheets[0].SetColumnVisible(col, false);
            else
            {
                FpSpread1.ColumnHeader.Cells[0, col].Text = tb.Rows[0][col].ToString();
                FpSpread1.ColumnHeader.Cells[0, col].Margin = new FarPoint.Web.Spread.Inset(5, 1, 5, 1);
            }
            
            if (tb.Rows[0].Table.Columns[col].ColumnName.Contains("VALUE"))
            {
                FpSpread1.ActiveSheetView.Columns[col].CellType = c;

                FpSpread1.ColumnHeader.Cells[0, col].HorizontalAlign = HorizontalAlign.Right;
                FpSpread1.Sheets[0].Columns[col].HorizontalAlign = HorizontalAlign.Right;

                // Bloqueia colunas que não devem receber digitação
                if (tb.Rows[0].Table.Columns[col].ColumnName.Contains("VALUEA"))
                {
                    // Inclusão
                    if (tb.Rows[0].Table.Columns[col].ColumnName.Contains("TOTAL") || tb.Rows[0].Table.Columns[col].ColumnName.Contains("PLANEJADA"))
                    {
                        FpSpread1.Sheets[0].Columns[col].BackColor = System.Drawing.ColorTranslator.FromHtml("#eeefef");
                        FpSpread1.Sheets[0].Columns[col].ForeColor = System.Drawing.ColorTranslator.FromHtml("#808080");
                        FpSpread1.Sheets[0].Columns[col].Locked = true;
                    }    
                    else
                        FpSpread1.Sheets[0].SetColumnVisible(col, false);
                }
                else
                    FpSpread1.Sheets[0].Columns[col].BackColor = System.Drawing.ColorTranslator.FromHtml("#ffffff");
            }   
        }

        for (int lin = 0; lin < tb.Rows.Count; lin++)
        {
            // Checagem do Flag para desabilitação de linha (produto pertencente a Kit)
            if (FpSpread1.Cells[lin, tb.Columns.Count - 1].Value.ToString() == "1")
            {
                FpSpread1.Rows[lin].BackColor = System.Drawing.ColorTranslator.FromHtml("#eeefef");
                FpSpread1.Rows[lin].ForeColor = System.Drawing.ColorTranslator.FromHtml("#808080");
                FpSpread1.Rows[lin].Locked = true;
                FpSpread1.Cells[lin, 2].Text += " (*)"; // Identifica produto como parte de Kit para tratamento no JavaScript
            }
        }

        // Coluna Nome_Produto ////////////////////
        FpSpread1.Sheets[0].Columns[2].BackColor = System.Drawing.ColorTranslator.FromHtml("#eeefef");
        FpSpread1.Sheets[0].Columns[2].Locked = true;
        FpSpread1.Sheets[0].Columns[2].Width = 250; 
        ///////////////////////////////////////////

        FpSpread1.Sheets[0].SetRowVisible(0, false);
        FpSpread1.Visible = true;
    }

    protected void ConfigSpread(int _rows, int _cols)
    {
        // Rows / Columns / Page
        FpSpread1.Rows.Count = _rows;
        FpSpread1.Columns.Count = _cols;
        FpSpread1.Sheets[0].DefaultRowHeight = 19;
        FpSpread1.Sheets[0].DefaultColumnWidth = 90;
        FpSpread1.Sheets[0].PageSize = _rows;
        FpSpread1.Sheets[0].AllowPage = false;

        // Miscelaneous
        FpSpread1.UseClipboard = false;
        FpSpread1.RowHeader.Visible = false;
        FpSpread1.Sheets[0].FrozenColumnCount = 4;
        FpSpread1.ActiveSheetView.OperationMode = FarPoint.Web.Spread.OperationMode.Normal;
        FpSpread1.EditModeReplace = true;
        FpSpread1.ActiveSheetView.OperationMode = FarPoint.Web.Spread.OperationMode.RowMode;
        FpSpread1.ActiveSheetView.SelectionBackColor = System.Drawing.ColorTranslator.FromHtml("#99CC00");
        
        // ScrollBars
        FpSpread1.HorizontalScrollBarPolicy = FarPoint.Web.Spread.ScrollBarPolicy.AsNeeded;
        FpSpread1.VerticalScrollBarPolicy = FarPoint.Web.Spread.ScrollBarPolicy.AsNeeded;
        FpSpread1.ScrollBarBaseColor = System.Drawing.ColorTranslator.FromHtml("#668024");

        // CommandBar
        FpSpread1.CommandBar.Visible = false;
        
        // Height / Width
        int _height = (_rows + 3) * 19;
        if (_height > 310) _height = 310;
        FpSpread1.Height = Unit.Pixel(_height);  
        FpSpread1.Width = Unit.Percentage(100);

        // Border
        FpSpread1.BorderColor = System.Drawing.Color.LightGray; // ColorTranslator.FromHtml("#F0F0F0"); 
        FpSpread1.BorderStyle = BorderStyle.Solid;
        FpSpread1.BorderWidth = Unit.Pixel(1); 

        // Header Style
        FarPoint.Web.Spread.StyleInfo headerStyle = new FarPoint.Web.Spread.StyleInfo();
        headerStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#668024"); 
        headerStyle.ForeColor = System.Drawing.ColorTranslator.FromHtml("#FFFFFF"); 
        headerStyle.Font.Name = "Arial";
        headerStyle.Font.Size = FontUnit.Point(8);
        headerStyle.Font.Bold = true;
        
        // Row style
        FarPoint.Web.Spread.StyleInfo rowStyle = new FarPoint.Web.Spread.StyleInfo();
        rowStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFFFFF"); 
        rowStyle.ForeColor = System.Drawing.ColorTranslator.FromHtml("#000000"); 
        rowStyle.Font.Name = "Arial";
        rowStyle.Font.Size = FontUnit.Point(8);

        // Apply Style
        FpSpread1.ActiveSheetView.HeaderGrayAreaColor = System.Drawing.ColorTranslator.FromHtml("#FFFFFF");
        FpSpread1.ActiveSheetView.DefaultStyle = rowStyle;
        FpSpread1.ActiveSheetView.ColumnHeader.DefaultStyle = headerStyle;
    }

    protected void btAtualizarP5_Click(object sender, EventArgs e)
    {
        string msg = SalvaPasso5();

        if (msg != "")
        {
            CustomValidator1.IsValid = false;
            CustomValidator1.ErrorMessage = msg;
            return;
        }
    }

    protected string SalvaPasso5()
    {
        PedidoVenda obj = new PedidoVenda();
        PVPasso1 p1 = (PVPasso1)Session["PVPasso1"];

        return obj.SalvarCulturaTmp(GetValuesFromSpread(FpSpread1),
                                    Convert.ToInt64(Session["cdUsuario"]),
                                    Convert.ToInt64(p1.cdAgente),
                                    Convert.ToInt64(p1.cdSafra));
    }

    protected ListItemCollection GetValuesFromSpread(FarPoint.Web.Spread.FpSpread FpSpread1)
    {
        FpSpread1.SaveChanges();

        ListItemCollection lic = new ListItemCollection();
        ListItem l;

        for (int lin = 1; lin < FpSpread1.Rows.Count; lin++)
        {
            string _key = "", _value = "";
            for (int col = 4; col < FpSpread1.Columns.Count; col++)
            {
                if (col % 2 == 0) // Coluna Par (KEY)
                {
                    _key = FpSpread1.Cells[lin, col].Value == null ? "" : FpSpread1.Cells[lin, col].Value.ToString();
                    if (_key == String.Empty)
                        _key = FpSpread1.Cells[lin, col].Value == null ? "" : FpSpread1.Cells[lin, col].Value.ToString();

                    // Atribui "" à chave inválida para que o par venha a ser desprezado 
                    if (!_key.Contains("-")) _key = String.Empty;
                }
                else // Coluna Impar (VALUE)
                {
                    _value = FpSpread1.Cells[lin, col].Value == null ? "" : FpSpread1.Cells[lin, col].Value.ToString();
                    if (_value == String.Empty)
                        _value = FpSpread1.Cells[lin, col].Value == null ? "" : FpSpread1.Cells[lin, col].Value.ToString();

                    if (_key != String.Empty && _value != String.Empty)
                    {
                        l = new ListItem(_key, _value);
                        lic.Add(l);
                    }
                    _key = "";
                    _value = "";
                }
            }
        }

        return lic;
    } 
}
