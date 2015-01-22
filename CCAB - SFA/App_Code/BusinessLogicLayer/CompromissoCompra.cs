using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;


/// <summary>
/// Summary description for CompromissoCompra
/// </summary>
public class CompromissoCompra
{

    #region Propriedades

    public Int64 tmpCompromissoCompraSEQ { get; set; }
    public Int64 cdCompromissoCompraSEQ { get; set; }

    #endregion Propriedades

    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares

	public CompromissoCompra()
	{
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
    }

    #region Métodos

    public string IncluirTmp_Inclusao(Int64 cdAgenteComercialCooperativaCompromissoCompra, Int64 cdCronogramaSafraSEQ, Int32 cdIndicadorMoedaCompromissoCompra, Int64 cdUsuarioUltimaAlteracao, Int64 cdPessoaOrigemFaturamento)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            //Consistências
            if (cdAgenteComercialCooperativaCompromissoCompra == 0)
            {
                return "Agente Comercial Cooperativa" + moPadrao.MensagemObrigatorio;
            }

            if (cdCronogramaSafraSEQ == 0)
            {
                return "Cronograma Safra" + moPadrao.MensagemObrigatorio;
            }

            if (cdIndicadorMoedaCompromissoCompra == 0)
            {
                return "Moeda" + moPadrao.MensagemObrigatorio;
            }

            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }

            if (cdPessoaOrigemFaturamento == 0)
            {
                return "Origem Faturamento" + moPadrao.MensagemObrigatorio;
            }

            // Verifica se já tem algum compromisso de compra cadastrado com os parametros informados
            bool lbDisponivel = true;
            lbDisponivel = VerificaDisponibilidadeCompromisso(cdAgenteComercialCooperativaCompromissoCompra,cdCronogramaSafraSEQ,cdIndicadorMoedaCompromissoCompra,cdPessoaOrigemFaturamento);
            if (lbDisponivel == false)
            {
                return "Compromisso de Compra já cadastrado para os parâmetros informados";

            }

            // Verifica se há tabela de preco cadastrada para os parametros informados
            lbDisponivel = VerificaTabelaPrecoCompromisso(cdAgenteComercialCooperativaCompromissoCompra, cdCronogramaSafraSEQ, cdIndicadorMoedaCompromissoCompra);
            if (lbDisponivel == false)
            {
                return "Não Há Tabela de  Preço cadastrada para os parâmetros informados";

            }

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoCompromissoCompra");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_I_tmpCompromissoCompra_Inclusao";
            loSqlCommand.CommandType = CommandType.StoredProcedure;
            
            loSqlCommand.Parameters.Add("@cdAgenteComercialCooperativaCompromissoCompra", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdAgenteComercialCooperativaCompromissoCompra"].Value = cdAgenteComercialCooperativaCompromissoCompra;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            loSqlCommand.Parameters.Add("@cdIndicadorMoedaCompromissoCompra", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorMoedaCompromissoCompra"].Value = cdIndicadorMoedaCompromissoCompra;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.Parameters.Add("@cdPessoaOrigemFaturamento", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaOrigemFaturamento"].Value = cdPessoaOrigemFaturamento;

            loSqlCommand.Parameters.Add("@tmpCompromissoCompraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@tmpCompromissoCompraSEQ"].Direction = ParameterDirection.Output;

            loSqlCommand.ExecuteNonQuery();

            tmpCompromissoCompraSEQ = Convert.ToInt64(loSqlCommand.Parameters["@tmpCompromissoCompraSEQ"].Value);

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoCompromissoCompra");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string IncluirTmp_Alteracao(Int64 cdCompromissoCompraAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            //Consistências
            if (cdCompromissoCompraAlteracao == 0)
            {
                return "Código do Compromisso não informado !!!" + moPadrao.MensagemObrigatorio;
            }

            cdCompromissoCompraSEQ = cdCompromissoCompraAlteracao;

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoCompromissoCompra");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_I_tmpCompromissoCompra_Alteracao";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdCompromissoCompraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCompromissoCompraSEQ"].Value = cdCompromissoCompraSEQ;

            loSqlCommand.Parameters.Add("@tmpCompromissoCompraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@tmpCompromissoCompraSEQ"].Direction = ParameterDirection.Output;

            loSqlCommand.ExecuteNonQuery();

            tmpCompromissoCompraSEQ = Convert.ToInt64(loSqlCommand.Parameters["@tmpCompromissoCompraSEQ"].Value);

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoCompromissoCompra");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string ExcluirTmp(Int64 tmpCompromissoCompraSEQ)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoCompromissoCompra");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_D_tmpCompromissoCompra";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@tmpCompromissoCompraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@tmpCompromissoCompraSEQ"].Value = tmpCompromissoCompraSEQ;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoCompromissoCompra");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroExclusao;
        }
    }

    public DataTable ObterListaGeral(Int64 tmpCompromissoCompraSEQ, Int64 cdIndicadorMoedaCompromissoCompra)
    {

        try
        {

            if (cdIndicadorMoedaCompromissoCompra == 1) //Real
            {

                DataTable loDataTable = new DataTable();
                SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
                SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CompromissoCompraItemReal_Geral", loSqlConnection);
                SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

                loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                loSqlDataAdapter.SelectCommand.Parameters.Add("@tmpCompromissoCompraSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@tmpCompromissoCompraSEQ"].Value = tmpCompromissoCompraSEQ;

                loSqlDataAdapter.Fill(loDataTable);

                loSqlConnection.Close();
                loSqlConnection = null;

                return loDataTable;
            }

            else

            {

                DataTable loDataTable = new DataTable();
                SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
                SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CompromissoCompraItemDolar_Geral", loSqlConnection);
                SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

                loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                loSqlDataAdapter.SelectCommand.Parameters.Add("@tmpCompromissoCompraSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@tmpCompromissoCompraSEQ"].Value = tmpCompromissoCompraSEQ;

                loSqlDataAdapter.Fill(loDataTable);

                loSqlConnection.Close();
                loSqlConnection = null;

                return loDataTable;

            }

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }
    
    public DataTable ObterMoeda(Int64 cdAgenteComercialCooperativaCompromissoCompra, Int64 cdCronogramaSafraSEQ, Int64 cdPessoaOrigemFaturamento)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_CompromissoCompra_Moeda", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialCooperativaCompromissoCompra", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialCooperativaCompromissoCompra"].Value = cdAgenteComercialCooperativaCompromissoCompra;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaOrigemFaturamento", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaOrigemFaturamento"].Value = cdPessoaOrigemFaturamento;

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

    public DataTable ObterValorTotalCompromissoTMP(Int64 @tmpCompromissoCompraSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CompromissoCompraValorTotal_TMP", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@tmpCompromissoCompraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@tmpCompromissoCompraSEQ"].Value = tmpCompromissoCompraSEQ;

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

    public string SalvarTmp(ListItemCollection lsLista, Int64 cdUsuarioUltimaAlteracao, Int64 cdAgenteComercialCooperativaCompromissoCompra, Int64 cdCronogramaSafraSEQ)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            string lsValue;
            string lsText;
            string[] lsArray;


            Int64 tmpCompromissoCompraItemSEQ;
            Int64 tmpCompromissoCompraSEQ;
            Int64 cdProdutoSEQ;
            Int64 cdCronogramaSafraVencimentoSEQ;
            decimal qtCompromissoCompraItem;
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
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoCompromissoCompra");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            foreach (ListItem itItem in lsLista)
            {
                lsValue = itItem.Value;
                lsText = itItem.Text;

                lsArray = lsText.Split(new char[] { '-' });

                cdGravacao = lsArray[0].ToString();

                tmpCompromissoCompraItemSEQ = Convert.ToInt64(lsArray[1].ToString());
                tmpCompromissoCompraSEQ = Convert.ToInt64(lsArray[2].ToString());
                cdProdutoSEQ = Convert.ToInt64(lsArray[3].ToString());
                cdCronogramaSafraVencimentoSEQ = Convert.ToInt64(lsArray[5].ToString());

                qtCompromissoCompraItem = Convert.ToDecimal(lsValue);


                if (cdGravacao == "X")
                {

                    loSqlCommand.Parameters.Clear();

                    if (tmpCompromissoCompraItemSEQ == 0) //Inclusão
                    {
                        loSqlCommand.CommandText = "SP_I_tmpCompromissoCompraItem";
                        loSqlCommand.CommandType = CommandType.StoredProcedure;

                        loSqlCommand.Parameters.Add("@tmpCompromissoCompraSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@tmpCompromissoCompraSEQ"].Value = tmpCompromissoCompraSEQ;

                        loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

                        loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

                        loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

                        loSqlCommand.Parameters.Add("@qtCompromissoCompraItem", SqlDbType.Float);
                        loSqlCommand.Parameters["@qtCompromissoCompraItem"].Value = qtCompromissoCompraItem;

                        loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

                        loSqlCommand.Parameters.Add("@cdAgenteComercialCooperativaCompromissoCompra", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdAgenteComercialCooperativaCompromissoCompra"].Value = cdAgenteComercialCooperativaCompromissoCompra;

                        loSqlCommand.Parameters.Add("@tmpCompromissoCompraItemSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@tmpCompromissoCompraItemSEQ"].Direction = ParameterDirection.Output;


                    }
                    else //Alteração
                    {
                        loSqlCommand.CommandText = "SP_U_tmpCompromissoCompraItem";
                        loSqlCommand.CommandType = CommandType.StoredProcedure;


                        loSqlCommand.Parameters.Add("@tmpCompromissoCompraItemSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@tmpCompromissoCompraItemSEQ"].Value = tmpCompromissoCompraItemSEQ;

                        loSqlCommand.Parameters.Add("@tmpCompromissoCompraSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@tmpCompromissoCompraSEQ"].Value = tmpCompromissoCompraSEQ;

                        loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

                        loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

                        loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

                        loSqlCommand.Parameters.Add("@qtCompromissoCompraItem", SqlDbType.Float);
                        loSqlCommand.Parameters["@qtCompromissoCompraItem"].Value = qtCompromissoCompraItem;

                        loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

                    }

                    loSqlCommand.ExecuteNonQuery();

                }


            }



            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoCompromissoCompra");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public DataTable ObterResumoVencimentoTMP(Int64 @tmpCompromissoCompraSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CompromissoCompraResumoVencimento_TMP", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@tmpCompromissoCompraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@tmpCompromissoCompraSEQ"].Value = tmpCompromissoCompraSEQ;

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

    public DataTable ObterResumoDadosTMP(Int64 @tmpCompromissoCompraSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CompromissoCompraResumoDados_TMP", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@tmpCompromissoCompraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@tmpCompromissoCompraSEQ"].Value = tmpCompromissoCompraSEQ;

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

    public string SalvaCompromissoInclusao(Int64 tmpCompromissoCompraSEQ, Int64 cdUsuarioUltimaAlteracao)
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
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoCompromisso");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_I_CompromissoCompra";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@TmpCompromissoCompraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@TmpCompromissoCompraSEQ"].Value = tmpCompromissoCompraSEQ;

            loSqlCommand.Parameters.Add("@cdCompromissoCompraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCompromissoCompraSEQ"].Direction = ParameterDirection.Output;

            loSqlCommand.ExecuteNonQuery();

            cdCompromissoCompraSEQ = Convert.ToInt64(loSqlCommand.Parameters["@cdCompromissoCompraSEQ"].Value);

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoCompromisso");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public DataTable ObterListaCompromissoCompra(Int64 cdAgenteComercialCooperativaCompromissoCompra, Int64 cdCronogramaSafraSEQ, Int64 cdIndicadorMoedaCompromissoCompra, Int64 cdCompromissoCompraSEQ, Int64 cdIndicadorStatusCompromissoCompra, Int64 cdPessoaOrigemFaturamento)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CompromissoCompra", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            if (cdAgenteComercialCooperativaCompromissoCompra != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialCooperativaCompromissoCompra", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialCooperativaCompromissoCompra"].Value = cdAgenteComercialCooperativaCompromissoCompra;
            }

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            if (cdIndicadorMoedaCompromissoCompra != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorMoedaCompromissoCompra", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorMoedaCompromissoCompra"].Value = cdIndicadorMoedaCompromissoCompra;
            }

            if (cdCompromissoCompraSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCompromissoCompraSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdCompromissoCompraSEQ"].Value = cdCompromissoCompraSEQ;
            }

            if (cdIndicadorStatusCompromissoCompra != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorStatusCompromissoCompra", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorStatusCompromissoCompra"].Value = cdIndicadorStatusCompromissoCompra;
            }

            if (cdPessoaOrigemFaturamento != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaOrigemFaturamento", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaOrigemFaturamento"].Value = cdPessoaOrigemFaturamento;
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

    public DataTable ObterListaCompromissoCompraExclusao(Int64 cdAgenteComercialCooperativaCompromissoCompra, Int64 cdCronogramaSafraSEQ, Int64 cdIndicadorMoedaCompromissoCompra, Int64 cdCompromissoCompraSEQ, Int64 cdPessoaOrigemFaturamento)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CompromissoCompraExclusao", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            if (cdAgenteComercialCooperativaCompromissoCompra != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialCooperativaCompromissoCompra", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialCooperativaCompromissoCompra"].Value = cdAgenteComercialCooperativaCompromissoCompra;
            }

            if (cdPessoaOrigemFaturamento != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaOrigemFaturamento", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaOrigemFaturamento"].Value = cdPessoaOrigemFaturamento;
            }

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            if (cdIndicadorMoedaCompromissoCompra != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorMoedaCompromissoCompra", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorMoedaCompromissoCompra"].Value = cdIndicadorMoedaCompromissoCompra;
            }

            if (cdCompromissoCompraSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCompromissoCompraSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdCompromissoCompraSEQ"].Value = cdCompromissoCompraSEQ;
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

    public DataTable ObterListaCompromissoCompraLiberacao(Int64 cdAgenteComercialCooperativaCompromissoCompra, Int64 cdCronogramaSafraSEQ, Int64 cdIndicadorMoedaCompromissoCompra, Int64 cdCompromissoCompraSEQ, Int64 cdPessoaOrigemFaturamento)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CompromissoCompraLiberacao", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            if (cdAgenteComercialCooperativaCompromissoCompra != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialCooperativaCompromissoCompra", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialCooperativaCompromissoCompra"].Value = cdAgenteComercialCooperativaCompromissoCompra;
            }

            if (cdPessoaOrigemFaturamento != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaOrigemFaturamento", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaOrigemFaturamento"].Value = cdPessoaOrigemFaturamento;
            }

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            if (cdIndicadorMoedaCompromissoCompra != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorMoedaCompromissoCompra", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorMoedaCompromissoCompra"].Value = cdIndicadorMoedaCompromissoCompra;
            }

            if (cdCompromissoCompraSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCompromissoCompraSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdCompromissoCompraSEQ"].Value = cdCompromissoCompraSEQ;
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

    public DataTable ObterListaCompromissoCompraBloqueio(Int64 cdAgenteComercialCooperativaCompromissoCompra, Int64 cdCronogramaSafraSEQ, Int64 cdIndicadorMoedaCompromissoCompra, Int64 cdCompromissoCompraSEQ, Int64 cdPessoaOrigemFaturamento)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CompromissoCompraBloqueio", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            if (cdAgenteComercialCooperativaCompromissoCompra != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialCooperativaCompromissoCompra", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialCooperativaCompromissoCompra"].Value = cdAgenteComercialCooperativaCompromissoCompra;
            }

            if (cdPessoaOrigemFaturamento != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaOrigemFaturamento", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaOrigemFaturamento"].Value = cdPessoaOrigemFaturamento;
            }

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            if (cdIndicadorMoedaCompromissoCompra != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorMoedaCompromissoCompra", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorMoedaCompromissoCompra"].Value = cdIndicadorMoedaCompromissoCompra;
            }

            if (cdCompromissoCompraSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCompromissoCompraSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdCompromissoCompraSEQ"].Value = cdCompromissoCompraSEQ;
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

    public string ExcluiCompromissoCompra(Int64 cdUsuarioUltimaAlteracao, string arCompromissoCompra)
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
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoExcluiCompromissoCompra");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_D_ExcluiCompromissoCompra";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@arCompromissoCompra", SqlDbType.VarChar);
            loSqlCommand.Parameters["@arCompromissoCompra"].Value = arCompromissoCompra;

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
            loSqlTransaction.Rollback("TransacaoExcluiCompromissoCompra");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroExclusao;
        }
    }

    public string LiberaCompromissoCompra(Int64 cdUsuarioUltimaAlteracao, string arCompromissoCompra)
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
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoLiberaCompromissoCompra");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_LiberaCompromissoCompra";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@arCompromissoCompra", SqlDbType.VarChar);
            loSqlCommand.Parameters["@arCompromissoCompra"].Value = arCompromissoCompra;

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
            loSqlTransaction.Rollback("TransacaoLiberaCompromissoCompra");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public string BloquearCompromissoCompra(Int64 cdUsuarioUltimaAlteracao, string arCompromissoCompra)
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
            loSqlTransaction = loSqlConnection.BeginTransaction("Transacaobloqueio");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_BloquearCompromissoCompra";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@arCompromissoCompra", SqlDbType.VarChar);
            loSqlCommand.Parameters["@arCompromissoCompra"].Value = arCompromissoCompra;

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
            loSqlTransaction.Rollback("Transacaobloqueio");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public string SalvaCompromissoAlteracao(Int64 cdUsuarioUltimaAlteracao, Int64 tmpCompromissoCompraSEQ, Int64 cdCompromissoCompraSEQ)
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
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoCompromisso");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_U_CompromissoCompra";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@TmpCompromissoCompraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@TmpCompromissoCompraSEQ"].Value = tmpCompromissoCompraSEQ;

            loSqlCommand.Parameters.Add("@cdCompromissoCompraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCompromissoCompraSEQ"].Value = cdCompromissoCompraSEQ;

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
            loSqlTransaction.Rollback("TransacaoCompromisso");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    private bool VerificaDisponibilidadeCompromisso(Int64 cdAgenteComercialCooperativaCompromissoCompra, Int64 cdCronogramaSafraSEQ, Int64 cdIndicadorMoedaCompromissoCompra, Int64 cdPessoaOrigemFaturamento)
    {

        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_VerificaDisponibilidadeCompromisso", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialCooperativaCompromissoCompra", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialCooperativaCompromissoCompra"].Value = cdAgenteComercialCooperativaCompromissoCompra;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorMoedaCompromissoCompra", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorMoedaCompromissoCompra"].Value = cdIndicadorMoedaCompromissoCompra;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaOrigemFaturamento", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaOrigemFaturamento"].Value = cdPessoaOrigemFaturamento;

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

    private bool VerificaTabelaPrecoCompromisso(Int64 cdAgenteComercialCooperativaCompromissoCompra, Int64 cdCronogramaSafraSEQ, Int64 cdIndicadorMoedaCompromissoCompra)
    {

        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_VerificaTabelaPrecoCompromisso", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialCooperativaCompromissoCompra", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialCooperativaCompromissoCompra"].Value = cdAgenteComercialCooperativaCompromissoCompra;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorMoedaCompromissoCompra", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorMoedaCompromissoCompra"].Value = cdIndicadorMoedaCompromissoCompra;

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

    public Int64 VerificaParametroPrecoProdutoCompromisso(Int64 cdAgenteComercialCooperativaCompromissoCompra, Int64 cdCronogramaSafraSEQ)
    {

        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_VerificaParametroPrecoProduto", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        Int32 vrQuantidade;

        vrQuantidade = 10; // Parametro Inicial

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdAgenteComercialCooperativaCompromissoCompra", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdAgenteComercialCooperativaCompromissoCompra"].Value = cdAgenteComercialCooperativaCompromissoCompra;

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

    #endregion Métodos
}
