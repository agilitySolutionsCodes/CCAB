using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;

public partial class _SFA_TabelaPreco_Resultado : System.Web.UI.UserControl
{
    public bool _successMsg = false;
    private string _freeColumns = "";



    protected void btExcluir_Click(object sender, EventArgs e)
    {
        PessoaTabelaPrecoProduto obj = new PessoaTabelaPrecoProduto();
        string msg = "";

        msg = obj.Excluir(Convert.ToInt64(cdPessoaCooperativaSEQ.SelectedValue),
                          Convert.ToInt64(cdCronogramaSafraSEQ.SelectedValue));

        if (msg != "")
        {
            CustomValidator1.IsValid = false;
            CustomValidator1.ErrorMessage = msg;
        }
        else
            Session["ShowMessage"] = true;
    }

    protected void btPesquisar_Click(object sender, EventArgs e)
    {
        PessoaTabelaPrecoProduto obj = new PessoaTabelaPrecoProduto();

        // O método "VerificaDisponibilidadeColunasPreco" traz os números de coluna que poderão receber digitação 
        //(as demais são bloqueadas)
        _freeColumns = obj.VerificaDisponibilidadeColunasPreco(Convert.ToInt64(cdPessoaCooperativaSEQ.SelectedValue),
                                                               Convert.ToInt64(cdCronogramaSafraSEQ.SelectedValue)); // "3,5";

        DataTable dt = obj.ObterListaGeral(Convert.ToInt64(cdPessoaCooperativaSEQ.SelectedValue), Convert.ToInt64(cdCronogramaSafraSEQ.SelectedValue), Convert.ToInt64(dropDownListRegraProduto.SelectedValue));
        FpSpread1.CancelEdit();

        if (dt.Rows.Count > 0)
        {
            PopulateSpread(dt);
            btExcluir.Visible = true;
            btImprimir.Visible = true;
            btSalvar.Visible = true;
            FpSpread1.Visible = true;

            lblMensagem.Visible = false;
        }
        else
        {
            lblMensagem.Text = "Nenhum registro encontrado e/ou Regra de Produto não cadastrada para esta Cooperativa/Safra!";
            lblMensagem.Visible = true;
        }

        btImprimir.Attributes.Remove("onclick");
        btImprimir.Attributes.Add("onclick",
                                   string.Format("javascript: ExibirRelatorioTabelaPreco({0}, {1}, {2}); return false;",
                                   Convert.ToInt64(cdPessoaCooperativaSEQ.SelectedValue),
                                   Convert.ToInt64(cdCronogramaSafraSEQ.SelectedValue),
                                   Convert.ToInt64(dropDownListRegraProduto.SelectedValue)));

    }

    protected void btSalvar_Click(object sender, EventArgs e)
    {
        FpSpread1.SaveChanges();

        ListItemCollection lic = new ListItemCollection();
        ListItem l;

        for (int lin = 1; lin < FpSpread1.Rows.Count; lin++)
        {
            string _key = "", _value = "";
            for (int col = 2; col < FpSpread1.Columns.Count; col++)
            {   
                if (col % 2 == 0) // Coluna Par (KEY)
                {
                    _key = FpSpread1.Cells[lin, col].Value == null ? "" : FpSpread1.Cells[lin, col].Value.ToString();
                    if (_key == String.Empty)
                        _key = FpSpread1.Cells[lin, col].Value == null ? "" : FpSpread1.Cells[lin, col].Value.ToString();
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

        if (lic.Count > 0)
        {
            string msg = "";
            Usuario u = (Usuario)Session["Usuario"];
            PessoaTabelaPrecoProduto obj = new PessoaTabelaPrecoProduto();
            msg = obj.Salvar(lic, 
                             Convert.ToInt64(cdPessoaCooperativaSEQ.SelectedValue),
                             Convert.ToInt64(cdCronogramaSafraSEQ.SelectedValue), 
                             u.cdUsuario);
            if (msg == "")
                _successMsg = true;
            else
            {
                CustomValidator1.IsValid = false;
                CustomValidator1.ErrorMessage = msg;
            }
        }
    }    

    protected void PopulateSpread(DataTable tb)
    {
        System.Globalization.NumberFormatInfo ninfo = new System.Globalization.NumberFormatInfo();
        ninfo.NumberDecimalDigits = 4;
        ninfo.NumberDecimalSeparator = ",";
        ninfo.NumberGroupSeparator = ".";

        FarPoint.Web.Spread.DoubleCellType c = new FarPoint.Web.Spread.DoubleCellType();
        c.NumberFormat = ninfo;
        c.FixedPoint = true;
        c.DecimalDigits = 4;
        c.FormatString = "###,###,##0.0000";
        c.MinimumValue = 0;
        c.MaximumValue = 100000000;
        c.ErrorMessage = "Formato Inválido !";

        ConfigSpread(tb.Rows.Count, tb.Columns.Count);

        for (int lin = 0; lin < tb.Rows.Count; lin++)
            for (int col = 0; col < tb.Columns.Count; col++)
            {
                FpSpread1.Cells[lin, col].Value = tb.Rows[lin][col].ToString();
                FpSpread1.Cells[lin, col].Margin = new FarPoint.Web.Spread.Inset(5, 1, 5, 1);
            }

        for (int col = 0; col < tb.Columns.Count; col++)
        {
            // Esconde Colunas do tipo "KEY"
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
            }

            if (_freeColumns.Contains(col.ToString()))
                FpSpread1.Sheets[0].Columns[col].BackColor = System.Drawing.ColorTranslator.FromHtml("#ffffff");
            else
            {
                FpSpread1.Sheets[0].Columns[col].BackColor = System.Drawing.ColorTranslator.FromHtml("#eeefef");
                FpSpread1.Sheets[0].Columns[col].Locked = true;
            }    
        }
        
        FpSpread1.Sheets[0].SetRowVisible(0, false);
        FpSpread1.Visible = true;
    }

    protected void ConfigSpread(int _rows, int _cols)
    {
        // Rows / Columns / Page
        FpSpread1.Rows.Count = _rows;
        FpSpread1.Columns.Count = _cols;
        FpSpread1.Sheets[0].DefaultRowHeight = 19;
        FpSpread1.Sheets[0].DefaultColumnWidth = 66;
        FpSpread1.Sheets[0].PageSize = _rows;
        FpSpread1.Sheets[0].AllowPage = false;
        FpSpread1.Sheets[0].Columns[1].Width = 400; // Coluna Nome_Produto

        // Miscelaneous
        FpSpread1.UseClipboard = false;
        FpSpread1.RowHeader.Visible = false;
        FpSpread1.Sheets[0].FrozenColumnCount = 2;
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
        int _height = (_rows + 2) * 19;
        if (_height > 310) _height = 310;
        FpSpread1.Height = Unit.Pixel(_height);
        FpSpread1.Width = Unit.Percentage(100);

        // Border
        FpSpread1.BorderColor = System.Drawing.Color.LightGray; // ColorTranslator.FromHtml("#668024"); 
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

    protected void btImprimir_Click(object sender, EventArgs e)
    {
        UserControl uc = (UserControl)Parent.FindControl("TabelaPreco1");
        ModalPopupExtender mp = (ModalPopupExtender)uc.FindControl("ModalPopupExtender1");
        mp.Show();
    }



    private void ManipularCombosSpread()
    {
        FpSpread1.Visible = false;
        btExcluir.Visible = false;
        btImprimir.Visible = false;
        btSalvar.Visible = false;

        //Retorna Tipo Produto
        CronogramaSafraPrincipioAtivo Obj = new CronogramaSafraPrincipioAtivo();

        Int32 cdCronogramaSafraSEQ_aux = 0;
        if (cdCronogramaSafraSEQ.SelectedValue.ToString() != "")
        {
            cdCronogramaSafraSEQ_aux = Convert.ToInt32(cdCronogramaSafraSEQ.SelectedValue);
        }


        switch (Obj.ObterTipoProduto(cdCronogramaSafraSEQ_aux, Convert.ToInt32(cdPessoaCooperativaSEQ.SelectedValue)))
        {
            case 1:
                dropDownListRegraProduto.DataSourceID = "ObjectDataSourcePrincipioAtivo";
                dropDownListRegraProduto.DataBind();
                break;

            case 2:
                dropDownListRegraProduto.DataSourceID = "ObjectDataSourceProdutoAcabado";
                dropDownListRegraProduto.DataBind();
                break;

            case 3:
                dropDownListRegraProduto.DataSourceID = "dataSourceTipoProduto";
                dropDownListRegraProduto.DataBind();
                break;

            default:
                dropDownListRegraProduto.Items.Clear();
                dropDownListRegraProduto.DataBind();
                break;
        }

    }


    protected void cdCronogramaSafraSEQ_SelectedIndexChanged(object sender, EventArgs e)
    {
        ManipularCombosSpread();
    }
    protected void cdCronogramaSafraSEQAno_SelectedIndexChanged(object sender, EventArgs e)
    {
        MontarComboSafra();
        ManipularCombosSpread();
    }


    private void MontarComboSafra()
    {
        CronogramaSafra cronogramasafra = new CronogramaSafra();

        cdCronogramaSafraSEQ.DataSourceID = null;
        cdCronogramaSafraSEQ.DataValueField = "cdCronogramaSafraSEQ";
        cdCronogramaSafraSEQ.DataTextField = "dsCronogramaSafra";
        cdCronogramaSafraSEQ.DataSource = cronogramasafra.ObterLista("", 0, cdCronogramaSafraSEQAno.SelectedValue.ToString(), Convert.ToInt64(cdPessoaCooperativaSEQ.SelectedValue.ToString()), 0);
        cdCronogramaSafraSEQ.DataBind();

        cronogramasafra = null;

    }

    protected void cdPessoaCooperativaSEQ_PreRender(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            MontarComboSafra();
        }
    }
    protected void cdPessoaCooperativaSEQ_SelectedIndexChanged(object sender, EventArgs e)
    {
        MontarComboSafra();
        ManipularCombosSpread();
        
    }
}
