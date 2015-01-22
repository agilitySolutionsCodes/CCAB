using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;


/// <summary>
/// Summary description for PedidoVenda
/// </summary>
public class PedidoVenda
{
    #region Propriedades

    public Int64 tmpPedidoVendaSEQ { get; set; }
    public Int64 cdPedidoVendaSEQ { get; set; }

    #endregion Propriedades

    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares

    public PedidoVenda()
    {
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
    }

    #region Métodos



    public string IncluirTmp_Inclusao(Int64 cdAgenteComercialCooperativaPedidoVenda, Int64 cdCronogramaSafraSEQ, Int64 cdClienteFaturamentoPedidoVenda, Int64 cdClienteEntregaPedidoVenda, Int64 cdIndicadorMoedaPedidoVenda, Int64 cdUsuarioUltimaAlteracao, Int64 cdPessoaOrigemFaturamento, Int32 cdTipoPedidoVenda, Int32 cdTipoProduto)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;




            //Consistências
            if (cdAgenteComercialCooperativaPedidoVenda == 0)
            {
                return "Agente Comercial Cooperativa" + moPadrao.MensagemObrigatorio;
            }

            if (cdCronogramaSafraSEQ == 0)
            {
                return "Cronograma Safra" + moPadrao.MensagemObrigatorio;
            }

            if (cdClienteFaturamentoPedidoVenda == 0)
            {
                return "Cliente Pedido" + moPadrao.MensagemObrigatorio;
            }

            if (cdClienteEntregaPedidoVenda == 0)
            {
                return "Local Entrega Pedido" + moPadrao.MensagemObrigatorio;
            }

            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }

            if (cdPessoaOrigemFaturamento == 0)
            {
                return "Origem de Faturamento" + moPadrao.MensagemObrigatorio;
            }


            // Verifica se o Compromisso de Compra esta liberado para utilização de pedidos
            bool lbDisponivel = true;
            lbDisponivel = VerificaDisponibilidadeCompromisso(cdAgenteComercialCooperativaPedidoVenda, cdCronogramaSafraSEQ, cdIndicadorMoedaPedidoVenda, cdPessoaOrigemFaturamento, cdTipoProduto);
            if (lbDisponivel == false)
            {
                return "Compromisso de Compra para os parâmetros informados não está liberado pela CCAB para digitação de Pedidos e/ou Tipo de Produto Incompatível";

            }

            // Verifica se o estado do endereco principal do cliente é diferente do estado do enderece de entrega do local de entrega
            if (cdTipoPedidoVenda == 1)
            {
                lbDisponivel = VerificaEstadoLocalEntrega(cdClienteFaturamentoPedidoVenda, cdClienteEntregaPedidoVenda);
                if (lbDisponivel == false)
                {
                    return "Estado do Endereço Principal do Cliente diferente do Estado do Endereço de Entrega do Cliente informado como Local de Entrega";
                }
            }

            // Verifica se o Pedido de Venda já foi digitado para o Cliente Escolhido
            lbDisponivel = VerificaDisponibilidadePedido(cdAgenteComercialCooperativaPedidoVenda, cdClienteFaturamentoPedidoVenda, cdClienteEntregaPedidoVenda, cdPessoaOrigemFaturamento, cdCronogramaSafraSEQ, cdIndicadorMoedaPedidoVenda, 0);
            if (lbDisponivel == false)
            {
                return "Pedido de Venda já digitado para os parâmetros informados";

            }

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoPedidoVenda");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_I_tmpPedidoVenda_Inclusao";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdAgenteComercialCooperativaPedidoVenda", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdAgenteComercialCooperativaPedidoVenda"].Value = cdAgenteComercialCooperativaPedidoVenda;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            loSqlCommand.Parameters.Add("@cdClienteFaturamentoPedidoVenda", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdClienteFaturamentoPedidoVenda"].Value = cdClienteFaturamentoPedidoVenda;

            loSqlCommand.Parameters.Add("@cdClienteEntregaPedidoVenda", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdClienteEntregaPedidoVenda"].Value = cdClienteEntregaPedidoVenda;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.Parameters.Add("@cdPessoaOrigemFaturamento", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaOrigemFaturamento"].Value = cdPessoaOrigemFaturamento;

            loSqlCommand.Parameters.Add("@cdIndicadorMoedaPedidoVenda", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorMoedaPedidoVenda"].Value = cdIndicadorMoedaPedidoVenda;

            loSqlCommand.Parameters.Add("@cdTipoPedidoVenda", SqlDbType.Int);
            loSqlCommand.Parameters["@cdTipoPedidoVenda"].Value = cdTipoPedidoVenda;

            loSqlCommand.Parameters.Add("@cdTipoProduto", SqlDbType.Int);
            loSqlCommand.Parameters["@cdTipoProduto"].Value = cdTipoProduto;

            loSqlCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@tmpPedidoVendaSEQ"].Direction = ParameterDirection.Output;

           

            loSqlCommand.ExecuteNonQuery();

            tmpPedidoVendaSEQ = Convert.ToInt64(loSqlCommand.Parameters["@tmpPedidoVendaSEQ"].Value);

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoPedidoVenda");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public Int64 VerificaParametroPrecoProdutoPedido(Int64 cdAgenteComercialCooperativaPedidoVenda, Int64 cdCronogramaSafraSEQ)
    {

        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_VerificaParametroPrecoProduto", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        Int32 vrQuantidade;

        vrQuantidade = 10; // Parametro Inicial

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialCooperativaCompromissoCompra", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialCooperativaCompromissoCompra"].Value = cdAgenteComercialCooperativaPedidoVenda;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

        loSqlDataAdapter.Fill(loDataTable);

        loSqlConnection.Close();
        loSqlConnection = null;

        if (loDataTable.Rows.Count > 0)
        {
            // vrQuantidade = Convert.ToInt64(loDataTable.Rows[0]["qtProdutoPrecoCronogramaSafra"]);
            vrQuantidade = Convert.ToInt32(loDataTable.Rows[0]["qtProdutoPrecoCronogramaSafra"]);

            return vrQuantidade;

        }
        else
        {
            return vrQuantidade;
        }

    }

    public string IncluirTmp_Alteracao(Int64 cdPedidoVendaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            if (cdPedidoVendaAlteracao == 0)
            {
                return "Código do Pedido não informado !!!" + moPadrao.MensagemObrigatorio;
            }

            cdPedidoVendaSEQ = cdPedidoVendaAlteracao;

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoPedidoVenda");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_I_tmpPedidoVenda_Alteracao";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPedidoVendaSEQ"].Value = cdPedidoVendaSEQ;

            loSqlCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@tmpPedidoVendaSEQ"].Direction = ParameterDirection.Output;

            loSqlCommand.ExecuteNonQuery();

            tmpPedidoVendaSEQ = Convert.ToInt64(loSqlCommand.Parameters["@tmpPedidoVendaSEQ"].Value);

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoPedidoVenda");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string ExcluirTmp(Int64 tmpPedidoVendaSEQ)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoPedidoVenda");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_D_tmpPedidoVenda";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@tmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQ;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoPedidoVenda");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroExclusao;
        }
    }


    public string SalvarTmp(Int64 tmpPedidoVendaSEQ, Int64 cdClienteEntregaPedidoVenda)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            //Abro conexão e transação
            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoPedidoVenda");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.Parameters.Clear();
            loSqlCommand.CommandText = "SP_U_tmpPedidoVenda";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@tmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQ;

            loSqlCommand.Parameters.Add("@cdClienteEntregaPedidoVenda", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdClienteEntregaPedidoVenda"].Value = cdClienteEntregaPedidoVenda;

            loSqlCommand.ExecuteNonQuery();

            // Efetiva a Transação
            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoPedidoVenda");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }


    public string SalvarTmp(ListItemCollection lsLista, Int64 cdUsuarioUltimaAlteracao, Int64 cdAgenteComercialCooperativaCompromissoCompra, Int64 cdCronogramaSafraSEQ, Int64 cdIndicadorMoedaPedidoVenda, Int64 cdPessoaOrigemFaturamento)
    {
        SqlTransaction loSqlTransaction = null;
        Int64 tmpPedidoVendaSEQKit = 0;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            string lsValue;
            string lsText;
            string[] lsArray;


            Int64 tmpPedidoVendaItemSEQ;
            Int64 tmpPedidoVendaSEQ;
            Int64 cdProdutoSEQ;
            Int64 cdCronogramaSafraVencimentoSEQ;
            decimal qtPedidoVendaItem;
            string cdGravacao;


            //Consistências
            //Abro o array
            foreach (ListItem itItem in lsLista)
            {
                lsValue = itItem.Value;
                lsText = itItem.Text;

                if (lsText.Trim() == "")
                {
                    return "Foram encontradas chaves em branco";
                }

                if (lsValue.Trim() == "")
                {
                    return "Foram encontrados conteúdos em branco";
                }

            }

            //Abro conexão e transação
            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoPedidoVenda");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            foreach (ListItem itItem in lsLista)
            {
                lsValue = itItem.Value;
                lsText = itItem.Text;

                lsArray = lsText.Split(new char[] { '-' });

                cdGravacao = lsArray[0].ToString();

                tmpPedidoVendaItemSEQ = Convert.ToInt64(lsArray[1].ToString());
                tmpPedidoVendaSEQ = Convert.ToInt64(lsArray[2].ToString());
                cdProdutoSEQ = Convert.ToInt64(lsArray[3].ToString());
                cdCronogramaSafraVencimentoSEQ = Convert.ToInt64(lsArray[5].ToString());

                tmpPedidoVendaSEQKit = tmpPedidoVendaSEQ;
                qtPedidoVendaItem = Convert.ToDecimal(lsValue);


                if (cdGravacao == "X")
                {

                    loSqlCommand.Parameters.Clear();

                    if (tmpPedidoVendaItemSEQ == 0) //Inclusão
                    {
                        loSqlCommand.CommandText = "SP_I_tmpPedidoVendaItem";
                        loSqlCommand.CommandType = CommandType.StoredProcedure;

                        loSqlCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@tmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQ;

                        loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

                        loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

                        loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

                        loSqlCommand.Parameters.Add("@qtPedidoVendaItem", SqlDbType.Float);
                        loSqlCommand.Parameters["@qtPedidoVendaItem"].Value = qtPedidoVendaItem;

                        loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

                        loSqlCommand.Parameters.Add("@cdAgenteComercialCooperativaCompromissoCompra", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdAgenteComercialCooperativaCompromissoCompra"].Value = cdAgenteComercialCooperativaCompromissoCompra;

                        loSqlCommand.Parameters.Add("@cdPessoaOrigemFaturamento", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdPessoaOrigemFaturamento"].Value = cdPessoaOrigemFaturamento;

                        loSqlCommand.Parameters.Add("@cdIndicadorMoedaPedidoVenda", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdIndicadorMoedaPedidoVenda"].Value = cdIndicadorMoedaPedidoVenda;

                        loSqlCommand.Parameters.Add("@tmpPedidoVendaItemSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@tmpPedidoVendaItemSEQ"].Direction = ParameterDirection.Output;


                    }
                    else //Alteração
                    {
                        loSqlCommand.CommandText = "SP_U_tmpPedidoVendaItem";
                        loSqlCommand.CommandType = CommandType.StoredProcedure;


                        loSqlCommand.Parameters.Add("@tmpPedidoVendaItemSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@tmpPedidoVendaItemSEQ"].Value = tmpPedidoVendaItemSEQ;

                        loSqlCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@tmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQ;

                        loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

                        loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

                        loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

                        loSqlCommand.Parameters.Add("@qtPedidoVendaItem", SqlDbType.Float);
                        loSqlCommand.Parameters["@qtPedidoVendaItem"].Value = qtPedidoVendaItem;

                        loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

                    }

                    loSqlCommand.ExecuteNonQuery();

                }


            }

            // Atualiza KIT de Produtos
            loSqlCommand.Parameters.Clear();
            loSqlCommand.CommandText = "SP_U_tmpPedidoVendaItemKIT";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@tmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQKit;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.ExecuteNonQuery();
             
            // Efetiva a Transação
            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoPedidoVenda");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }


    public string ConsistirEntrega(Int32 cdTipoPedidoVenda, Int64 cdClienteFaturamentoPedidoVenda, Int64 cdClienteEntregaPedidoVenda)
    {

        try
        {

            bool lbDisponivel;

            if (cdClienteEntregaPedidoVenda == 0)
            {
                return "Local Entrega Pedido" + moPadrao.MensagemObrigatorio;
            }


            // Verifica se o estado do endereco principal do cliente é diferente do estado do enderece de entrega do local de entrega
            if (cdTipoPedidoVenda == 1)
            {
                lbDisponivel = VerificaEstadoLocalEntrega(cdClienteFaturamentoPedidoVenda, cdClienteEntregaPedidoVenda);
                if (lbDisponivel == false)
                {
                    return "Estado do Endereço Principal do Cliente diferente do Estado do Endereço de Entrega do Cliente informado como Local de Entrega";
                }
            }

            return "";
        }
        catch (Exception loException)
        {
             moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }


    public string SalvarEntregaTmp(ListItemCollection lsLista, Int64 cdUsuarioUltimaAlteracao, Int64 cdAgenteComercialCooperativaCompromissoCompra, Int64 cdCronogramaSafraSEQ)
    {
        SqlTransaction loSqlTransaction = null;
        Int64 tmpPedidoVendaSEQKit = 0;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            string lsValue;
            string lsText;
            string[] lsArray;


            Int64 tmpPedidoVendaItemEntregaSEQ;
            Int64 tmpPedidoVendaSEQ;
            Int64 cdProdutoSEQ;
            DateTime dtAnoMesPedidoVendaItemEntrega;
            decimal qtPedidoVendaItemEntrega;
            string cdGravacao;


            //Consistências
            //Abro o array
            foreach (ListItem itItem in lsLista)
            {
                lsValue = itItem.Value;
                lsText = itItem.Text;

                if (lsText.Trim() == "")
                {
                    return "Foram encontradas chaves em branco";
                }

                if (lsValue.Trim() == "")
                {
                    return "Foram encontrados conteúdos em branco";
                }

            }

            //Abro conexão e transação
            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoPedidoVenda");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            foreach (ListItem itItem in lsLista)
            {
                lsValue = itItem.Value;
                lsText = itItem.Text;

                lsArray = lsText.Split(new char[] { '-' });

                cdGravacao = lsArray[0].ToString();

                tmpPedidoVendaItemEntregaSEQ = Convert.ToInt64(lsArray[0].ToString());
                tmpPedidoVendaSEQ = Convert.ToInt64(lsArray[1].ToString());
                cdProdutoSEQ = Convert.ToInt64(lsArray[2].ToString());
                dtAnoMesPedidoVendaItemEntrega = Convert.ToDateTime(lsArray[4]);

                tmpPedidoVendaSEQKit = tmpPedidoVendaSEQ;
                qtPedidoVendaItemEntrega = Convert.ToDecimal(lsValue);

                loSqlCommand.Parameters.Clear();

                if (tmpPedidoVendaItemEntregaSEQ == 0) //Inclusão
                {
                    loSqlCommand.CommandText = "SP_I_tmpPedidoVendaItemEntrega";
                    loSqlCommand.CommandType = CommandType.StoredProcedure;

                    loSqlCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@tmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQ;

                    loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

                    loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

                    loSqlCommand.Parameters.Add("@dtAnoMesPedidoVendaItemEntrega", SqlDbType.DateTime);
                    loSqlCommand.Parameters["@dtAnoMesPedidoVendaItemEntrega"].Value = dtAnoMesPedidoVendaItemEntrega;

                    loSqlCommand.Parameters.Add("@qtPedidoVendaItemEntrega", SqlDbType.Float);
                    loSqlCommand.Parameters["@qtPedidoVendaItemEntrega"].Value = qtPedidoVendaItemEntrega;

                    loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

                    loSqlCommand.Parameters.Add("@tmpPedidoVendaItemEntregaSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@tmpPedidoVendaItemEntregaSEQ"].Direction = ParameterDirection.Output;


                }
                else //Alteração
                {
                    loSqlCommand.CommandText = "SP_U_tmpPedidoVendaItemEntrega";
                    loSqlCommand.CommandType = CommandType.StoredProcedure;


                    loSqlCommand.Parameters.Add("@tmpPedidoVendaItemEntregaSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@tmpPedidoVendaItemEntregaSEQ"].Value = tmpPedidoVendaItemEntregaSEQ;

                    loSqlCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@tmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQ;

                    loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

                    loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

                    loSqlCommand.Parameters.Add("@dtAnoMesPedidoVendaItemEntrega", SqlDbType.DateTime);
                    loSqlCommand.Parameters["@dtAnoMesPedidoVendaItemEntrega"].Value = dtAnoMesPedidoVendaItemEntrega;

                    loSqlCommand.Parameters.Add("@qtPedidoVendaItemEntrega", SqlDbType.Float);
                    loSqlCommand.Parameters["@qtPedidoVendaItemEntrega"].Value = qtPedidoVendaItemEntrega;

                    loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

                }

                loSqlCommand.ExecuteNonQuery();


            }

            // Atualiza KIT de Produtos
            loSqlCommand.Parameters.Clear();
            loSqlCommand.CommandText = "SP_U_tmpPedidoVendaItemEntregaKIT";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@tmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQKit;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoPedidoVenda");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public string SalvarCulturaTmp(ListItemCollection lsLista, Int64 cdUsuarioUltimaAlteracao, Int64 cdAgenteComercialCooperativaCompromissoCompra, Int64 cdCronogramaSafraSEQ)
    {
        SqlTransaction loSqlTransaction = null;
        Int64 tmpPedidoVendaSEQKit = 0;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            string lsValue;
            string lsText;
            string[] lsArray;


            Int64 tmpPedidoVendaItemCulturaSEQ;
            Int64 tmpPedidoVendaSEQ;
            Int64 cdProdutoSEQ;
            Int64 cdTipoCulturaSEQ;
            decimal qtPedidoVendaItemCultura;
            string cdGravacao;


            //Consistências
            //Abro o array
            foreach (ListItem itItem in lsLista)
            {
                lsValue = itItem.Value;
                lsText = itItem.Text;

                if (lsText.Trim() == "")
                {
                    return "Foram encontradas chaves em branco";
                }

                if (lsValue.Trim() == "")
                {
                    return "Foram encontrados conteúdos em branco";
                }

            }

            //Abro conexão e transação
            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoPedidoVenda");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            foreach (ListItem itItem in lsLista)
            {
                lsValue = itItem.Value;
                lsText = itItem.Text;

                lsArray = lsText.Split(new char[] { '-' });

                cdGravacao = lsArray[0].ToString();

                tmpPedidoVendaItemCulturaSEQ = Convert.ToInt64(lsArray[0].ToString());
                tmpPedidoVendaSEQ = Convert.ToInt64(lsArray[1].ToString());
                cdProdutoSEQ = Convert.ToInt64(lsArray[2].ToString());
                cdTipoCulturaSEQ = Convert.ToInt64(lsArray[4].ToString());

                tmpPedidoVendaSEQKit = tmpPedidoVendaSEQ;
                qtPedidoVendaItemCultura = Convert.ToDecimal(lsValue);

                loSqlCommand.Parameters.Clear();

                if (tmpPedidoVendaItemCulturaSEQ == 0) //Inclusão
                {
                    loSqlCommand.CommandText = "SP_I_tmpPedidoVendaItemCultura";
                    loSqlCommand.CommandType = CommandType.StoredProcedure;

                    loSqlCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@tmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQ;

                    loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

                    loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

                    loSqlCommand.Parameters.Add("@cdTipoCulturaSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@cdTipoCulturaSEQ"].Value = cdTipoCulturaSEQ;

                    loSqlCommand.Parameters.Add("@qtPedidoVendaItemCultura", SqlDbType.Float);
                    loSqlCommand.Parameters["@qtPedidoVendaItemCultura"].Value = qtPedidoVendaItemCultura;

                    loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

                    loSqlCommand.Parameters.Add("@tmpPedidoVendaItemCulturaSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@tmpPedidoVendaItemCulturaSEQ"].Direction = ParameterDirection.Output;


                }
                else //Alteração
                {
                    loSqlCommand.CommandText = "SP_U_tmpPedidoVendaItemCultura";
                    loSqlCommand.CommandType = CommandType.StoredProcedure;


                    loSqlCommand.Parameters.Add("@tmpPedidoVendaItemCulturaSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@tmpPedidoVendaItemCulturaSEQ"].Value = tmpPedidoVendaItemCulturaSEQ;

                    loSqlCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@tmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQ;

                    loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

                    loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

                    loSqlCommand.Parameters.Add("@cdTipoCulturaSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@cdTipoCulturaSEQ"].Value = cdTipoCulturaSEQ;

                    loSqlCommand.Parameters.Add("@qtPedidoVendaItemCultura", SqlDbType.Float);
                    loSqlCommand.Parameters["@qtPedidoVendaItemCultura"].Value = qtPedidoVendaItemCultura;

                    loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

                }

                loSqlCommand.ExecuteNonQuery();


            }

            // Atualiza KIT de Produtos
            loSqlCommand.Parameters.Clear();
            loSqlCommand.CommandText = "SP_U_tmpPedidoVendaItemCulturaKIT";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@tmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQKit;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoPedidoVenda");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public DataTable ObterListaGeral(Int64 @tmpPedidoVendaSEQ, int cdTipoProduto)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PedidoVendaItem_Geral", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@tmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQ;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdTipoProduto", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdTipoProduto"].Value = cdTipoProduto.Equals(0) ? (object)DBNull.Value : cdTipoProduto;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaEntregaGeral(Int64 @tmpPedidoVendaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PedidoVendaItemEntrega_Geral", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@tmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQ;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaCulturaGeral(Int64 @tmpPedidoVendaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PedidoVendaItemCultura_Geral", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@tmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQ;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterResumoVencimentoTMP(Int64 @tmpPedidoVendaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PedidoVendaResumoVencimento_TMP", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@tmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQ;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterValorTotalPedidoTMP(Int64 @tmpPedidoVendaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PedidoVendaValorTotal_TMP", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@tmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQ;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterResumoDadosTMP(Int64 @tmpPedidoVendaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PedidoVendaResumoDados_TMP", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@tmpPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@tmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQ;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public string SalvaPedidoInclusao(Int64 tmpPedidoVendaSEQ, Int64 cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;



            //Consistências
            //if (cdAgenteComercialCooperativaPedidoVenda == 0)
            //{
            //    return "Agente Comercial Cooperativa" + moPadrao.MensagemObrigatorio;
            //}


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoPedido");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_I_PedidoVenda";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@TmpPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@TmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQ;

            loSqlCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPedidoVendaSEQ"].Direction = ParameterDirection.Output;

            loSqlCommand.ExecuteNonQuery();

            cdPedidoVendaSEQ = Convert.ToInt64(loSqlCommand.Parameters["@cdPedidoVendaSEQ"].Value);

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoPedido");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string SalvaPedidoAlteracao(Int64 cdUsuarioUltimaAlteracao, Int64 tmpPedidoVendaSEQ, Int64 cdPedidoVendaSEQ)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;



            //Consistências
            //if (cdAgenteComercialCooperativaPedidoVenda == 0)
            //{
            //    return "Agente Comercial Cooperativa" + moPadrao.MensagemObrigatorio;
            //}


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoPedido");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_U_PedidoVenda";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@TmpPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@TmpPedidoVendaSEQ"].Value = tmpPedidoVendaSEQ;

            loSqlCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPedidoVendaSEQ"].Value = cdPedidoVendaSEQ;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoPedido");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public DataTable ObterListaPedidoVenda(Int64 cdAgenteComercialCooperativaPedidoVenda, Int64 cdCronogramaSafraSEQ, Int64 cdClienteFaturamentoPedidoVenda, Int64 cdClienteEntregaPedidoVenda, Int64 cdIndicadorMoedaPedidoVenda, Int64 cdPedidoVendaSEQ, Int64 cdIndicadorStatusPedidoVenda, Int64 cdPessoaOrigemFaturamento, Int64 cdTipoPedido)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PedidoVenda", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            if (cdAgenteComercialCooperativaPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialCooperativaPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialCooperativaPedidoVenda"].Value = cdAgenteComercialCooperativaPedidoVenda;
            }

            if (cdPessoaOrigemFaturamento != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaOrigemFaturamento", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaOrigemFaturamento"].Value = cdPessoaOrigemFaturamento;
            }

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            if (cdClienteFaturamentoPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdClienteFaturamentoPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdClienteFaturamentoPedidoVenda"].Value = cdClienteFaturamentoPedidoVenda;
            }

            if (cdClienteEntregaPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdClienteEntregaPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdClienteEntregaPedidoVenda"].Value = cdClienteEntregaPedidoVenda;
            }

            if (cdIndicadorMoedaPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorMoedaPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorMoedaPedidoVenda"].Value = cdIndicadorMoedaPedidoVenda;
            }

            if (cdPedidoVendaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPedidoVendaSEQ"].Value = cdPedidoVendaSEQ;
            }

            if (cdIndicadorStatusPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorStatusPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorStatusPedidoVenda"].Value = cdIndicadorStatusPedidoVenda;
            }

            if (cdTipoPedido != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdTipoPedidoVenda", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdTipoPedidoVenda"].Value = cdTipoPedido;
            }

            

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaPedidoVendaLiberacaoCCAB(Int64 cdAgenteComercialCooperativaPedidoVenda, Int64 cdCronogramaSafraSEQ, Int64 cdClienteFaturamentoPedidoVenda, Int64 cdClienteEntregaPedidoVenda, Int64 cdIndicadorMoedaPedidoVenda, Int64 cdPedidoVendaSEQ, Int64 cdPessoaOrigemFaturamento, Int64 cdTipoPedido)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PedidoVendaLiberacaoCCAB", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            if (cdAgenteComercialCooperativaPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialCooperativaPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialCooperativaPedidoVenda"].Value = cdAgenteComercialCooperativaPedidoVenda;
            }

            if (cdPessoaOrigemFaturamento != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaOrigemFaturamento", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaOrigemFaturamento"].Value = cdPessoaOrigemFaturamento;
            }

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            if (cdClienteFaturamentoPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdClienteFaturamentoPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdClienteFaturamentoPedidoVenda"].Value = cdClienteFaturamentoPedidoVenda;
            }

            if (cdClienteEntregaPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdClienteEntregaPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdClienteEntregaPedidoVenda"].Value = cdClienteEntregaPedidoVenda;
            }

            if (cdIndicadorMoedaPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorMoedaPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorMoedaPedidoVenda"].Value = cdIndicadorMoedaPedidoVenda;
            }

            if (cdPedidoVendaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPedidoVendaSEQ"].Value = cdPedidoVendaSEQ;
            }

            if (cdTipoPedido != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdTipoPedidoVenda", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdTipoPedidoVenda"].Value = cdTipoPedido;
            }

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaPedidoVendaExclusao(Int64 cdAgenteComercialCooperativaPedidoVenda, Int64 cdCronogramaSafraSEQ, Int64 cdClienteFaturamentoPedidoVenda, Int64 cdClienteEntregaPedidoVenda, Int64 cdIndicadorMoedaPedidoVenda, Int64 cdPedidoVendaSEQ, Int64 cdPessoaOrigemFaturamento)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PedidoVendaExclusao", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            if (cdAgenteComercialCooperativaPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialCooperativaPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialCooperativaPedidoVenda"].Value = cdAgenteComercialCooperativaPedidoVenda;
            }

            if (cdPessoaOrigemFaturamento != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaOrigemFaturamento", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaOrigemFaturamento"].Value = cdPessoaOrigemFaturamento;
            }

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            if (cdClienteFaturamentoPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdClienteFaturamentoPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdClienteFaturamentoPedidoVenda"].Value = cdClienteFaturamentoPedidoVenda;
            }

            if (cdClienteEntregaPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdClienteEntregaPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdClienteEntregaPedidoVenda"].Value = cdClienteEntregaPedidoVenda;
            }

            if (cdIndicadorMoedaPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorMoedaPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorMoedaPedidoVenda"].Value = cdIndicadorMoedaPedidoVenda;
            }

            if (cdPedidoVendaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPedidoVendaSEQ"].Value = cdPedidoVendaSEQ;
            }

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaPedidoVendaAprovacao(Int64 cdAgenteComercialCooperativaPedidoVenda, Int64 cdCronogramaSafraSEQ, Int64 cdClienteFaturamentoPedidoVenda, Int64 cdClienteEntregaPedidoVenda, Int64 cdIndicadorMoedaPedidoVenda, Int64 cdPedidoVendaSEQ, Int64 cdPessoaOrigemFaturamento, Int64 cdTipoPedido)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PedidoVendaAprovacao", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            if (cdAgenteComercialCooperativaPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialCooperativaPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialCooperativaPedidoVenda"].Value = cdAgenteComercialCooperativaPedidoVenda;
            }

            if (cdPessoaOrigemFaturamento != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaOrigemFaturamento", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaOrigemFaturamento"].Value = cdPessoaOrigemFaturamento;
            }

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            if (cdClienteFaturamentoPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdClienteFaturamentoPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdClienteFaturamentoPedidoVenda"].Value = cdClienteFaturamentoPedidoVenda;
            }

            if (cdClienteEntregaPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdClienteEntregaPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdClienteEntregaPedidoVenda"].Value = cdClienteEntregaPedidoVenda;
            }

            if (cdIndicadorMoedaPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorMoedaPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorMoedaPedidoVenda"].Value = cdIndicadorMoedaPedidoVenda;
            }

            if (cdPedidoVendaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPedidoVendaSEQ"].Value = cdPedidoVendaSEQ;
            }

            if (cdTipoPedido != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdTipoPedidoVenda", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdTipoPedidoVenda"].Value = cdTipoPedido;
            }

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaPedidoVendaLiberacaoMicrosiga(Int64 cdAgenteComercialCooperativaPedidoVenda, Int64 cdCronogramaSafraSEQ, Int64 cdClienteFaturamentoPedidoVenda, Int64 cdClienteEntregaPedidoVenda, Int64 cdIndicadorMoedaPedidoVenda, Int64 cdPedidoVendaSEQ, Int64 cdPessoaOrigemFaturamento, Int64 cdTipoPedido)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PedidoVendaLiberacaoMicrosiga", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            if (cdAgenteComercialCooperativaPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialCooperativaPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialCooperativaPedidoVenda"].Value = cdAgenteComercialCooperativaPedidoVenda;
            }

            if (cdPessoaOrigemFaturamento != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaOrigemFaturamento", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaOrigemFaturamento"].Value = cdPessoaOrigemFaturamento;
            }

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            if (cdClienteFaturamentoPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdClienteFaturamentoPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdClienteFaturamentoPedidoVenda"].Value = cdClienteFaturamentoPedidoVenda;
            }

            if (cdClienteEntregaPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdClienteEntregaPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdClienteEntregaPedidoVenda"].Value = cdClienteEntregaPedidoVenda;
            }

            if (cdIndicadorMoedaPedidoVenda != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorMoedaPedidoVenda", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorMoedaPedidoVenda"].Value = cdIndicadorMoedaPedidoVenda;
            }

            if (cdPedidoVendaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPedidoVendaSEQ"].Value = cdPedidoVendaSEQ;
            }

            if (cdTipoPedido != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdTipoPedidoVenda", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdTipoPedidoVenda"].Value = cdTipoPedido;
            }

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public string LiberaPedidoCCAB(Int64 cdUsuarioUltimaAlteracao, string arPedidoVenda)
    {
        SqlTransaction loSqlTransaction = null;

        //Consistencias
        //

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoLiberaPedidoCCAB");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_LiberaPedidoCCAB";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@arPedidoVenda", SqlDbType.VarChar);
            loSqlCommand.Parameters["@arPedidoVenda"].Value = arPedidoVenda;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = moUsuario.cdUsuario;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoLiberaPedidoCCAB");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public string LiberaPedidoMicrosiga(Int64 cdUsuarioUltimaAlteracao, string arPedidoVenda)
    {
        //string Retorno;
        SqlTransaction loSqlTransaction = null;

        //Consistencias
        //

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoLiberaPedidoMicrosiga");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_LiberaPedidoMicrosiga";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@arPedidoVenda", SqlDbType.VarChar);
            loSqlCommand.Parameters["@arPedidoVenda"].Value = arPedidoVenda;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = moUsuario.cdUsuario;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;


            //Retorno = InserirPedidoMicrosiga(arPedidoVenda);
            //if (Retorno != "")
            //{
            //    return Retorno;
            //}

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoLiberaPedidoMicrosiga");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public string AprovaPedidoCCAB(Int64 cdUsuarioUltimaAlteracao, string arPedidoVenda)
    {
        SqlTransaction loSqlTransaction = null;

        //Consistencias
        //

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoAprovaPedidoCCAB");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_AprovaPedidoVenda";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@arPedidoVenda", SqlDbType.VarChar);
            loSqlCommand.Parameters["@arPedidoVenda"].Value = arPedidoVenda;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = moUsuario.cdUsuario;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoAprovaPedidoCCAB");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public string RejeitarPedidoCCAB(Int64 cdUsuarioUltimaAlteracao, string arPedidoVenda)
    {
        SqlTransaction loSqlTransaction = null;

        //Consistencias
        //

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoAprovaPedidoCCAB");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_RejeitaPedidoVenda";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@arPedidoVenda", SqlDbType.VarChar);
            loSqlCommand.Parameters["@arPedidoVenda"].Value = arPedidoVenda;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = moUsuario.cdUsuario;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoAprovaPedidoCCAB");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public string ExcluiPedidoVenda(Int64 cdUsuarioUltimaAlteracao, string arPedidoVenda)
    {
        SqlTransaction loSqlTransaction = null;

        //Consistencias
        //

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoExcluiPedidoVenda");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_D_ExcluiPedidoVenda";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@arPedidoVenda", SqlDbType.VarChar);
            loSqlCommand.Parameters["@arPedidoVenda"].Value = arPedidoVenda;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = moUsuario.cdUsuario;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoExcluiPedidoVenda");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    private bool VerificaDisponibilidadeCompromisso(Int64 cdAgenteComercialCooperativaPedidoVenda, Int64 cdCronogramaSafraSEQ, Int64 cdIndicadorMoedaPedidoVenda, Int64 cdPessoaOrigemFaturamento, Int64 cdTipoProduto)
    {

        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_VerificaDisponibilidadeCompromissoPedidoVenda", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialCooperativaPedidoVenda", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialCooperativaPedidoVenda"].Value = cdAgenteComercialCooperativaPedidoVenda;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorMoedaPedidoVenda", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorMoedaPedidoVenda"].Value = cdIndicadorMoedaPedidoVenda;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaOrigemFaturamento", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaOrigemFaturamento"].Value = cdPessoaOrigemFaturamento;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdTipoProduto", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdTipoProduto"].Value = cdTipoProduto;

        loSqlDataAdapter.Fill(loDataTable);

        loSqlConnection.Close();
        loSqlConnection = null;

        if (loDataTable.Rows.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }

    }

    private bool VerificaDisponibilidadePedido(Int64 cdAgenteComercialCooperativaPedidoVenda, Int64 cdClienteFaturamentoPedidoVenda, Int64 cdClienteEntregaPedidoVenda, Int64 cdPessoaOrigemFaturamento, Int64 cdCronogramaSafraSEQ, Int64 cdIndicadorMoedaPedidoVenda, Int64 cdPedidoVendaSEQ)
    {
        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_VerificaDisponibilidadePedidoVenda", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialCooperativaPedidoVenda", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialCooperativaPedidoVenda"].Value = cdAgenteComercialCooperativaPedidoVenda;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdClienteFaturamentoPedidoVenda", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdClienteFaturamentoPedidoVenda"].Value = cdClienteFaturamentoPedidoVenda;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdClienteEntregaPedidoVenda", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdClienteEntregaPedidoVenda"].Value = cdClienteEntregaPedidoVenda;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaOrigemFaturamento", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaOrigemFaturamento"].Value = cdPessoaOrigemFaturamento;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorMoedaPedidoVenda", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorMoedaPedidoVenda"].Value = cdIndicadorMoedaPedidoVenda;

        if (cdPedidoVendaSEQ == 0)
        {
            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdPedidoVendaSEQ"].Value = 0; //Inclusão
        }
        else
        {
            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdPedidoVendaSEQ"].Value = cdPedidoVendaSEQ; //Alteração
        }

        loSqlDataAdapter.Fill(loDataTable);

        loSqlConnection.Close();
        loSqlConnection = null;

        if (loDataTable.Rows.Count > 0)
        {
            return false;
        }
        else
        {
            return true;
        }

    }

    private bool VerificaEstadoLocalEntrega(Int64 cdClienteFaturamentoPedidoVenda, Int64 cdClienteEntregaPedidoVenda)
    {

        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_VerificaEstadoLocalEntregaPedidoVenda", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdClienteFaturamentoPedidoVenda", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdClienteFaturamentoPedidoVenda"].Value = cdClienteFaturamentoPedidoVenda;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdClienteEntregaPedidoVenda", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdClienteEntregaPedidoVenda"].Value = cdClienteEntregaPedidoVenda;

        loSqlDataAdapter.Fill(loDataTable);

        loSqlConnection.Close();
        loSqlConnection = null;

        if (loDataTable.Rows.Count > 0)
        {
            return false;
        }
        else
        {
            return true;
        }

    }

    public string InserirPedidoMicrosiga()
    {

        string Retorno;


        WSPedidoMicrosiga.CABEC_PV loCABEC_PV;
        WSPedidoMicrosiga.ITEM_PV loITEM_PV;
        List<WSPedidoMicrosiga.ITEM_PV> loITEM_PVArray;

        WSPedidoMicrosiga.PEDIDO_VENDA loPEDIDO_VENDA;

        WSPedidoMicrosiga.PEDIDO loPedido;
                
        Int64 cdPedidoVendaSEQ = 0;
        string CONDPAG = "";
        string EMISSAO = "";
        string MOEDA = "";
        string XCLIENT = "";
        string XCLIFAT = "";
        string XLOJAENT = "";
        string XLOJAFAT = "";
        string XTPPED = "";


        Int64 cdPedidoVendaERPSEQ  = 0;
        string DATA1 = "";                          
        string NUMSFA = "";
        string PARC1 = "";


        string ENTREG = "";                          
        string ITEMSFA = "";               
        float PRCVEN = 0;                                   
        string PRODUTO = "";
        float QTDVEN = 0; 

        DataTable loDataTable;
        DataTable loDataTableERP;
        DataTable loDataTableERPItem;

        try
        {

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PedidoVenda_Microsiga", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            //loSqlDataAdapter.SelectCommand.Parameters.Add("@arPedidoVenda", SqlDbType.VarChar);
            //loSqlDataAdapter.SelectCommand.Parameters["@arPedidoVenda"].Value = arPedidoVenda;

            loDataTable = new DataTable();
            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;


            foreach (DataRow loDataRow in loDataTable.Rows)
            {


                cdPedidoVendaSEQ = Convert.ToInt64(loDataRow["cdPedidoVendaSEQ"]);
                EMISSAO = loDataRow["EMISSAO"].ToString();
                MOEDA = loDataRow["MOEDA"].ToString();
                XCLIENT = loDataRow["XCLIENT"].ToString();
                XCLIFAT = loDataRow["XCLIFAT"].ToString();
                XLOJAENT = loDataRow["XLOJAENT"].ToString();
                XLOJAFAT = loDataRow["XLOJAFAT"].ToString();
                XTPPED = loDataRow["XTPPED"].ToString();


                //Setar para 8, somente o cabeçalho
                Retorno = MarcarMicroSiga(cdPedidoVendaSEQ);
                if (Retorno != "")
                {
                    return Retorno;
                }

                SqlConnection loSqlConnectionERP = new SqlConnection(msStringConexao);
                SqlDataAdapter loSqlDataAdapterERP = new SqlDataAdapter("SP_G_PedidoVendaERP_Microsiga", loSqlConnectionERP);

                SqlCommand loSqlCommandERP = loSqlConnectionERP.CreateCommand();

                loSqlDataAdapterERP.SelectCommand.CommandType = CommandType.StoredProcedure;

                loSqlDataAdapterERP.SelectCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
                loSqlDataAdapterERP.SelectCommand.Parameters["@cdPedidoVendaSEQ"].Value = cdPedidoVendaSEQ;

                loDataTableERP = new DataTable();
                loSqlDataAdapterERP.Fill(loDataTableERP);

                loSqlConnectionERP.Close();
                loSqlConnectionERP = null;


                foreach (DataRow loDataRowERP in loDataTableERP.Rows)
                {
                    cdPedidoVendaERPSEQ = Convert.ToInt64(loDataRowERP["cdPedidoVendaERPSEQ"]);
                    DATA1 = loDataRowERP["DATA1"].ToString();
                    NUMSFA = loDataRowERP["NUMSFA"].ToString();
                    PARC1 = loDataRowERP["PARC1"].ToString().Replace(",",".");
                    CONDPAG = loDataRowERP["CONDPAG"].ToString();

                    loCABEC_PV = new WSPedidoMicrosiga.CABEC_PV();

                    loCABEC_PV.CONDPAG = CONDPAG;
                    loCABEC_PV.DATA1 = DATA1;
                    loCABEC_PV.DATA2 = "";
                    loCABEC_PV.DATA3 = "";
                    loCABEC_PV.DATA4 = "";
                    loCABEC_PV.DATA5 = "";
                    loCABEC_PV.DATA6 = "";
                    loCABEC_PV.EMISSAO = EMISSAO;
                    loCABEC_PV.ESPECI1 = "VOLUMES";
                    loCABEC_PV.MOEDA = Convert.ToInt32(MOEDA);
                    loCABEC_PV.NUMSFA = Convert.ToInt64(NUMSFA);
                    loCABEC_PV.PARC1 = 0;
                    loCABEC_PV.PARC2 = 0;
                    loCABEC_PV.PARC3 = 0;
                    loCABEC_PV.PARC4 = 0;
                    loCABEC_PV.PARC5 = 0;
                    loCABEC_PV.PARC6 = 0;
                    loCABEC_PV.TABELA = "001";
                    loCABEC_PV.VEND1 = "";
                    loCABEC_PV.VEND2 = "";
                    loCABEC_PV.VEND3 = "";
                    loCABEC_PV.VEND4 = "";
                    loCABEC_PV.VEND5 = "";
                    loCABEC_PV.VOLUME1 = 0;
                    loCABEC_PV.XCLIENT = XCLIENT;
                    loCABEC_PV.XCLIFAT = XCLIFAT;
                    loCABEC_PV.XHISTCO = "GERADO A PARTIR DO PORTAL";
                    loCABEC_PV.XLOJAENT = XLOJAENT;
                    loCABEC_PV.XLOJAFAT = XLOJAFAT;
                    loCABEC_PV.XOBSERV = "GERADO A PARTIR DO PORTAL";
                    loCABEC_PV.XTPPED = "3";


                    loITEM_PVArray = new List<WSPedidoMicrosiga.ITEM_PV>();
                    loPEDIDO_VENDA = new WSPedidoMicrosiga.PEDIDO_VENDA();
                    loPedido = new WSPedidoMicrosiga.PEDIDO();

                    SqlConnection loSqlConnectionERPItem = new SqlConnection(msStringConexao);
                    SqlDataAdapter loSqlDataAdapterERPItem = new SqlDataAdapter("SP_G_PedidoVendaERPItem_Microsiga", loSqlConnectionERPItem);

                    SqlCommand loSqlCommandERPItem = loSqlConnectionERPItem.CreateCommand();

                    loSqlDataAdapterERPItem.SelectCommand.CommandType = CommandType.StoredProcedure;

                    loSqlDataAdapterERPItem.SelectCommand.Parameters.Add("@cdPedidoVendaERPSEQ", SqlDbType.BigInt);
                    loSqlDataAdapterERPItem.SelectCommand.Parameters["@cdPedidoVendaERPSEQ"].Value = cdPedidoVendaERPSEQ;

                    loDataTableERPItem = new DataTable();
                    loSqlDataAdapterERPItem.Fill(loDataTableERPItem);

                    loSqlConnectionERPItem.Close();
                    loSqlConnectionERPItem = null;


                    foreach (DataRow loDataRowERPItem in loDataTableERPItem.Rows)
                    {

                        ENTREG = loDataRowERPItem["ENTREG"].ToString();
                        ITEMSFA = loDataRowERPItem["ITEMSFA"].ToString();
                        PRCVEN = Convert.ToSingle(loDataRowERPItem["PRCVEN"]);
                        PRODUTO = loDataRowERPItem["PRODUTO"].ToString();
                        QTDVEN = Convert.ToSingle(loDataRowERPItem["QTDVEN"]);

                        

                        loITEM_PV = new WSPedidoMicrosiga.ITEM_PV();

                        loITEM_PV.ENTREG = ENTREG;
                        loITEM_PV.ITEMSFA = Convert.ToInt64(ITEMSFA);
                        loITEM_PV.NUMSFA = Convert.ToInt64(NUMSFA);
                        loITEM_PV.PRCVEN = PRCVEN;
                        loITEM_PV.PRODUTO = PRODUTO;
                        loITEM_PV.QTDVEN = QTDVEN;

                        loITEM_PVArray.Add(loITEM_PV);

                        
                    }

                    loPEDIDO_VENDA.CABECPV = loCABEC_PV;
                    loPEDIDO_VENDA.AITEMPV = loITEM_PVArray.ToArray();

                    Retorno = AcessarWSMicrosiga(loPedido, loPEDIDO_VENDA, cdPedidoVendaERPSEQ, cdPedidoVendaSEQ);
                    if (Retorno != "")
                    {
                        return Retorno;
                    }

                    

                    
                }


            }

            return "";
        }
        catch (Exception loException)
        {
            return loException.Message;
        }




    }


    private string MarcarMicroSiga(Int64 cdPedidoVendaSEQ)
    {
        //Marca como 8
        try
        {
            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();

            loSqlCommand.Connection = loSqlConnection;

            loSqlCommand.CommandText = "SP_U_PedidoVenda_MicrosigaEnviado";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPedidoVendaSEQ"].Value = cdPedidoVendaSEQ;


            loSqlCommand.ExecuteNonQuery();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            return loException.Message;
        }

    }


    private string AcessarWSMicrosiga(WSPedidoMicrosiga.PEDIDO loPedido, WSPedidoMicrosiga.PEDIDO_VENDA loPEDIDO_VENDA, Int64 cdPedidoVendaERPSEQ, Int64 cdPedidoVendaSEQ)
    {
        string Retorno = "";
        SqlTransaction loSqlTransaction = null;

        string Erro = "";

        try
        {
            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("PedidoMicrosiga");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_PedidoVendaERP_Microsiga";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            try
            {
                
                Retorno = loPedido.INCLUSAO(loPEDIDO_VENDA);

                loSqlCommand.Parameters.Add("@cdIndicadorStatus", SqlDbType.Int);
                loSqlCommand.Parameters["@cdIndicadorStatus"].Value = 6;

            }
            catch (Exception loException)
            {

                Erro = loException.Message;
                
                loSqlCommand.Parameters.Add("@cdIndicadorStatus", SqlDbType.Int);
                loSqlCommand.Parameters["@cdIndicadorStatus"].Value = 7;

            }
            
            loSqlCommand.Parameters.Add("@cdPedidoVendaERPSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPedidoVendaERPSEQ"].Value = cdPedidoVendaERPSEQ;

            loSqlCommand.Parameters.Add("@cdPedidoVendaERP", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@cdPedidoVendaERP"].Value = Retorno;

            loSqlCommand.Parameters.Add("@cdPedidoVendaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPedidoVendaSEQ"].Value = cdPedidoVendaSEQ;
            

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("PedidoMicrosiga");


            //Gravo como erro
            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();

            loSqlCommand.Connection = loSqlConnection;

            loSqlCommand.CommandText = "SP_U_PedidoVendaERP_Microsiga";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdIndicadorStatus", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorStatus"].Value = 7;

            loSqlCommand.Parameters.Add("@cdPedidoVendaERPSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPedidoVendaERPSEQ"].Value = cdPedidoVendaERPSEQ;

            loSqlCommand.Parameters.Add("@cdPedidoVendaERP", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@cdPedidoVendaERP"].Value = "";

            loSqlCommand.ExecuteNonQuery();

            loSqlConnection.Close();
            loSqlConnection = null;


            return loException.Message;
        }

    }




    #endregion Métodos
}
