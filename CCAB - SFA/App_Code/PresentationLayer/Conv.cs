//
// Climb High - Biblioteca de Classes (Parcial)
// Hélcio Bertolin, 2003 - 2009
//
using System;
using System.Collections.Generic;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace Conv 
{
    ///
    ///<summary>Biblioteca Auxiliar da Camada de Apresentação</summary>           
    ///
    public class Lib
    {
        HttpContext ctx = HttpContext.Current;

        internal ContentPlaceHolder GetContainer() // Recupera o Container da página atual
        {
            System.Web.UI.Page p = (System.Web.UI.Page)ctx.CurrentHandler;
            ContentPlaceHolder _container = (ContentPlaceHolder)p.Controls[0].FindControl("ContentPlaceHolder1");
            return _container;
        }
        
        public void DisableControls()
        {
            FormView fv = (FormView)GetContainer().FindControl("Formulario1").FindControl("FormView1");
            
            foreach (FormViewRow r in fv.Controls[0].Controls)
            {
                foreach (TableCell cell in r.Controls)
                {
                    foreach (Control c in cell.Controls)
                    {
                        if (c is TextBox) {
                            TextBox ctrl = (TextBox)c;
                            ctrl.Enabled = false;
                        }
                        if (c is DropDownList) {
                            DropDownList ctrl = (DropDownList)c;
                            ctrl.Enabled = false;
                        }
                        if (c is CheckBox) {
                            CheckBox ctrl = (CheckBox)c;
                            ctrl.Enabled = false;
                        }
                    }
                }
            }
        }

        public void VerificarAcessoBotao(string dsNomeFuncionalidade, ImageButton NomeBotao)
        {
            DataTable loDataTableItemMenu;
            DataRow[] loDataRowItemMenu;
            string cdIndicadorTipoMenuOperacao = "0";

            string urlImagemHabilitada = "";
            string urlImagemDesabilitada = "";

            string Filtro;

            if (ctx.Session["Seguranca"] == null)
            {
                ctx.Response.Redirect("~/Default.aspx");
            }


            loDataTableItemMenu = (DataTable)ctx.Session["Seguranca"];



            switch (NomeBotao.ID.ToString())
            {
                case "btIncluir":
                    {
                        cdIndicadorTipoMenuOperacao = "1"; //Inclusão
                        urlImagemHabilitada = "~/imgsCCAB/tbTitulo_btIncluir.gif";
                        urlImagemDesabilitada = "~/imgsCCAB/tbTitulo_btIncluir_B.gif";

                        break;
                    }

                case "btEdit":
                    {
                        cdIndicadorTipoMenuOperacao = "2"; //Alteração
                        urlImagemHabilitada = "~/imgsCCAB/tbTitulo_btEditar.gif";
                        urlImagemDesabilitada = "~/imgsCCAB/tbTitulo_btEditar_B.gif";

                        break;
                    }

                case "btDelete":
                    {
                        cdIndicadorTipoMenuOperacao = "3"; //Exclusão
                        urlImagemHabilitada = "~/imgsCCAB/tbTitulo_btExcluir.gif";
                        urlImagemDesabilitada = "~/imgsCCAB/tbTitulo_btExcluir_B.gif";

                        break;
                    }

                case "btPesquisar":
                    {
                        cdIndicadorTipoMenuOperacao = "4"; //Pesquisa
                        urlImagemHabilitada = "~/imgsCCAB/tbGrid_operacoesPesquisar.gif";
                        urlImagemDesabilitada = "~/imgsCCAB/tbGrid_operacoesPesquisar.gif";

                        break;
                    }

                case "btView":
                    {
                        cdIndicadorTipoMenuOperacao = "5"; //Visualização
                        urlImagemHabilitada = "~/imgsCCAB/tbTitulo_btVisualizar.gif";
                        urlImagemDesabilitada = "~/imgsCCAB/tbTitulo_btVisualizar_B.gif";

                        break;
                    }

                default:
                    {
                        cdIndicadorTipoMenuOperacao = "0";

                        switch (NomeBotao.ID.ToString())
                        {
                            case "btHistorico":
                                {
                                    urlImagemHabilitada = "~/imgsCCAB/tbTitulo_btHistorico.gif";
                                    urlImagemDesabilitada = "~/imgsCCAB/tbTitulo_btHistorico_B.gif";
                                    break;
                                }

                            case "btPerfil":
                                {
                                    urlImagemHabilitada = "~/imgsCCAB/tbTitulo_btPerfil.gif";
                                    urlImagemDesabilitada = "~/imgsCCAB/tbTitulo_btPerfil_B.gif";
                                    break;
                                }

                            case "btEmail":
                                {
                                    urlImagemHabilitada = "~/imgsCCAB/tbTitulo_btE-mail.gif";
                                    urlImagemDesabilitada = "~/imgsCCAB/tbTitulo_btE-mail_B.gif";
                                    break;
                                }

                            case "btEndereco":
                                {
                                    urlImagemHabilitada = "~/imgsCCAB/tbTitulo_btPatrimonio.gif";
                                    urlImagemDesabilitada = "~/imgsCCAB/tbTitulo_btPatrimonio_B.gif";
                                    break;
                                }

                            case "btTelefone":
                                {
                                    urlImagemHabilitada = "~/imgsCCAB/tbTitulo_btTelefone.gif";
                                    urlImagemDesabilitada = "~/imgsCCAB/tbTitulo_btTelefone_B.gif";
                                    break;
                                }

                            case "btContato":
                                {
                                    urlImagemHabilitada = "~/imgsCCAB/tbTitulo_btContato.gif";
                                    urlImagemDesabilitada = "~/imgsCCAB/tbTitulo_btContato_B.gif";
                                    break;
                                }

                            case "btIdentificacao":
                                {
                                    urlImagemHabilitada = "~/imgsCCAB/tbTitulo_btDocumentos.gif";
                                    urlImagemDesabilitada = "~/imgsCCAB/tbTitulo_btDocumentos_B.gif";
                                    break;
                                }

                            case "btVinculo":
                                {
                                    urlImagemHabilitada = "~/imgsCCAB/tbTitulo_btVinculo.gif";
                                    urlImagemDesabilitada = "~/imgsCCAB/tbTitulo_btVinculo_B.gif";
                                    break;
                                }

                            case "btPatrimonio":
                                {
                                    urlImagemHabilitada = "~/imgsCCAB/tbTitulo_btPatrimonio.gif";
                                    urlImagemDesabilitada = "~/imgsCCAB/tbTitulo_btPatrimonio_B.gif";
                                    break;
                                }

                            case "btInteresse":
                                {
                                    urlImagemHabilitada = "~/imgsCCAB/tbTitulo_btInteresse.gif";
                                    urlImagemDesabilitada = "~/imgsCCAB/tbTitulo_btInteresse_B.gif";
                                    break;
                                }

                        }


                        break;
                    }
            }


            Filtro = "dsNomeFuncionalidade = '" + dsNomeFuncionalidade + "'";

            if (Convert.ToInt32(cdIndicadorTipoMenuOperacao) != 0)
            {
                Filtro = Filtro + " AND cdIndicadorTipoMenuOperacao = " + cdIndicadorTipoMenuOperacao;
            }
            else
            {
                Filtro = Filtro + " AND cdIndicadorTipoMenuOperacao = 4"; //Pesquisar 
            }

            loDataRowItemMenu = loDataTableItemMenu.Select(Filtro);
            if (loDataRowItemMenu.Length == 0)
            {
                NomeBotao.Enabled = false;
                NomeBotao.ImageUrl = urlImagemDesabilitada;
            }
            else
            {
                NomeBotao.Enabled = true;
                NomeBotao.ImageUrl = urlImagemHabilitada;
            }

        }

    } // Lib

    ///
    ///<summary>Recupera parâmetros automaticamente e executa o método especificado </summary> 
    ///<typeparam name="T">Type - Classe que contém o método a ser executado</typeparam>
    ///
    public class ReflectObject<T> where T : new() 
    { 
        public string Execute(string nomeMetodo, FormViewRow r)
        {
            string msg = "";

            Type t = typeof(T);
            
            T obj = new T();
            MethodInfo[] mi = t.GetMethods();
            ParameterInfo[] pi;

            string _content;

            foreach (MethodInfo m in mi)
            {
                if (m.Name == nomeMetodo)
                {
                    pi = m.GetParameters();
                    if (pi.Length > 0)
                    {
                        object[] args = new object[pi.Length];
                        int i = 0;
                        foreach (ParameterInfo p in pi)
                        {
                            Control ctrl = r.FindControl(p.Name);
                            _content = GetValueFromControl(ctrl);
                            if (_content != null)
                            {
                                try
                                {
                                    if (p.ParameterType.Name == "Int32")
                                        args[i] = Convert.ToInt32(_content);
                                    else if (p.ParameterType.Name == "Int64")
                                        args[i] = Convert.ToInt64(_content);
                                    else if (p.ParameterType.Name == "Decimal")
                                        args[i] = Convert.ToDecimal(_content);
                                    else if (p.ParameterType.Name == "Double")
                                        args[i] = Convert.ToDouble(_content);
                                    else if (p.ParameterType.Name == "DateTime")
                                        args[i] = Convert.ToDateTime(_content);
                                    else if (p.ParameterType.Name == "Boolean")
                                        args[i] = Convert.ToBoolean(_content);
                                    else
                                        args[i] = _content;
                                }
                                catch
                                {
                                    args[i] = null;
                                }
                            }
                            else
                                if (p.ParameterType.Name == "String")
                                    args[i] = "";
                            i++;
                        }
                        try
                        {
                            msg = (string) m.Invoke(obj, args);
                        }
                        catch 
                        {
                            return "Exceção na tentativa de gravação do Registro. Operação não foi efetivada.";
                        }
                    }
                }
            }
            return msg;
        }

        internal string GetValueFromControl(Control ctrl)
        {
            string _content = null;

            if (ctrl is TextBox)
            {
                TextBox c = (TextBox)ctrl;
                _content = c.Text;
            }
            else if (ctrl is DropDownList)
            {
                DropDownList c = (DropDownList)ctrl;
                _content = c.SelectedValue;
            }
            else if (ctrl is HiddenField)
            {
                HiddenField c = (HiddenField)ctrl;
                _content = c.Value;
            }
            else if (ctrl is CheckBox)
            {
                CheckBox c = (CheckBox)ctrl;
                _content = c.Checked ? "1" : "0";
            }
            else if (ctrl is RadioButton)
            {
                RadioButton c = (RadioButton)ctrl;
                _content = c.Checked ? "1" : "0";
            }
            else if (ctrl is Label)
            {
                Label c = (Label)ctrl;
                _content = c.Text;
            }
            else if (ctrl is LiteralControl)
            {
                LiteralControl c = (LiteralControl)ctrl;
                _content = c.Text;
            }

            return _content;
        }
    }

    // Struct utilizada no Passo1 do Pedido de Venda...
    public struct PVPasso1
    {
        public string nrPedidoVenda { get; set; }
        public string cdStatus { get; set; }
        public string nmStatus { get; set; }
        public string cdAgente { get; set; }
        public string nmAgente { get; set; }
        public string cdFaturamento { get; set; }
        public string nmFaturamento { get; set; }
        public string cdEntrega { get; set; }
        public string nmEntrega { get; set; }
        public string cdSafra { get; set; }
        public string nmSafra { get; set; }
        public string cdMoeda { get; set; }
        public string nmMoeda { get; set; }
        public string cdOrigemFaturamento { get; set; }
        public string nmOrigemFaturamento { get; set; }
        public string cdTipoPedido { get; set; }
        public string nmTipoPedido { get; set; }
        public string cdTipoProduto { get; set; }
        public string nmTipoProduto { get; set; }
    }

} // Conv