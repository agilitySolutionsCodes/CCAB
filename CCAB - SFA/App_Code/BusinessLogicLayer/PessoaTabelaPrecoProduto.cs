using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for PessoaTabelaPrecoProduto
/// </summary>
public class PessoaTabelaPrecoProduto
{
    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares

	public PessoaTabelaPrecoProduto()
	{
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
    }

    #region Métodos

    public string Incluir(Int64 cdPessoaSEQ, Int64 cdCronogramaSafraSEQ, Int64 cdProdutoSEQ, Int64 cdCronogramaSafraVencimentoSEQ, double vrDolarPessoaTabelaPrecoProduto, double vrRealPessoaTabelaPrecoProduto, double pcDescontoPontualidadePessoaTabelaPrecoProduto, string wkPessoaTabelaPrecoProduto, Int64 cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            Int64 cdPessoaTabelaPrecoProdutoSEQ = 0;

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;



            //Consistências
            if (cdPessoaSEQ == 0)
            {
                return "Pessoa" + moPadrao.MensagemObrigatorio;
            }

            if (cdCronogramaSafraSEQ == 0)
            {
                return "Cronograma" + moPadrao.MensagemObrigatorio;
            }

            if (cdProdutoSEQ == 0)
            {
                return "Produto" + moPadrao.MensagemObrigatorio;
            }

            if (cdCronogramaSafraVencimentoSEQ == 0)
            {
                return "Vencimento" + moPadrao.MensagemObrigatorio;
            }

            if (vrDolarPessoaTabelaPrecoProduto == 0)
            {
                return "Dólar" + moPadrao.MensagemObrigatorio;
            }

            if (vrRealPessoaTabelaPrecoProduto == 0)
            {
                return "Real" + moPadrao.MensagemObrigatorio;
            }

            if (pcDescontoPontualidadePessoaTabelaPrecoProduto == 0)
            {
                return "Desconto" + moPadrao.MensagemObrigatorio;
            }

            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoPessoaTabelaPrecoProduto");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_I_PessoaTabelaPrecoProduto";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

            loSqlCommand.Parameters.Add("@vrDolarPessoaTabelaPrecoProduto", SqlDbType.Float);
            loSqlCommand.Parameters["@vrDolarPessoaTabelaPrecoProduto"].Value = vrDolarPessoaTabelaPrecoProduto;

            loSqlCommand.Parameters.Add("@vrRealPessoaTabelaPrecoProduto", SqlDbType.Float);
            loSqlCommand.Parameters["@vrRealPessoaTabelaPrecoProduto"].Value = vrRealPessoaTabelaPrecoProduto;

            loSqlCommand.Parameters.Add("@pcDescontoPontualidadePessoaTabelaPrecoProduto", SqlDbType.Float);
            loSqlCommand.Parameters["@pcDescontoPontualidadePessoaTabelaPrecoProduto"].Value = pcDescontoPontualidadePessoaTabelaPrecoProduto;

            if (wkPessoaTabelaPrecoProduto.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkPessoaTabelaPrecoProduto", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkPessoaTabelaPrecoProduto"].Value = wkPessoaTabelaPrecoProduto;
            }

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.Parameters.Add("@cdPessoaTabelaPrecoProdutoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaTabelaPrecoProdutoSEQ"].Direction = ParameterDirection.Output;


            loSqlCommand.ExecuteNonQuery();

            cdPessoaTabelaPrecoProdutoSEQ = Convert.ToInt64(loSqlCommand.Parameters["@cdPessoaTabelaPrecoProdutoSEQ"].Value);

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoPessoaTabelaPrecoProduto");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string Alterar(Int64 cdPessoaTabelaPrecoProdutoSEQ, Int64 cdPessoaSEQ, Int64 cdCronogramaSafraSEQ, Int64 cdProdutoSEQ, Int64 cdCronogramaSafraVencimentoSEQ, double vrDolarPessoaTabelaPrecoProduto, double vrRealPessoaTabelaPrecoProduto, double pcDescontoPontualidadePessoaTabelaPrecoProduto, string wkPessoaTabelaPrecoProduto, Int64 cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            //Consistências
            if (cdPessoaTabelaPrecoProdutoSEQ == 0)
            {
                return "Código" + moPadrao.MensagemObrigatorio;
            }

            if (cdPessoaSEQ == 0)
            {
                return "Pessoa" + moPadrao.MensagemObrigatorio;
            }

            if (cdCronogramaSafraSEQ == 0)
            {
                return "Cronograma" + moPadrao.MensagemObrigatorio;
            }

            if (cdProdutoSEQ == 0)
            {
                return "Produto" + moPadrao.MensagemObrigatorio;
            }

            if (cdCronogramaSafraVencimentoSEQ == 0)
            {
                return "Vencimento" + moPadrao.MensagemObrigatorio;
            }

            if (vrDolarPessoaTabelaPrecoProduto == 0)
            {
                return "Dólar" + moPadrao.MensagemObrigatorio;
            }

            if (vrRealPessoaTabelaPrecoProduto == 0)
            {
                return "Real" + moPadrao.MensagemObrigatorio;
            }

            if (pcDescontoPontualidadePessoaTabelaPrecoProduto == 0)
            {
                return "Desconto" + moPadrao.MensagemObrigatorio;
            }

            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoPessoaTabelaPrecoProduto");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_PessoaTabelaPrecoProduto";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdPessoaTabelaPrecoProdutoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaTabelaPrecoProdutoSEQ"].Value = cdPessoaTabelaPrecoProdutoSEQ;

            loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

            loSqlCommand.Parameters.Add("@vrDolarPessoaTabelaPrecoProduto", SqlDbType.Float);
            loSqlCommand.Parameters["@vrDolarPessoaTabelaPrecoProduto"].Value = vrDolarPessoaTabelaPrecoProduto;

            loSqlCommand.Parameters.Add("@vrRealPessoaTabelaPrecoProduto", SqlDbType.Float);
            loSqlCommand.Parameters["@vrRealPessoaTabelaPrecoProduto"].Value = vrRealPessoaTabelaPrecoProduto;

            loSqlCommand.Parameters.Add("@pcDescontoPontualidadePessoaTabelaPrecoProduto", SqlDbType.Float);
            loSqlCommand.Parameters["@pcDescontoPontualidadePessoaTabelaPrecoProduto"].Value = pcDescontoPontualidadePessoaTabelaPrecoProduto;

            if (wkPessoaTabelaPrecoProduto.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkPessoaTabelaPrecoProduto", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkPessoaTabelaPrecoProduto"].Value = wkPessoaTabelaPrecoProduto;
            }

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
            loSqlTransaction.Rollback("TransacaoPessoaTabelaPrecoProduto");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public string Salvar(ListItemCollection lsLista, Int64 cdAgenteComercialCooperativaSEQ, Int64 cdCronogramaSafraPrecoSEQ, Int64 cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            string lsValue;
            string lsText;
            string[] lsArray;


            Int64 cdPessoaTabelaPrecoProdutoSEQ;
            Int64 cdPessoaSEQ = 0;
            Int64 cdCronogramaSafraSEQ = 0;
            Int64 cdProdutoSEQ;
            Int64 cdCronogramaSafraVencimentoSEQ;
            int cdMoeda;
            decimal vrRealPessoaTabelaPrecoProduto = 0;
            decimal vrDolarPessoaTabelaPrecoProduto = 0;

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

            // Verifica se a tabela de preco pode ser Salva
            String lbDisponivel = "";
            lbDisponivel = VerificaDisponibilidadeColunasPreco(cdAgenteComercialCooperativaSEQ, cdCronogramaSafraPrecoSEQ);

            if (lbDisponivel == "")
            {
                return "Os Compromissos para este Agente/Safra já foram liberados, Alteração não permitida.";
            }

            //Abro conexão e transação
            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TrTabelaPrecoProduto");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            foreach (ListItem itItem in lsLista)
            {
                lsValue = itItem.Value;
                lsText = itItem.Text;

                lsArray = lsText.Split(new char[] { '-' });

                cdPessoaTabelaPrecoProdutoSEQ = Convert.ToInt64(lsArray[0].ToString());
                cdPessoaSEQ = Convert.ToInt64(lsArray[1].ToString());
                cdCronogramaSafraSEQ = Convert.ToInt64(lsArray[2].ToString());
                cdProdutoSEQ = Convert.ToInt64(lsArray[3].ToString());
                cdCronogramaSafraVencimentoSEQ = Convert.ToInt64(lsArray[4].ToString());
                cdMoeda = Convert.ToInt32(lsArray[5].ToString());

                if (cdMoeda == 1) //Reais
                {
                    vrRealPessoaTabelaPrecoProduto= Convert.ToDecimal(lsValue);
                }
                else
                {
                    vrDolarPessoaTabelaPrecoProduto= Convert.ToDecimal(lsValue);

                    loSqlCommand.Parameters.Clear();

                    if (cdPessoaTabelaPrecoProdutoSEQ == 0) //Inclusão
                    {
                        loSqlCommand.CommandText = "SP_I_PessoaTabelaPrecoProduto";
                        loSqlCommand.CommandType = CommandType.StoredProcedure;


                        loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

                        loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

                        loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

                        loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

                        loSqlCommand.Parameters.Add("@vrRealPessoaTabelaPrecoProduto", SqlDbType.Float);
                        loSqlCommand.Parameters["@vrRealPessoaTabelaPrecoProduto"].Value = vrRealPessoaTabelaPrecoProduto;

                        loSqlCommand.Parameters.Add("@vrDolarPessoaTabelaPrecoProduto", SqlDbType.Float);
                        loSqlCommand.Parameters["@vrDolarPessoaTabelaPrecoProduto"].Value = vrDolarPessoaTabelaPrecoProduto;
                      
                        loSqlCommand.Parameters.Add("@pcDescontoPontualidadePessoaTabelaPrecoProduto", SqlDbType.Float);
                        loSqlCommand.Parameters["@pcDescontoPontualidadePessoaTabelaPrecoProduto"].Value = 0;

                        loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

                        loSqlCommand.Parameters.Add("@cdPessoaTabelaPrecoProdutoSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdPessoaTabelaPrecoProdutoSEQ"].Direction = ParameterDirection.Output;


                    }
                    else //Alteração
                    {
                        loSqlCommand.CommandText = "SP_U_PessoaTabelaPrecoProduto";
                        loSqlCommand.CommandType = CommandType.StoredProcedure;

                        loSqlCommand.Parameters.Add("@cdPessoaTabelaPrecoProdutoSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdPessoaTabelaPrecoProdutoSEQ"].Value = cdPessoaTabelaPrecoProdutoSEQ;

                        loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

                        loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

                        loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

                        loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

                        loSqlCommand.Parameters.Add("@vrRealPessoaTabelaPrecoProduto", SqlDbType.Float);
                        loSqlCommand.Parameters["@vrRealPessoaTabelaPrecoProduto"].Value = vrRealPessoaTabelaPrecoProduto;

                        loSqlCommand.Parameters.Add("@vrDolarPessoaTabelaPrecoProduto", SqlDbType.Float);
                        loSqlCommand.Parameters["@vrDolarPessoaTabelaPrecoProduto"].Value = vrDolarPessoaTabelaPrecoProduto;

                        loSqlCommand.Parameters.Add("@pcDescontoPontualidadePessoaTabelaPrecoProduto", SqlDbType.Float);
                        loSqlCommand.Parameters["@pcDescontoPontualidadePessoaTabelaPrecoProduto"].Value = 0;

                        loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
                        loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

                    }



                    loSqlCommand.ExecuteNonQuery();

                }
   


            }
     
            // Chama Recalculo do Preço.
            loSqlCommand.Parameters.Clear();
            loSqlCommand.CommandText = "SP_J_AtualizaTabelaPreco";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            loSqlCommand.ExecuteNonQuery();

            //---------------------


            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrTabelaPrecoProduto");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public DataTable ObterLista()
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PessoaTabelaPrecoProduto", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


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

    public DataTable ObterListaGeral(Int64 cdPessoaSEQ, Int64 cdCronogramaSafraSEQ, Int64 cdTipoProduto)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PessoaTabelaPrecoProduto_Geral", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdTipoProduto", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdTipoProduto"].Value = cdTipoProduto;

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

    public string Excluir(Int64 cdPessoaSEQ, Int64 cdCronogramaSafraSEQ)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            // Verifica se a tabela de preco pode ser Excluida
            Boolean lbDisponivel = false;
            lbDisponivel = VerificaDisponibilidadeExclusaoPreco(cdPessoaSEQ, cdCronogramaSafraSEQ);

            if (lbDisponivel == false)
            {
                return "Compromissos de Compra já cadastrados para este Agente/Safra, Exclusão não permitida.";
            }

            //Abro conexão e transação
            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TrPessoaTabelaPrecoProduto");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_D_ExcluiPessoaTabelaPrecoProduto";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrPessoaTabelaPrecoProduto");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }
    
    public DataTable Obter(Int64 cdPessoaTabelaPrecoProdutoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_PessoaTabelaPrecoProduto", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdPessoaTabelaPrecoProdutoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaTabelaPrecoProdutoSEQ"].Value = cdPessoaTabelaPrecoProdutoSEQ;


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

    public DataTable ObterListaHistorico(Int64 cdPessoaTabelaPrecoProdutoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_PessoaTabelaPrecoProdutoHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdPessoaTabelaPrecoProdutoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaTabelaPrecoProdutoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaTabelaPrecoProdutoSEQ"].Value = cdPessoaTabelaPrecoProdutoSEQ;
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

    public DataTable ObterHistorico(Int64 cdPessoaTabelaPrecoProdutoHistoricoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_PessoaTabelaPrecoProdutoHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdPessoaTabelaPrecoProdutoHistoricoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaTabelaPrecoProdutoHistoricoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaTabelaPrecoProdutoHistoricoSEQ"].Value = cdPessoaTabelaPrecoProdutoHistoricoSEQ;
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

    public String VerificaDisponibilidadeColunasPreco(Int64 cdPessoaSEQ, Int64 cdCronogramaSafraSEQ)
    {
        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_VerificaDisponibilidadeColunaPreco", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            if (loDataTable.Rows.Count > 0)
            {
                return loDataTable.Rows[0]["dsDisponibilidadeMoeda"].ToString();
            }
            else
            {
                return "";
            }
        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }

    }

    public Boolean VerificaDisponibilidadeExclusaoPreco(Int64 cdPessoaSEQ, Int64 cdCronogramaSafraSEQ)
    {
        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_VerificaDisponibilidadeExclusaoPreco", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

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
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }

    }

    public Boolean ExistePrecoProduto(Int64 cdCronogramaSafraSEQ, Int64 cdPessoaSEQ)
    {
        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_TABELAPRECOPRODUTO", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

        loSqlDataAdapter.Fill(loDataTable);

        loSqlConnection.Close();
        loSqlConnection = null;

        return Convert.ToBoolean(loDataTable.Rows[0][0]);  

    }

    #endregion Métodos
}
