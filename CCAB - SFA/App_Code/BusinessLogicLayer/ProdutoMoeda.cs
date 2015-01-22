using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;


/// <summary>
/// Summary description for ProdutoMoeda
/// </summary>
public class ProdutoMoeda
{
    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares

	public ProdutoMoeda()
	{
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
    }

    #region Métodos

    public string Incluir(Int64 cdProdutoSEQ, int cdIndicadorMoedaProduto, int cdIndicadorStatusProdutoMoeda, string wkProdutoMoeda, Int64 cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            Int64 cdProdutoMoedaSEQ = 0;

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;



            //Consistências:
            if (cdProdutoSEQ == 0)
            {
                return "Produto" + moPadrao.MensagemObrigatorio;
            }

            if (cdIndicadorMoedaProduto == 0)
            {
                return "Indicador" + moPadrao.MensagemObrigatorio;
            }

            if (cdIndicadorStatusProdutoMoeda == 0)
            {
                return "Situação" + moPadrao.MensagemObrigatorio;
            }

            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoProdutoMoeda");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_I_ProdutoMoeda";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

            loSqlCommand.Parameters.Add("@cdIndicadorMoedaProduto", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorMoedaProduto"].Value = cdIndicadorMoedaProduto;

            loSqlCommand.Parameters.Add("@cdIndicadorStatusProdutoMoeda", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorStatusProdutoMoeda"].Value = cdIndicadorStatusProdutoMoeda;

            if (wkProdutoMoeda.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkProdutoMoeda", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkProdutoMoeda"].Value = wkProdutoMoeda;
            }

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.Parameters.Add("@cdProdutoMoedaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdProdutoMoedaSEQ"].Direction = ParameterDirection.Output;

            loSqlCommand.ExecuteNonQuery();

            cdProdutoMoedaSEQ = Convert.ToInt64(loSqlCommand.Parameters["@cdProdutoMoedaSEQ"].Value);

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoProdutoMoeda");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string Alterar(Int64 cdProdutoMoedaSEQ, Int64 cdProdutoSEQ, int cdIndicadorMoedaProduto, int cdIndicadorStatusProdutoMoeda, string wkProdutoMoeda, Int64 cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            //Consistências:
            if (cdProdutoSEQ == 0)
            {
                return "Produto" + moPadrao.MensagemObrigatorio;
            }

            if (cdIndicadorMoedaProduto == 0)
            {
                return "Indicador" + moPadrao.MensagemObrigatorio;
            }

            if (cdIndicadorStatusProdutoMoeda == 0)
            {
                return "Situação" + moPadrao.MensagemObrigatorio;
            }

            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoProdutoMoeda");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_ProdutoMoeda";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdProdutoMoedaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdProdutoMoedaSEQ"].Value = cdProdutoMoedaSEQ;

            loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

            loSqlCommand.Parameters.Add("@cdIndicadorMoedaProduto", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorMoedaProduto"].Value = cdIndicadorMoedaProduto;

            loSqlCommand.Parameters.Add("@cdIndicadorStatusProdutoMoeda", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorStatusProdutoMoeda"].Value = cdIndicadorStatusProdutoMoeda;

            if (wkProdutoMoeda.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkProdutoMoeda", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkProdutoMoeda"].Value = wkProdutoMoeda;
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
            loSqlTransaction.Rollback("TransacaoProdutoMoeda");
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
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_ProdutoMoeda", loSqlConnection);

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

    public DataTable Obter(Int64 cdProdutoMoedaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_ProdutoMoeda", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdProdutoMoedaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdProdutoMoedaSEQ"].Value = cdProdutoMoedaSEQ;


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

    public DataTable ObterListaHistorico(Int64 cdProdutoMoedaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_ProdutoMoedaHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdProdutoMoedaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdProdutoMoedaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdProdutoMoedaSEQ"].Value = cdProdutoMoedaSEQ;
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

    public DataTable ObterHistorico(Int64 cdProdutoMoedaHistoricoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_ProdutoMoedaHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdProdutoMoedaHistoricoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdProdutoMoedaHistoricoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdProdutoMoedaHistoricoSEQ"].Value = cdProdutoMoedaHistoricoSEQ;
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

    #endregion Métodos
}
